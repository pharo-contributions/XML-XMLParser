"
This is a base class for attribute default validators that implement constraints from the default declaration part of an ATTLIST attribute definition.
"
Class {
	#name : #XMLAttributeDefaultValidator,
	#superclass : #Object,
	#instVars : [
		'attribute'
	],
	#category : #'XML-Parser-Validation'
}

{ #category : #'instance creation' }
XMLAttributeDefaultValidator class >> attribute: anAttribute [
	^ self
		attribute: anAttribute
		defaultValue: ''
]

{ #category : #'instance creation' }
XMLAttributeDefaultValidator class >> attribute: anAttribute defaultValue: aDefaultValue [
	^ self new
		setAttribute: anAttribute
		defaultValue: aDefaultValue
]

{ #category : #accessing }
XMLAttributeDefaultValidator >> attribute [
	^ attribute
]

{ #category : #accessing }
XMLAttributeDefaultValidator >> defaultValue [
	^ ''
]

{ #category : #testing }
XMLAttributeDefaultValidator >> hasDefaultValue [
	^ false
]

{ #category : #printing }
XMLAttributeDefaultValidator >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self attribute;
		nextPutAll: '="';
		nextPutAll: self defaultValue;
		nextPutAll: '")'.
]

{ #category : #initialization }
XMLAttributeDefaultValidator >> setAttribute: anAttribute defaultValue: aDefaultValue [
	attribute := anAttribute
]

{ #category : #validating }
XMLAttributeDefaultValidator >> validateAttributeDefaultIn: aDictionary [
	self subclassResponsibility
]
