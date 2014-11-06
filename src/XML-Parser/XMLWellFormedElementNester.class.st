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
		ifTrue: [self errorUnterminatedElements]
]

{ #category : #private }
XMLWellFormedElementNester >> errorImproperlyNestedElements: anElementName [
	XMLWellFormednessException
		formatSignal: '<{1}> element ended before its child element(s) {2}'
		with: anElementName
		with: (self enclosedElementsAsString: anElementName)
]

{ #category : #private }
XMLWellFormedElementNester >> errorMultipleRoots [
	XMLWellFormednessException signal: 'Document cannot have multiple root elements'
]

{ #category : #private }
XMLWellFormedElementNester >> errorUnmatchedEndTag: anElementName [
	XMLWellFormednessException
		formatSignal: 'End </{1}> tag with no corresponding start <{1}> tag'
		with: anElementName
]

{ #category : #private }
XMLWellFormedElementNester >> errorUnterminatedElements [
	XMLWellFormednessException signal: 'Unterminated elements: ', self printString
]

{ #category : #checking }
XMLWellFormedElementNester >> startElement: anElementName [
	rootElement
		ifNil: [rootElement := anElementName]
		ifNotNil: [
			(self openElements isEmpty
				and: [self hasExternalRootElement not])
				ifTrue: [self errorMultipleRoots]].

	super startElement: anElementName.
]
