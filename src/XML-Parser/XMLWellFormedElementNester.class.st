"
The class keeps track of elements as they start and end and ensures that they nest properly.
"
Class {
	#name : #XMLWellFormedElementNester,
	#superclass : #XMLElementNester,
	#category : #'XML-Parser'
}

{ #category : #checking }
XMLWellFormedElementNester >> endElement: anElementName [
	(self currentElement = anElementName)
		ifFalse: [
			^ (self hasOpenElement: anElementName)
				ifTrue: [self errorImproperlyNestedElements: anElementName]
				ifFalse: [self errorUnmatchedEndTag: anElementName]].

	super endElement: anElementName.
]

{ #category : #checking }
XMLWellFormedElementNester >> endNesting [
	self hasOpenElements
		ifTrue: [XMLWellFormednessException signal: 'Unterminated elements: ', self printString]
]

{ #category : #errors }
XMLWellFormedElementNester >> errorImproperlyNestedElements: anElementName [
	XMLWellFormednessException signal:
		('<{1}> element ended before its child {2} element(s)'
			format: (Array with: anElementName with: (self enclosedElementsAsString: anElementName)))
]

{ #category : #errors }
XMLWellFormedElementNester >> errorUnmatchedEndTag: anElementName [
	XMLWellFormednessException signal:
		('End </{1}> tag with no corresponding start <{1}> tag'
			format: (Array with: anElementName))
]

{ #category : #checking }
XMLWellFormedElementNester >> startElement: anElementName [
	rootElement
		ifNil: [rootElement := anElementName]
		ifNotNil: [
			(self hasOpenElements or: [self hasExternalRoot])
				ifFalse: [
					XMLWellFormednessException signal:
						'Document cannot have multiple root elements']].

	super startElement: anElementName.
]
