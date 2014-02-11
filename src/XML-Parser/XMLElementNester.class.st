"
This is a base class for element nesters.
"
Class {
	#name : #XMLElementNester,
	#superclass : #Object,
	#instVars : [
		'openElements',
		'scopedAttributes',
		'rootElement',
		'hasExternalRoot'
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
	"for speed"
	^ self openElements size > 0
		ifTrue: [openElements at: openElements size]
		ifFalse: ['']
]

{ #category : #accessing }
XMLElementNester >> currentScopedAttributes [
	^ self scopedAttributes
		ifEmpty: [nil]
		ifNotEmpty: [:attributes | attributes last]
]

{ #category : #printing }
XMLElementNester >> enclosedElementsAsString: aTagName [
	| enclosedTags |

	enclosedTags := String new writeStream.
	self
		printOn: enclosedTags
		startingAt: (self openElements lastIndexOf: aTagName) + 1.
	^ enclosedTags contents.
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
XMLElementNester >> hasExternalRoot [
	^ hasExternalRoot ifNil: [hasExternalRoot := false]
]

{ #category : #testing }
XMLElementNester >> hasOpenElement: anElementName [
	^ self openElements includes: anElementName
]

{ #category : #testing }
XMLElementNester >> hasOpenElements [
	^ self openElements notEmpty
]

{ #category : #testing }
XMLElementNester >> hasScopedAttributes [
	^ scopedAttributes notNil and: [scopedAttributes notEmpty]
]

{ #category : #testing }
XMLElementNester >> isCurrentElementRoot [
	^ self openElements size = 1
]

{ #category : #accessing }
XMLElementNester >> openElements [
	^ openElements ifNil: [openElements := OrderedCollection new: 10]
]

{ #category : #enumerating }
XMLElementNester >> openElementsReverseDo: aBlock [
	self openElements reverseDo: aBlock
]

{ #category : #private }
XMLElementNester >> printLimit [
	^ 5
]

{ #category : #printing }
XMLElementNester >> printOn: aStream [
	self printOn: aStream startingAt: 1
]

{ #category : #printing }
XMLElementNester >> printOn: aStream startingAt: aPosition [
	| endPosition |

	endPosition :=  self openElements size min: (aPosition + self printLimit - 1).
	(self openElements copyFrom: aPosition to: endPosition)
		do: [:each |
			aStream
				nextPut: $<;
				nextPutAll: each;
				nextPut: $>]
		separatedBy: [aStream nextPutAll: ', '].
	(endPosition < self openElements size)
		ifTrue: [aStream nextPutAll: '...'].
]

{ #category : #accessing }
XMLElementNester >> rootElement [
	^ rootElement ifNil: ['']
]

{ #category : #accessing }
XMLElementNester >> rootElement: anElement [
	rootElement := anElement.
	hasExternalRoot := true.
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
