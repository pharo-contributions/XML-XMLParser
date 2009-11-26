Class {
	#name : #XMLElement,
	#superclass : #XMLNodeWithElements,
	#instVars : [
		'name',
		'attributes'
	],
	#category : #'XML-Parser'
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
XMLElement class >> named: aString namespace: ns uri: uri attributes: attributeList [
	^self new
		name: aString;
		namespace: ns uri: uri;
		setAttributes: attributeList
]

{ #category : #accessing }
XMLElement >> @ aSymbol [
	"shorthand form"
	^ self at: aSymbol 
]

{ #category : #initialize }
XMLElement >> addContent: contentString [
	self addElement: contentString
]

{ #category : #accessing }
XMLElement >> allAttributes [
	^ self attributes asOrderedCollection
]

{ #category : #accessing }
XMLElement >> at: aSymbol [
	^ self attributeAt: aSymbol 
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
XMLElement >> contentStringAt: entityName [
	^(self elementAt: entityName ifAbsent: [^'']) contentString
]

{ #category : #accessing }
XMLElement >> contents [
	^self elementsAndContents select: [:each | each isText]
]

{ #category : #enumerating }
XMLElement >> contentsDo: aBlock [
	self elementsAndContentsDo: [:each | each isText ifTrue: [aBlock value: each]]
]

{ #category : #accessing }
XMLElement >> elements [
	^self elementsAndContents select: [:each | each isText not]
]

{ #category : #enumerating }
XMLElement >> elementsAndContentsDo: aBlock [
	self elementsAndContents do: aBlock
]

{ #category : #enumerating }
XMLElement >> elementsDo: aBlock [
	self elementsAndContentsDo: [:each | each isText ifFalse: [aBlock value: each]]
]

{ #category : #searching }
XMLElement >> firstTagNamed: aSymbol [ 
	"Return the first encountered node with the specified tag.
	If it is not the receiver, pass the message on"

	(self localName == aSymbol
		or: [self tag == aSymbol])
		ifTrue: [^self].
	^super firstTagNamed: aSymbol 
]

{ #category : #searching }
XMLElement >> firstTagNamed: aSymbol with: aBlock [
	"Return the first encountered node with the specified tag that allows
	the block to evaluate to true. Pass the message on"

	((self localName == aSymbol
		or: [self tag == aSymbol])
 		and: [aBlock value: self])
		ifTrue: [^self].
	^super firstTagNamed: aSymbol with: aBlock.
]

{ #category : #testing }
XMLElement >> isEmpty [
	^self elements isEmpty
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

{ #category : #accessing }
XMLElement >> parent [
	^ parent
]

{ #category : #accessing }
XMLElement >> parent: anXMLElement [
	parent := anXMLElement 
]

{ #category : #printing }
XMLElement >> printXMLOn: writer [
	writer startElement: self name attributeList: self attributes.
	(writer canonical not
		and: [self isEmpty and: [self attributes isEmpty not]])
		ifTrue: [writer endEmptyTag: self name]
		ifFalse: [
			writer endTag.
			self elementsAndContentsDo: [:content | content printXMLOn: writer].
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

	(self localName == aSymbol
		or: [self tag == aSymbol])
		ifTrue: [self contentsDo: aBlock].
	super tagsNamed: aSymbol contentsDo: aBlock
]

{ #category : #searching }
XMLElement >> tagsNamed: aSymbol do: aOneArgumentBlock [
	"If the receiver tag equals aSymbol, evaluate aOneArgumentBlock
	with the receiver. Continue the search"

	(self localName == aSymbol
		or: [self tag == aSymbol])
		ifTrue: [aOneArgumentBlock value: self].
	super tagsNamed: aSymbol do: aOneArgumentBlock
]

{ #category : #searching }
XMLElement >> tagsNamed: aSymbol ifReceiverDo: aOneArgumentBlock [
	"If the receiver tag equals aSymbol, evaluate aOneArgumentBlock with the receiver"

	(self localName == aSymbol
		or: [self tag == aSymbol])
		ifTrue: [aOneArgumentBlock value: self]

]

{ #category : #searching }
XMLElement >> tagsNamed: aSymbol ifReceiverDoAndRecurse: aOneArgumentBlock [
	"If the receiver tag equals aSymbol, evaluate aOneArgumentBlock
	with the receiver. Then recurse through all the children"

	(self localName == aSymbol
		or: [self tag == aSymbol])
		ifTrue: [aOneArgumentBlock value: self].
	super tagsNamed: aSymbol ifReceiverDoAndRecurse: aOneArgumentBlock
]

{ #category : #searching }
XMLElement >> tagsNamed: aSymbol ifReceiverOrChildDo: aOneArgumentBlock [
	"If the receiver tag equals aSymbol, evaluate aOneArgumentBlock with the receiver.
	For each of the receivers children do the same. Do not go beyond direct children"

	(self localName == aSymbol
		or: [self tag == aSymbol])
		ifTrue: [aOneArgumentBlock value: self].
	super tagsNamed: aSymbol ifReceiverDo: aOneArgumentBlock
]

{ #category : #accessing }
XMLElement >> valueFor: aSymbol [ 
	^self valueFor: aSymbol ifAbsent: ['']
]

{ #category : #accessing }
XMLElement >> valueFor: aSymbol ifAbsent: aBlock [ 
	^self attributes at: aSymbol ifAbsent: aBlock
]
