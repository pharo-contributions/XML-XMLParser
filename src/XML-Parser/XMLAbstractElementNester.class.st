"
This is a base class for element nesters.
"
Class {
	#name : #XMLAbstractElementNester,
	#superclass : #Object,
	#instVars : [
		'openElements',
		'rootElement',
		'hasExternalRoot'
	],
	#category : #'XML-Parser'
}

{ #category : #accessing }
XMLAbstractElementNester >> currentElement [
	^ self openElements
		at: self totalOpen
		ifAbsent: ['']
]

{ #category : #printing }
XMLAbstractElementNester >> enclosedElementsAsString: aTagName [
	| enclosedTags |

	enclosedTags := String new writeStream.
	self
		printOn: enclosedTags
		startingAt: (self openElements lastIndexOf: aTagName) + 1.
	^ enclosedTags contents.
]

{ #category : #checking }
XMLAbstractElementNester >> endedElement: anElementName [
	self openElements removeLast
]

{ #category : #checking }
XMLAbstractElementNester >> ensureNoElementsRemainOpen [
	self subclassResponsibility
]

{ #category : #testing }
XMLAbstractElementNester >> hasExternalRoot [
	^ hasExternalRoot ifNil: [hasExternalRoot := false]
]

{ #category : #testing }
XMLAbstractElementNester >> hasOpenElement: anElementName [
	^ self openElements includes: anElementName
]

{ #category : #testing }
XMLAbstractElementNester >> hasOpenElements [
	^ self openElements notEmpty
]

{ #category : #accessing }
XMLAbstractElementNester >> openElements [
	^ openElements ifNil: [openElements := OrderedCollection new: 15]
]

{ #category : #private }
XMLAbstractElementNester >> printLimit [
	^ 5
]

{ #category : #printing }
XMLAbstractElementNester >> printOn: aStream [
	self printOn: aStream startingAt: 1
]

{ #category : #printing }
XMLAbstractElementNester >> printOn: aStream startingAt: aPosition [
	| endPosition |

	endPosition :=  self totalOpen min: (aPosition + self printLimit - 1).
	(self openElements copyFrom: aPosition to: endPosition)
		do: [:each |
			aStream
				nextPut: $<;
				nextPutAll: each;
				nextPut: $>]
		separatedBy: [aStream nextPutAll: ', '].
	(endPosition < self totalOpen)
		ifTrue: [aStream nextPutAll: '...'].
]

{ #category : #accessing }
XMLAbstractElementNester >> rootElement [
	^ rootElement ifNil: ['']
]

{ #category : #accessing }
XMLAbstractElementNester >> rootElement: anElement [
	rootElement := anElement.
	hasExternalRoot := true.
]

{ #category : #checking }
XMLAbstractElementNester >> startedElement: anElementName [
	self openElements addLast: anElementName
]

{ #category : #accessing }
XMLAbstractElementNester >> totalOpen [
	^ self openElements size
	
]
