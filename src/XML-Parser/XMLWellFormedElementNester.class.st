"
The class keeps track of elements as they start and end and ensures that they nest properly.
"
Class {
	#name : #XMLWellFormedElementNester,
	#superclass : #XMLElementNester,
	#category : #'XML-Parser-Drivers'
}

{ #category : #checking }
XMLWellFormedElementNester >> endElement: anElement [
	(self currentElement = anElement)
		ifFalse: [
			^ (self hasOpenElement: anElement)
				ifTrue: [self errorImproperlyNestedElements: anElement]
				ifFalse: [self errorUnmatchedEndTag: anElement]].

	super endElement: anElement.
]

{ #category : #checking }
XMLWellFormedElementNester >> endNesting [
	self hasOpenElements
		ifTrue: [self errorUnterminatedElements]
]

{ #category : #private }
XMLWellFormedElementNester >> errorImproperlyNestedElements: anElement [
	XMLWellFormednessException
		formatSignal: '<{1}> element ended before enclosed element(s) {2}'
		with: anElement
		with: (self printedElementsEnclosedBy: anElement)
]

{ #category : #private }
XMLWellFormedElementNester >> errorMultipleRoots [
	XMLWellFormednessException signal: 'Document cannot have multiple root elements'
]

{ #category : #private }
XMLWellFormedElementNester >> errorUnmatchedEndTag: anElement [
	XMLWellFormednessException
		formatSignal: 'End </{1}> tag with no corresponding start <{1}> tag'
		with: anElement
]

{ #category : #private }
XMLWellFormedElementNester >> errorUnterminatedElements [
	XMLWellFormednessException signal: 'Unterminated elements: ', self printedElements
]

{ #category : #checking }
XMLWellFormedElementNester >> startElement: anElement [
	rootElement
		ifNil: [rootElement := anElement]
		ifNotNil: [
			(self openElements size > 0
				or: [self hasExternalRootElement])
				ifFalse: [self errorMultipleRoots]].

	super startElement: anElement.
]
