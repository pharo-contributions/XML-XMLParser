"
The class ensures tags are nested properly and that all opening tags have corresponding closing tags.
"
Class {
	#name : #XMLWellFormednessChecker,
	#superclass : #Object,
	#instVars : [
		'openElements'
	],
	#category : #'XML-Parser'
}

{ #category : #printing }
XMLWellFormednessChecker >> enclosedElementsAsString: aTagName [
	| enclosedTags |

	enclosedTags := String new writeStream.
	self
		printOn: enclosedTags
		startingAt: (self openElements lastIndexOf: aTagName) + 1.
	^ enclosedTags contents.
]

{ #category : #accessing }
XMLWellFormednessChecker >> enclosingElement [
	^ self openElements
		at: self totalOpen
		ifAbsent: ['']
]

{ #category : #checking }
XMLWellFormednessChecker >> endedElement: anElementName [
	(self enclosingElement = anElementName)
		ifFalse: [
			^ (self hasOpenElement: anElementName)
				ifTrue: [self errorImproperlyNestedElements: anElementName]
				ifFalse: [self errorUnmatchedEndTag: anElementName]].

	self openElements removeLast.
]

{ #category : #checking }
XMLWellFormednessChecker >> ensureNoElementsRemainOpen [
	self hasOpenElements
		ifTrue: [XMLWellFormednessException signal: 'Unterminated elements: ', self printString]
]

{ #category : #errors }
XMLWellFormednessChecker >> errorImproperlyNestedElements: anElementName [
	XMLWellFormednessException signal:
		('<{1}> element ended before its child {2} element(s)'
			format: (Array with: anElementName with: (self enclosedElementsAsString: anElementName)))
]

{ #category : #errors }
XMLWellFormednessChecker >> errorUnmatchedEndTag: anElementName [
	XMLWellFormednessException signal:
		('End </{1}> tag with no corresponding start <{1}> tag'
			format: (Array with: anElementName))
]

{ #category : #testing }
XMLWellFormednessChecker >> hasOpenElement: anElementName [
	^ self openElements includes: anElementName
]

{ #category : #testing }
XMLWellFormednessChecker >> hasOpenElements [
	^ self openElements notEmpty
]

{ #category : #accessing }
XMLWellFormednessChecker >> openElements [
	^ openElements ifNil: [openElements := OrderedCollection new: 50]
]

{ #category : #private }
XMLWellFormednessChecker >> printLimit [
	^ 5
]

{ #category : #printing }
XMLWellFormednessChecker >> printOn: aStream [
	self printOn: aStream startingAt: 1
]

{ #category : #printing }
XMLWellFormednessChecker >> printOn: aStream startingAt: aPosition [
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
XMLWellFormednessChecker >> startedElement: aTagName [
	^ self openElements addLast: aTagName
]

{ #category : #accessing }
XMLWellFormednessChecker >> totalOpen [
	^ self openElements size
	
]
