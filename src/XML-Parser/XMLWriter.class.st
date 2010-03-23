Class {
	#name : #XMLWriter,
	#superclass : #Object,
	#instVars : [
		'stream',
		'openTags',
		'canonical',
		'currentIndent',
		'indentString',
		'newLinesAllowed',
		'nestedScopes'
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
	^ canonical ifNil: [canonical := false]
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
	self nestedScopes leaveScope.
	self endTag: anElementName.
]

{ #category : #'writing xml' }
XMLWriter >> endEmptyTag: aTagName [
	self openTags closeTag: aTagName.
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
XMLWriter >> endTag: aTagName [
	self outdent.
	self openTags closeTag: aTagName.
	self stream
		nextPutAll: '</';
		nextPutAll: aTagName.
	self endTag.

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

{ #category : #private }
XMLWriter >> nestedScopes [
	^ nestedScopes ifNil: [nestedScopes := XMLNestedNamespaceScopes new]
]

{ #category : #accessing }
XMLWriter >> newLinesAllowed [
	^ newLinesAllowed ifNil: [newLinesAllowed := false]
]

{ #category : #accessing }
XMLWriter >> newLinesAllowed: aBoolean [
	newLinesAllowed := aBoolean
]

{ #category : #private }
XMLWriter >> openTags [
	^ openTags ifNil: [openTags := XMLOpenTags new]
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

{ #category : #accessing }
XMLWriter >> prettyPrint [
	self indentString: '    '.
	self newLinesAllowed: true.
]

{ #category : #private }
XMLWriter >> putAsXMLString: aValue [
	self stream nextPut: $".
	self writeXmlEncoded: aValue.
	self stream nextPut: $"
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
	attributeList printXMLOn: self.
]

{ #category : #'writing xml' }
XMLWriter >> startElement: anElementName attributeList: anAttributeList namespaces: aNamespaceDictionary [
	self startTag: anElementName.
	self nestedScopes enterScope.

	aNamespaceDictionary keysAndValuesDo: [:name :uri |
		name splitQualifiedNameInto: [:xmlns :prefix |
			(prefix = 'xmlns')
				ifTrue: [
					(self nestedScopes defaultNamespace = uri)
						ifFalse: [self xmlns: 'xmlns' uri: uri]]
				ifFalse: [
					(self nestedScopes isPrefix: prefix mappedTo: uri)
						ifFalse: [self xmlns: prefix uri: uri]]]].

	anAttributeList printXMLOn: self.
]

{ #category : #'private tags' }
XMLWriter >> startPI: identifier [
	self stream
		nextPutAll: '<?';
		nextPutAll: identifier;
		space
]

{ #category : #'writing xml' }
XMLWriter >> startTag: aTagName [
	self writeIndent.
	self stream
		nextPut: $<;
		nextPutAll: aTagName.
	"self canonical
		ifFalse: [self stream space]."
	self openTags openTag: aTagName
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
XMLWriter >> xmlns: aNamespace uri: aUri [
	self nestedScopes declareNamespace: aNamespace uri: aUri.

	self
		attribute:
			(aNamespace = 'xmlns'
				ifTrue: ['xmlns']
				ifFalse: ['xmlns:', aNamespace])
		value: aUri
]
