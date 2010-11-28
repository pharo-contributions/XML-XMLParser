"
The class keeps track of elements as they are started and ended and ensures that they nest properly.
"
Class {
	#name : #XMLElementNester,
	#superclass : #Object,
	#instVars : [
		'openElements'
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
XMLElementNester >> endedElement: anElementName [
	(self currentElement = anElementName)
		ifFalse: [
			^ (self hasOpenElement: anElementName)
				ifTrue: [self errorImproperlyNestedElements: anElementName]
				ifFalse: [self errorUnmatchedEndTag: anElementName]].

	self openElements removeLast.
]

{ #category : #checking }
XMLElementNester >> ensureNoElementsRemainOpen [
	self hasOpenElements
		ifTrue: [XMLWellFormednessException signal: 'Unterminated elements: ', self printString]
]

{ #category : #errors }
XMLElementNester >> errorImproperlyNestedElements: anElementName [
	XMLWellFormednessException signal:
		('<{1}> element ended before its child {2} element(s)'
			format: (Array with: anElementName with: (self enclosedElementsAsString: anElementName)))
]

{ #category : #errors }
XMLElementNester >> errorUnmatchedEndTag: anElementName [
	XMLWellFormednessException signal:
		('End </{1}> tag with no corresponding start <{1}> tag'
			format: (Array with: anElementName))
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
	^ openElements ifNil: [openElements := OrderedCollection new: 50]
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

{ #category : #checking }
XMLElementNester >> startedElement: aTagName [
	^ self openElements addLast: aTagName
]

{ #category : #accessing }
XMLElementNester >> totalOpen [
	^ self openElements size
	
]
