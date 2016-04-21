"
This class validates elements that can only contain element content (no PCDATA) using a regular expression converted to a DFA. It ignores comments, and PIs.
"
Class {
	#name : #XMLDFAElementContentElementValidator,
	#superclass : #XMLDFAElementValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #testing }
XMLDFAElementContentElementValidator >> hasElementContent [
	^ true
]

{ #category : #accessing }
XMLDFAElementContentElementValidator >> type [
	^ 'element content'
]

{ #category : #validating }
XMLDFAElementContentElementValidator >> validatePCData: aString [
	self errorUnexpectedPCData
]
