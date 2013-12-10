Class {
	#name : #XMLAttributeDefaultValidator,
	#superclass : #Object,
	#instVars : [
		'defaultValue',
		'attribute'
	],
	#category : #'XML-Parser-Validation'
}

{ #category : #'instance creation' }
XMLAttributeDefaultValidator class >> attribute: anAttribute defaultValue: aDefaultValue [
	^ self new setAttribute: anAttribute defaultValue: aDefaultValue
]

{ #category : #initialization }
XMLAttributeDefaultValidator >> setAttribute: anAttribute defaultValue: aDefaultValue [
	attribute := anAttribute.
	defaultValue := aDefaultValue.
]

{ #category : #validation }
XMLAttributeDefaultValidator >> validateDefaultValueIn: anAttributeDictionary [
	self subclassResponsibility
]
