"
This class validates elements that can contain any content.
"
Class {
	#name : #XMLAnyElementValidator,
	#superclass : #XMLElementValidator,
	#category : #'XML-Parser-Validation'
}

{ #category : #testing }
XMLAnyElementValidator >> atEnd [
	^ true
]

{ #category : #accessing }
XMLAnyElementValidator >> type [
	^ 'ANY'
]
