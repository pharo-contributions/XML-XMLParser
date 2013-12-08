"
The class keeps track of elements as they start and end and ensures that they nest properly.
"
Class {
	#name : #XMLElementNester,
	#superclass : #XMLAbstractElementNester,
	#category : #'XML-Parser'
}

{ #category : #checking }
XMLElementNester >> endedElement: anElementName [
	(self currentElement = anElementName)
		ifFalse: [
			^ (self hasOpenElement: anElementName)
				ifTrue: [self errorImproperlyNestedElements: anElementName]
				ifFalse: [self errorUnmatchedEndTag: anElementName]].

	super endedElement: anElementName.
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

{ #category : #checking }
XMLElementNester >> startedElement: anElementName [
	rootElement
		ifNil: [rootElement := anElementName]
		ifNotNil: [
			(self hasOpenElements or: [self hasExternalRoot])
				ifFalse: [
					XMLWellFormednessException signal:
						'Document cannot have multiple root elements']].

	super startedElement: anElementName.
]
