Class {
	#name : #XMLWriter,
	#superclass : #Object,
	#instVars : [
		'stream',
		'stack',
		'scoping',
		'canonical',
		'currentIndent',
		'indentString',
		'newLinesAllowed'
	],
	#classVars : [
		'XMLTranslation',
		'XMLTranslationMap'
	],
	#category : #'XML-Parser-Parser'
}

{ #category : #'class initialization' }
XMLWriter class >> initialize [
	"XMLWriter initialize"

	XMLTranslation := Dictionary new.
	XMLTranslation
		at: Character cr put: '&#13;';
		at: Character lf put: '&#10;';
		at: Character tab put: '&#9;';
		at: $& put: '&amp;';
		at: $< put: '&lt;';
		at: $> put: '&gt;';
"		at: $' put: '&apos;'; "
		at: $" put: '&quot;'.
	XMLTranslationMap := ByteArray new: 256.
	XMLTranslation keysDo:[:ch| XMLTranslationMap at: ch asciiValue+1 put: 1].

]

{ #category : #'instance creation' }
XMLWriter class >> on: aStream [
	^self basicNew initialize stream: aStream
]

{ #category : #'writing xml' }
XMLWriter >> attribute: attributeName value: attributeValue [
	self stream
		space;
		nextPutAll: attributeName.
	self
		eq;
		putAsXMLString: attributeValue
]

{ #category : #accessing }
XMLWriter >> canonical [
	^canonical
]

{ #category : #accessing }
XMLWriter >> canonical: aBoolean [
	canonical := aBoolean
]

{ #category : #'writing xml' }
XMLWriter >> cdata: aString [
	self startCData.
	self stream nextPutAll: aString.
	self endCData
]

{ #category : #'writing xml' }
XMLWriter >> comment: aString [
	self startComment.
	self stream nextPutAll: aString.
	self endComment
]

{ #category : #private }
XMLWriter >> cr [
	self newLinesAllowed ifTrue: [self stream cr].
]

{ #category : #namespaces }
XMLWriter >> declareNamespace: ns uri: uri [
	self scoping declareNamespace: ns uri: uri
]

{ #category : #'private tags' }
XMLWriter >> endCData [
	self stream nextPutAll: ']]>'.
	self cr.
]

{ #category : #'private tags' }
XMLWriter >> endComment [
	self stream nextPutAll: ' -->'.
	self cr.
]

{ #category : #'writing dtd' }
XMLWriter >> endDecl: type [
	self endTag
]

{ #category : #'writing dtd' }
XMLWriter >> endDeclaration [
	self stream
		cr;
		nextPut: $].
	self endTag
]

{ #category : #'writing xml' }
XMLWriter >> endElement: anElementName [
	self scoping leaveScope.
	self endTag: anElementName.
]

{ #category : #'writing xml' }
XMLWriter >> endEmptyTag: tagName [
	self popTag: tagName.
	self stream nextPutAll: '/>'.
	self canonical
		ifFalse: [self stream space].
	self cr.
]

{ #category : #'private tags' }
XMLWriter >> endPI [
	self stream nextPutAll: ' ?>'.
	self cr.
]

{ #category : #'writing xml' }
XMLWriter >> endTag [
	self stream nextPutAll: '>'.
	self cr.
	self indent.
	"self canonical
		ifFalse: [self stream space]"
]

{ #category : #'writing xml' }
XMLWriter >> endTag: tagName [
	self outdent.
	self popTag: tagName.
	self stream
		nextPutAll: '</';
		nextPutAll: tagName.
	self endTag.

]

{ #category : #namespaces }
XMLWriter >> enterScope [
	self scoping enterScope
]

{ #category : #private }
XMLWriter >> eq [
	self stream nextPut: $=
]

{ #category : #'writing xml' }
XMLWriter >> flush [
	self stream flush
]

{ #category : #private }
XMLWriter >> indent [
	currentIndent
		ifNotNil: [currentIndent := currentIndent +1]
]

{ #category : #accessing }
XMLWriter >> indentString: aString [
	currentIndent := 0.
	indentString := aString
]

{ #category : #accessing }
XMLWriter >> indentTab [
	self indentString: (String with: Character tab)
]

{ #category : #initialize }
XMLWriter >> initialize [
	stack := OrderedCollection new.
	canonical := false.
	scoping := XMLNamespaceScopeStack new.
	newLinesAllowed := false
]

{ #category : #namespaces }
XMLWriter >> leaveScope [
	self scoping leaveScope
]

{ #category : #accessing }
XMLWriter >> newLinesAllowed [
	^ newLinesAllowed
]

{ #category : #accessing }
XMLWriter >> newLinesAllowed: aBoolean [
	newLinesAllowed := aBoolean
]

{ #category : #private }
XMLWriter >> outdent [
	currentIndent
		ifNotNil: [
			currentIndent := currentIndent-1.
			self writeIndent.
			currentIndent := currentIndent-1.]
]

{ #category : #'writing xml' }
XMLWriter >> pcData: aString [
	self writeIndent.
	self writeXmlEncoded: aString.
	self cr.
]

{ #category : #'writing xml' }
XMLWriter >> pi: piTarget data: piData [
	self startPI: piTarget.
	self stream nextPutAll: piData.
	self endPI
]

{ #category : #private }
XMLWriter >> popTag: tagName [
	| stackTop |
	stackTop := self stack isEmpty
		ifTrue: ['<empty>']
		ifFalse: [self stack last].
	^stackTop = tagName
		ifTrue: [self stack removeLast]
		ifFalse: [self error: 'Closing tag "' , tagName , '" does not match "' , stackTop]
]

{ #category : #accessing }
XMLWriter >> prettyPrint [
	self indentString: '    '.
	self newLinesAllowed: true.
]

{ #category : #private }
XMLWriter >> pushTag: tagName [
	self stack add: tagName
]

{ #category : #private }
XMLWriter >> putAsXMLString: aValue [
	self stream nextPut: $".
	self writeXmlEncoded: aValue.
	self stream nextPut: $"
]

{ #category : #private }
XMLWriter >> scoping [
	^ scoping
]

{ #category : #private }
XMLWriter >> stack [
	^stack
]

{ #category : #'private tags' }
XMLWriter >> startCData [
	self stream nextPutAll: '<![CDATA['
]

{ #category : #'private tags' }
XMLWriter >> startComment [
	self stream nextPutAll: '<-- '
]

{ #category : #'writing dtd' }
XMLWriter >> startDecl: type [
	self stream
		nextPutAll: '<!';
		nextPutAll: type asUppercase;
		space
]

{ #category : #'writing dtd' }
XMLWriter >> startDecl: type named: aString [
	self stream
		nextPutAll: '<!';
		nextPutAll: type asUppercase;
		space;
		nextPutAll: aString;
		space
]

{ #category : #'writing dtd' }
XMLWriter >> startDeclaration: dtdName [
	self startDecl: 'DOCTYPE' named: dtdName.
	self stream
		nextPut: $[;
		cr
]

{ #category : #'writing xml' }
XMLWriter >> startElement: elementName attributeList: attributeList [
	"self canonical
		ifFalse: [self stream cr]."
	self startTag: elementName.
	attributeList keys asSortedCollection do: [:key |
		self attribute: key value: (attributeList at: key)]
]

{ #category : #'writing xml' }
XMLWriter >> startElement: elementName attributeList: attributeList scope: namespaceScope [
	self startTag: elementName.
	self scoping enterScope.

	namespaceScope bindingsDo: [:namespace :uri |
		(self scoping isNamespace: namespace boundTo: uri)
			ifFalse: [self xmlns: namespace uri: uri]].

	(namespaceScope defaultNamespace ~= self scoping defaultNamespace)
		ifTrue: [self xmlns: nil uri: namespaceScope defaultNamespace].

	attributeList keys asSortedCollection do: [:key |
		self attribute: key value: (attributeList at: key)]
]

{ #category : #'private tags' }
XMLWriter >> startPI: identifier [
	self stream
		nextPutAll: '<?';
		nextPutAll: identifier;
		space
]

{ #category : #'writing xml' }
XMLWriter >> startTag: tagName [
	self writeIndent.
	self stream
		nextPut: $<;
		nextPutAll: tagName.
	"self canonical
		ifFalse: [self stream space]."
	self pushTag: tagName
]

{ #category : #accessing }
XMLWriter >> stream [
	^stream
]

{ #category : #accessing }
XMLWriter >> stream: aStream [
	stream := aStream
]

{ #category : #private }
XMLWriter >> writeIndent [
	currentIndent ifNotNil: [
		currentIndent timesRepeat: [self stream nextPutAll: indentString]]
]

{ #category : #private }
XMLWriter >> writeXmlEncoded: aString [
	| lastIndex nextIndex |
	lastIndex := 1.
	"Unroll the first search to avoid copying"
	nextIndex := String findFirstInString: aString inSet: XMLTranslationMap startingAt: lastIndex.
	nextIndex = 0 ifTrue:[self stream nextPutAll: aString. ^ self].
	[self stream nextPutAll: (aString copyFrom: lastIndex to: nextIndex-1).
	self stream nextPutAll: (XMLTranslation at: (aString at: nextIndex)).
	lastIndex := nextIndex + 1.
	nextIndex := String findFirstInString: aString inSet: XMLTranslationMap startingAt: lastIndex.
	nextIndex = 0] whileFalse.
	self stream nextPutAll: (aString copyFrom: lastIndex to: aString size).
]

{ #category : #'writing xml' }
XMLWriter >> xmlDeclaration: versionString encoding: encodingString [
	self canonical
		ifFalse: [
			self
				startPI: 'xml';
				attribute: 'version' value: versionString;
				attribute: 'encoding' value: encodingString;
				endPI.
			self stream flush]
]

{ #category : #'writing xml' }
XMLWriter >> xmlns: namespace uri: uri [
	self declareNamespace: namespace uri: uri.

	self
		attribute: (namespace ifNil: ['xmlns'] ifNotNil: ['xmlns:', namespace])
		value: uri
]
