"
This is a base class for element nesters.
"
Class {
	#name : #XMLElementNester,
	#superclass : #Object,
	#instVars : [
		'openElements',
		'rootElement',
		'hasExternalRoot'
	],
	#category : #'XML-Parser'
}

{ #category : #accessing }
XMLElementNester >> currentElement [
	^ self openElements
		at: self totalOpen
		ifAbsent: ['']
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
	self openElements removeLast
]

{ #category : #checking }
XMLElementNester >> ensureNoElementsRemainOpen [
	self subclassResponsibility
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

{ #category : #accessing }
XMLElementNester >> openElements [
	^ openElements ifNil: [openElements := OrderedCollection new: 15]
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
XMLElementNester >> rootElement [
	^ rootElement ifNil: ['']
]

{ #category : #accessing }
XMLElementNester >> rootElement: anElement [
	rootElement := anElement.
	hasExternalRoot := true.
]

{ #category : #checking }
XMLElementNester >> startElement: anElementName [
	self openElements addLast: anElementName
]

{ #category : #accessing }
XMLElementNester >> totalOpen [
	^ self openElements size
	
]
