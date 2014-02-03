"
This class validates attributes that refer to an ID of another element with a ID attribute.
"
Class {
	#name : #XMLIDRefAttributeValidator,
	#superclass : #XMLAttributeValidator,
	#instVars : [
		'idrefs'
	],
	#category : #'XML-Parser-Validation'
}

{ #category : #testing }
XMLIDRefAttributeValidator >> hasIDRefs [
	^ self idRefs notEmpty
]

{ #category : #accessing }
XMLIDRefAttributeValidator >> idRefs [
	^ idrefs ifNil: [idrefs := Set new].
]

{ #category : #validation }
XMLIDRefAttributeValidator >> validateAttributeValue: aValue [
	self validateID: aValue.
	self idRefs add: aValue.
]
