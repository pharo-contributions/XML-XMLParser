Class {
	#name : #XMLIDRefAttributeValidator,
	#superclass : #XMLAttributeValidator,
	#instVars : [
		'idrefs'
	],
	#category : #'XML-Parser-Validation'
}

{ #category : #accessing }
XMLIDRefAttributeValidator >> idrefs [
	^ idrefs ifNil: [idrefs := Set new].
]

{ #category : #validation }
XMLIDRefAttributeValidator >> validateValue: aValue [
	self validateID: aValue.
	self idrefs add: aValue.
]
