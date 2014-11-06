"
This class validates attributes that refer to an ID of another element with a ID attribute.
"
Class {
	#name : #XMLIDRefAttributeValidator,
	#superclass : #XMLAttributeValidator,
	#instVars : [
		'idRefs'
	],
	#category : #'XML-Parser-Validation'
}

{ #category : #testing }
XMLIDRefAttributeValidator >> hasIDRefs [
	^ self idRefs notEmpty
]

{ #category : #accessing }
XMLIDRefAttributeValidator >> idRefs [
	^ idRefs ifNil: [idRefs := Set new].
]

{ #category : #accessing }
XMLIDRefAttributeValidator >> idRefs: anObject [
	^ idRefs := anObject
]

{ #category : #validation }
XMLIDRefAttributeValidator >> validateAttributeValue: aValue [
	self validateID: aValue.
	self idRefs add: aValue.
]
