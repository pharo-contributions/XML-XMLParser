"
This is a base class for element nesters.
"
Class {
	#name : #XMLElementNester,
	#superclass : #Object,
	#instVars : [
		'openElements',
		'rootElement',
		'hasExternalRootElement',
		'scopedAttributes'
	],
	#category : #'XML-Parser'
}

{ #category : #private }
XMLElementNester >> copiedScopedAttributes [
	| copiedAttributes |

	copiedAttributes :=
		self hasScopedAttributes
			ifTrue: [self scopedAttributes removeLast copy]
			ifFalse: [Dictionary new].
	self scopedAttributes addLast: copiedAttributes.

	^ copiedAttributes.
]

{ #category : #accessing }
XMLElementNester >> currentElement [
	^ self openElements lastOrNil
]

{ #category : #accessing }
XMLElementNester >> currentScopedAttributes [
	^ self scopedAttributes lastOrNil
]

{ #category : #printing }
XMLElementNester >> enclosedElementsAsString: anElement [
	^ String streamContents: [:stream |
		self
			printFrom: (self openElements lastIndexOf: anElement) + 1
			on: stream]
]

{ #category : #checking }
XMLElementNester >> endElement: anElementName [
	self openElements removeLast.
	self hasScopedAttributes
		ifTrue: [scopedAttributes removeLast].
]

{ #category : #checking }
XMLElementNester >> endNesting [
]

{ #category : #testing }
XMLElementNester >> hasExternalRootElement [
	^ hasExternalRootElement
]

{ #category : #testing }
XMLElementNester >> hasOpenElement: anElementName [
	^ self openElements includes: anElementName
]

{ #category : #testing }
XMLElementNester >> hasOpenElements [
	^ self openElements size > 0
]

{ #category : #testing }
XMLElementNester >> hasScopedAttributes [
	^ scopedAttributes notNil and: [scopedAttributes notEmpty]
]

{ #category : #initialization }
XMLElementNester >> initialize [
	super initialize.

	openElements := OrderedCollection new: 10.
	hasExternalRootElement := false.
]

{ #category : #testing }
XMLElementNester >> isCurrentElementRoot [
	^ self openElements size = 1
]

{ #category : #testing }
XMLElementNester >> isInElement [
	^ self openElements size > 0 or: [self hasExternalRootElement]
]

{ #category : #accessing }
XMLElementNester >> openElements [
	^ openElements
]

{ #category : #enumerating }
XMLElementNester >> openElementsReverseDo: aBlock [
	"reimplemented so it is always safe to remove at the end while scanning backwards"
	| i |

	i := self openElements size.
	[i > 0]
		whileTrue: [
			aBlock value: (self openElements at: i).
			i := i - 1].
]

{ #category : #printing }
XMLElementNester >> printFrom: aStart on: aStream [
	self
		printFrom: aStart
		to: aStart + self printLimit - 1
		on: aStream
]

{ #category : #printing }
XMLElementNester >> printFrom: aStart to: aStop on: aStream [
	aStart to: aStop do: [:i |
		i > self openElements size
			ifTrue: [^ self].
		i > aStart
			ifTrue: [aStream nextPutAll: ', '].

		aStream
			nextPut: $<;
			nextPutAll: (self openElements at: i);
			nextPut: $>].

	(aStop < self openElements size)
		ifTrue: [aStream nextPutAll: '...'].
]

{ #category : #private }
XMLElementNester >> printLimit [
	^ 5
]

{ #category : #printing }
XMLElementNester >> printOn: aStream [
	self
		printFrom: 1
		on: aStream
]

{ #category : #accessing }
XMLElementNester >> scopedAttributeAt: aName [
	^ self
		scopedAttributeAt: aName
		ifAbsent: ['']
]

{ #category : #accessing }
XMLElementNester >> scopedAttributeAt: aName ifAbsent: aBlock [
	^ self currentScopedAttributes
		ifNil: [aBlock value]
		ifNotNil: [:attributes |
			attributes
				at: aName
				ifAbsent: aBlock]
]

{ #category : #private }
XMLElementNester >> scopedAttributes [
	^ scopedAttributes ifNil: [scopedAttributes := OrderedCollection new]
]

{ #category : #accessing }
XMLElementNester >> setExternalRootElement: anElement [
	rootElement := anElement.
	hasExternalRootElement := true.
]

{ #category : #accessing }
XMLElementNester >> setScopedAttributesNamed: aNameCollection from: aDictionary [
	| attributes |

	aNameCollection do: [:each |
		(aDictionary at: each ifAbsent: [nil])
			ifNotNil: [:value |
				(attributes ifNil: [attributes := self copiedScopedAttributes])
					at: each
					put: value]].
]

{ #category : #checking }
XMLElementNester >> startElement: anElementName [
	self openElements addLast: anElementName.
	self hasScopedAttributes
		ifTrue: [scopedAttributes addLast: self currentScopedAttributes].
]
