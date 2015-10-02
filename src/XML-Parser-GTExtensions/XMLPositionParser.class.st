"
This class allows access to the current 1-based  input position.
"
Class {
	#name : #XMLPositionParser,
	#superclass : #XMLParser,
	#category : #'XML-Parser-GTExtensions-Highlighting-Parser'
}

{ #category : #accessing }
XMLPositionParser >> currentPosition [
	^ self tokenizer currentPosition
]
