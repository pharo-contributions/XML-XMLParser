Class {
	#name : #XMLElement,
	#superclass : #XMLNodeWithElements,
	#instVars : [
		'name',
		'attributes'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #'instance creation' }
XMLElement class >> named: aString [
	^self new name: aString
]

{ #category : #'instance creation' }
XMLElement class >> named: aString attributes: attributeList [
	^self new
		name: aString;
		setAttributes: attributeList
]

{ #category : #'instance creation' }
XMLElement class >> named: aString attributes: attributeList contentString: aContentString [
	^self new
		name: aString;
		setAttributes: attributeList;
		contentString: aContentString
]

{ #category : #'instance creation' }
XMLElement class >> named: aString contentString: aContentString [
	^self new
		name: aString;
		contentString: aContentString
]

{ #category : #'instance creation' }
XMLElement class >> named: aString namespace: ns uri: uri attributes: attributeList [
	^self new
		name: aString;
		namespace: ns uri: uri;
		setAttributes: attributeList
]

{ #category : #comparing }
XMLElement >> = anObject [

	^ (#(name attributes) allSatisfy: [:selector |
		(anObject respondsTo: selector)
			and: [(self perform: selector) = (anObject perform: selector)]])
		and: [super = anObject]
]

{ #category : #accessing }
XMLElement >> @ aSymbol [
	"shorthand form"
	^ self at: aSymbol 
]

{ #category : #accessing }
XMLElement >> addContent: contentString [
	self addNode: (XMLStringNode string: contentString)
]

{ #category : #accessing }
XMLElement >> allAttributes [
	^ self attributes asOrderedCollection
]

{ #category : #accessing }
XMLElement >> at: aSymbol [
    ^ self attributeAt: aSymbol ifAbsent: ['']

]

{ #category : #accessing }
XMLElement >> attributeAt: attributeName [
	^self attributeAt: attributeName ifAbsent: [nil]
]

{ #category : #accessing }
XMLElement >> attributeAt: attributeName ifAbsent: aBlock [
	^self attributes at: attributeName ifAbsent: [^aBlock value]
]

{ #category : #accessing }
XMLElement >> attributeAt: attributeName put: attributeValue [
	self attributes at: attributeName asSymbol put: attributeValue
]

{ #category : #accessing }
XMLElement >> attributes [
	^attributes ifNil: [attributes := Dictionary new]
]

{ #category : #accessing }
XMLElement >> characterData [
	^self contentString
]

{ #category : #accessing }
XMLElement >> contentString [
	| contentElements |
	contentElements := self elementsAndContents.
	^(contentElements size > 0
		and: [contentElements first isText])
		ifTrue: [contentElements first string]
		ifFalse: ['']
]

{ #category : #accessing }
XMLElement >> contentString: aString [

	self
		removeAll;
		addContent: aString
]

{ #category : #accessing }
XMLElement >> contentStringAt: aSymbol [
	^(self elementAt: aSymbol ifAbsent: [^'']) contentString
]

{ #category : #accessing }
XMLElement >> contents [
	^self nodes select: [:each | each isText]
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

{ #category : #searching }
XMLElement >> firstTagNamed: aSymbol [ 
	"Return the first encountered node with the specified tag.
	If it is not the receiver, pass the message on"

	(self isNamed: aSymbol)
		ifTrue: [^self].
	^super firstTagNamed: aSymbol 
]

{ #category : #searching }
XMLElement >> firstTagNamed: aSymbol with: aBlock [
	"Return the first encountered node with the specified tag that allows
	the block to evaluate to true. Pass the message on"

	((self isNamed: aSymbol)
		and: [aBlock value: self])
		ifTrue: [^self].
	^super firstTagNamed: aSymbol with: aBlock.
]

{ #category : #testing }
XMLElement >> hasContents [

	^ self contents notEmpty
]

{ #category : #testing }
XMLElement >> hasPrefix [

	^ self localName ~~ self tag
]

{ #category : #testing }
XMLElement >> hash [

	^ (self name hash bitXor: self attributes hash) bitXor: super hash
]

{ #category : #searching }
XMLElement >> ifNamed: aSymbol do: aOneArgumentBlock [
	"If the receiver tag equals aSymbol, evaluate aOneArgumentBlock with the receiver"

	(self isNamed: aSymbol)
		ifTrue: [aOneArgumentBlock valueWithPossibleArgument: self]

]

{ #category : #testing }
XMLElement >> includesAttribute: aSymbol [

	^ self attributes includesKey: aSymbol
]

{ #category : #testing }
XMLElement >> isNamed: aSymbol [

	^ (self localName == aSymbol asSymbol)
		or: [self tag == aSymbol asSymbol]
]

{ #category : #testing }
XMLElement >> isTag [
	^true
]

{ #category : #'name space' }
XMLElement >> localName [
	^ name
]

{ #category : #accessing }
XMLElement >> name [
	^ self qualifiedName
]

{ #category : #initialize }
XMLElement >> name: aString [
	name := aString asSymbol
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

{ #category : #'name space' }
XMLElement >> qualifiedName [
	^self namespace
		ifNil: [self localName]
		ifNotNil: [self namespace , ':' , self localName]
]

{ #category : #initialize }
XMLElement >> setAttributes: newAttributes [
	attributes := newAttributes
]

{ #category : #accessing }
XMLElement >> tag [
	^ self name asSymbol
]

{ #category : #searching }
XMLElement >> tagsNamed: aSymbol contentsDo: aBlock [
	"Evaluate aBlock for all of the contents of the receiver
	if the receiver tag equals aSymbol. Pass the message on"

	(self isNamed: aSymbol)
		ifTrue: [self contentsDo: aBlock].
	super tagsNamed: aSymbol contentsDo: aBlock
]

{ #category : #searching }
XMLElement >> tagsNamed: aSymbol do: aOneArgumentBlock [
	"If the receiver tag equals aSymbol, evaluate aOneArgumentBlock
	with the receiver. Continue the search"

	(self isNamed: aSymbol)
		ifTrue: [aOneArgumentBlock value: self].
	super tagsNamed: aSymbol do: aOneArgumentBlock
]

{ #category : #accessing }
XMLElement >> valueFor: aSymbol [ 
	^self valueFor: aSymbol ifAbsent: ['']
]

{ #category : #accessing }
XMLElement >> valueFor: aSymbol ifAbsent: aBlock [ 
	^self attributes at: aSymbol ifAbsent: aBlock
]
