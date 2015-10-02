"
This class is a non-validating SAX driver that forwards token start/end positions to a SAXHandler.
"
Class {
	#name : #SAXPositionParserDriver,
	#superclass : #SAXParserDriver,
	#category : #'XML-Parser-GTExtensions-Highlighting-Parser'
}

{ #category : #testing }
SAXPositionParserDriver >> decodesCharacters [
	^ false
]

{ #category : #'handling - positions' }
SAXPositionParserDriver >> handleEndCDataPosition: aPosition [
	self saxHandler endCDataPosition: aPosition
]

{ #category : #'handling - positions' }
SAXPositionParserDriver >> handleEndCommentPosition: aPosition [
	self saxHandler endCommentPosition: aPosition
]

{ #category : #'handling - positions' }
SAXPositionParserDriver >> handleEndDeclaration: aPosition [
	self saxHandler endDeclarationPosition: aPosition
]

{ #category : #'handling - positions' }
SAXPositionParserDriver >> handleEndDoctypeDeclarationPosition: aPosition [
	self saxHandler endDoctypeDeclarationPosition: aPosition
]

{ #category : #'handling - positions' }
SAXPositionParserDriver >> handleEndEntityReferencePosition: aPosition [
	self saxHandler endEntityReferencePosition: aPosition
]

{ #category : #'handling - positions' }
SAXPositionParserDriver >> handleEndPIPosition: aPosition [
	self saxHandler endPIPosition: aPosition
]

{ #category : #'handling - positions' }
SAXPositionParserDriver >> handleEndQuotedStringValuePosition: aPosition [
	self saxHandler endQuotedStringValuePosition: aPosition
]

{ #category : #'handling - positions' }
SAXPositionParserDriver >> handleEndTagPosition: aPosition [
	self saxHandler endTagPosition: aPosition
]

{ #category : #'handling - positions' }
SAXPositionParserDriver >> handleEndXMLDeclarationPosition: aPosition [
	self saxHandler endXMLDeclarationPosition: aPosition
]

{ #category : #'handling - positions' }
SAXPositionParserDriver >> handleStartCDataPosition: aPosition [
	self saxHandler startCDataPosition: aPosition
]

{ #category : #'handling - positions' }
SAXPositionParserDriver >> handleStartCommentPosition: aPosition [
	self saxHandler startCommentPosition: aPosition
]

{ #category : #'handling - positions' }
SAXPositionParserDriver >> handleStartDeclaration: aPosition [
	self saxHandler startDeclarationPosition: aPosition
]

{ #category : #'handling - positions' }
SAXPositionParserDriver >> handleStartDoctypeDeclarationPosition: aPosition [
	self saxHandler startDoctypeDeclarationPosition: aPosition
]

{ #category : #'handling - positions' }
SAXPositionParserDriver >> handleStartEntityReferencePosition: aPosition [
	self saxHandler startEntityReferencePosition: aPosition
]

{ #category : #'handling - positions' }
SAXPositionParserDriver >> handleStartPIPosition: aPosition [
	self saxHandler startPIPosition: aPosition
]

{ #category : #'handling - positions' }
SAXPositionParserDriver >> handleStartQuotedStringValuePosition: aPosition [
	self saxHandler startQuotedStringValuePosition: aPosition
]

{ #category : #'handling - positions' }
SAXPositionParserDriver >> handleStartTagPosition: aPosition [
	self saxHandler startTagPosition: aPosition
]

{ #category : #'handling - positions' }
SAXPositionParserDriver >> handleStartXMLDeclarationPosition: aPosition [
	self saxHandler startXMLDeclarationPosition: aPosition
]

{ #category : #testing }
SAXPositionParserDriver >> isValidating [
	^ false
]

{ #category : #private }
SAXPositionParserDriver >> tokenizerClass [
	^ XMLPositionWellFormedParserTokenizer
]
