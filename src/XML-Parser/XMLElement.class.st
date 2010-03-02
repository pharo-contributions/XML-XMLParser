Class {
	#name : #XMLElement,
	#superclass : #XMLNodeWithElements,
	#instVars : [
		'name',
		'localName',
		'attributes'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #'instance creation' }
XMLElement class >> named: aString [
	^ self new name: aString
]

{ #category : #'instance creation' }
XMLElement class >> named: aString attributes: attributeList [
	^ self new
		name: aString;
		setAttributes: attributeList
]

{ #category : #'instance creation' }
XMLElement class >> named: aString attributes: attributeList contentString: aContentString [
	^ self new
		name: aString;
		setAttributes: attributeList;
		contentString: aContentString
]

{ #category : #'instance creation' }
XMLElement class >> named: aString contentString: aContentString [
	^ self new
		name: aString;
		contentString: aContentString
]

{ #category : #'instance creation' }
XMLElement class >> named: aString namespace: ns uri: uri attributes: attributeList [
	^ self new
		name: aString namespace: ns uri: uri;
		setAttributes: attributeList
]

{ #category : #accessing }
XMLElement >> @ aSymbolOrAString [
	"shorthand form"
	^ self at: aSymbolOrAString
]

{ #category : #accessing }
XMLElement >> addContent: contentString [
	"Adds a string or string node. If 'self nodes last' is already a string node, then
	contentString gets concatenated to it."

	(self hasContents and: [self nodes last isText])
		ifTrue: [self nodes last addContent: contentString]
		ifFalse: [self addNode: (XMLStringNode string: contentString)]
]

{ #category : #accessing }
XMLElement >> allAttributeAssociations [
	^ self attributes associations
]

{ #category : #accessing }
XMLElement >> allAttributes [
	^ self attributes keys
]

{ #category : #accessing }
XMLElement >> at: aSymbol [

    ^ self at: aSymbol ifAbsent: ['']

]

{ #category : #accessing }
XMLElement >> at: aSymbol ifAbsent: aBlock [

    ^ self attributeAt: aSymbol ifAbsent: aBlock
]

{ #category : #accessing }
XMLElement >> at: aSymbol put: aValue [

    ^ self attributeAt: aSymbol put: aValue
]

{ #category : #accessing }
XMLElement >> attributeAt: attributeNameAsSymbolOrString [
	^self attributeAt: attributeNameAsSymbolOrString ifAbsent: [nil]
]

{ #category : #accessing }
XMLElement >> attributeAt: attributeNameAsSymbolOrString ifAbsent: aBlock [
	^self attributes at: attributeNameAsSymbolOrString asSymbol ifAbsent: [^aBlock value]
]

{ #category : #accessing }
XMLElement >> attributeAt: aSymbol put: aValue [
	^ self attributes at: aSymbol asSymbol put: aValue
]

{ #category : #accessing }
XMLElement >> attributes [
	^ attributes ifNil: [attributes := IdentityDictionary new]
]

{ #category : #accessing }
XMLElement >> characterData [
	^ self contentString
]

{ #category : #accessing }
XMLElement >> contentString [
	| firstContentNode |

	firstContentNode := self elementsAndContents at: 1 ifAbsent: [^ ''].
	^ firstContentNode isText
		ifTrue: [firstContentNode string]
		ifFalse: ['']
]

{ #category : #accessing }
XMLElement >> contentString: aString [
	self
		removeNodes;
		addContent: aString
]

{ #category : #accessing }
XMLElement >> contentStringAt: aSymbol [
	^ (self elementAt: aSymbol ifAbsent: [^ '']) contentString
]

{ #category : #accessing }
XMLElement >> contents [
	^ self nodes select: [:each | each isText]
]

{ #category : #enumerating }
XMLElement >> contentsDo: aBlock [
	self nodesDo: [:each | each isText ifTrue: [aBlock value: each]]
]

{ #category : #accessing }
XMLElement >> elementsAndContents [
	^ self nodes select: [:each | each isTagOrText]
]

{ #category : #enumerating }
XMLElement >> elementsAndContentsDo: aBlock [
	self nodesDo: [:each | each isTagOrText ifTrue: [aBlock value: each]]
]

{ #category : #testing }
XMLElement >> hasAttributes [
	^ self attributes notEmpty
]

{ #category : #testing }
XMLElement >> hasContents [
	^ self contents notEmpty
]

{ #category : #testing }
XMLElement >> hasPrefix [
	^ self localName ~~ self tag
]

{ #category : #searching }
XMLElement >> ifNamed: aSymbol do: aOneArgumentBlock [
	"If the receiver tag equals aSymbol, evaluate aOneArgumentBlock with the receiver"

	(self isNamed: aSymbol)
		ifTrue: [aOneArgumentBlock valueWithPossibleArgument: self]

]

{ #category : #testing }
XMLElement >> includesAttribute: aSymbol [
	^ self attributes includesKey: aSymbol asSymbol
]

{ #category : #testing }
XMLElement >> isNamed: aSymbol [
	^ (self localName == aSymbol asSymbol)
		or: [self tag == aSymbol asSymbol]
]

{ #category : #testing }
XMLElement >> isNamedAny: aSymbolArray [
	^ aSymbolArray anySatisfy: [:each | self isNamed: each]
]

{ #category : #testing }
XMLElement >> isTag [
	^ true
]

{ #category : #namespace }
XMLElement >> localName [
	^ localName ifNil: [#'']
]

{ #category : #accessing }
XMLElement >> name [
	^ self qualifiedName
]

{ #category : #accessing }
XMLElement >> name: aSymbol [
	self
		name: aSymbol
		namespace: self namespace
		uri: self namespaceURI
]

{ #category : #accessing }
XMLElement >> name: aLocalName namespace: aPrefix uri: aUri [
	name :=
		(aPrefix isEmptyOrNil
			ifTrue: [aLocalName]
			ifFalse: [aPrefix asString, ':', aLocalName asString]) asSymbol.
	localName := aLocalName asSymbol.
	super namespace: aPrefix uri: aUri.

	self notifyParentOfChange.
]

{ #category : #accessing }
XMLElement >> namespace: aPrefix uri: aUri [
	self
		name: self localName
		namespace: aPrefix
		uri: aUri
]

{ #category : #accessing }
XMLElement >> nextElement [
	^ self hasParent ifTrue: [self parent elementAfter: self]
]

{ #category : #private }
XMLElement >> notifyParentOfChange [
	self hasParent ifFalse: [^ self].

	self parent changedChildElement: self.
]

{ #category : #accessing }
XMLElement >> previousElement [
	^ self hasParent ifTrue: [self parent elementBefore: self]
]

{ #category : #printing }
XMLElement >> printXMLOn: writer [
	writer startElement: self name attributeList: self attributes.
	(writer canonical not
		and: [self isEmpty and: [self attributes isEmpty not]])
		ifTrue: [writer endEmptyTag: self name]
		ifFalse: [
			writer endTag.
			super printXMLOn: writer.
			writer endTag: self name]
]

{ #category : #namespace }
XMLElement >> qualifiedName [
	^ name ifNil: [#'']
]

{ #category : #searching }
XMLElement >> recurse: aBlock [
	"See superclass version."

	aBlock valueWithPossibleArgument: self.

	super recurse: aBlock.
]

{ #category : #searching }
XMLElement >> recurseUntilTrue: aBlock [
	"See superclass version."

	(aBlock valueWithPossibleArgument: self)
		ifTrue: [^ self].

	^ super recurseUntilTrue: aBlock.
]

{ #category : #accessing }
XMLElement >> removeAttribute: aSymbol [
	^ self attributes removeKey: aSymbol
]

{ #category : #initialize }
XMLElement >> setAttributes: aDictionary [
	self attributes removeAll.
	aDictionary keysAndValuesDo: [:attrName :attrValue | self at: attrName put: attrValue].
]

{ #category : #accessing }
XMLElement >> tag [
	^ self name
]

{ #category : #accessing }
XMLElement >> valueFor: aSymbol [
	self deprecated: 'use #at: as a shortcut instead'.

	^ self at: aSymbol.
]

{ #category : #accessing }
XMLElement >> valueFor: aSymbol ifAbsent: aBlock [ 
	self deprecated: 'use #at:ifAbsent: as a shortcut instead'.

	^ self at: aSymbol ifAbsent: aBlock
]
