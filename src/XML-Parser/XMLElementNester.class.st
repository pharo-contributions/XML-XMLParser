"
This is a base class for element nesters that are used by parser drivers to keep track of which elements are open while parsing.
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
	#category : #'XML-Parser-Drivers'
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
	^ self openElements xmlLastOrNil
]

{ #category : #accessing }
XMLElementNester >> currentScopedAttributes [
	^ self scopedAttributes xmlLastOrNil
]

{ #category : #private }
XMLElementNester >> elementPrintLimit [
	^ 5
]

{ #category : #checking }
XMLElementNester >> endElement: anElementName [
	self openElements removeLast.
	self hasScopedAttributes
		ifTrue: [self endScopedAttributes].
]

{ #category : #checking }
XMLElementNester >> endNesting [
]

{ #category : #private }
XMLElementNester >> endScopedAttributes [
	scopedAttributes removeLast
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
	"optimized to avoid lazy initialization"
	scopedAttributes == nil
		ifTrue: [^ false].
	^ scopedAttributes size > 0.
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
	^ self openElements size > 0
		or: [self hasExternalRootElement]
]

{ #category : #accessing }
XMLElementNester >> openElements [
	^ openElements
]

{ #category : #enumerating }
XMLElementNester >> openElementsDo: aBlock [
	self openElements do: aBlock
]

{ #category : #enumerating }
XMLElementNester >> openElementsReverseDo: aBlock [
	"implemented for XMLParserHTML so it's always safe to remove at
	the end while scanning backwards"
	| i |

	i := self openElements size.
	[i > 0]
		whileTrue: [
			aBlock value: (self openElements at: i).
			i := i - 1].
]

{ #category : #printing }
XMLElementNester >> printElementsFrom: aStart on: aStream [
	self
		printElementsFrom: aStart
		to: aStart + self elementPrintLimit - 1
		on: aStream
]

{ #category : #printing }
XMLElementNester >> printElementsFrom: aStart to: aStop on: aStream [
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

{ #category : #printing }
XMLElementNester >> printElementsOn: aStream [
	self
		printElementsFrom: 1
		on: aStream
]

{ #category : #printing }
XMLElementNester >> printOn: aStream [
	super printOn: aStream.
	self hasOpenElements
		ifTrue: [
			aStream nextPut: $(.
			self
				printElementsFrom: 1
				on: aStream.
			aStream nextPut: $)].
]

{ #category : #printing }
XMLElementNester >> printedElements [
	^ String streamContents: [:stream | self printElementsOn: stream]
]

{ #category : #printing }
XMLElementNester >> printedElementsEnclosedBy: anElement [
	^ String streamContents: [:stream |
		self
			printElementsFrom: (self openElements lastIndexOf: anElement) + 1
			on: stream]
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
		aDictionary
			at: each
			ifPresent: [:value |
				"used to copy only once if needed"
				(attributes ifNil: [attributes := self copiedScopedAttributes])
					at: each
					put: value]]
]

{ #category : #checking }
XMLElementNester >> startElement: anElementName [
	self openElements addLast: anElementName.
	self hasScopedAttributes
		ifTrue: [self startScopedAttributes].
]

{ #category : #private }
XMLElementNester >> startScopedAttributes [
	scopedAttributes addLast: self currentScopedAttributes
]
