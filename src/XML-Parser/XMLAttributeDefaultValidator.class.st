Class {
	#name : #XMLAttributeDefaultValidator,
	#superclass : #Object,
	#instVars : [
		'name',
		'defaultValue'
	],
	#category : #'XML-Parser-Validation'
}

{ #category : #'instance creation' }
XMLAttributeDefaultValidator class >> name: aName defaultValue: aDefaultValue [
	^ self new setName: aName defaultValue: aDefaultValue
]

{ #category : #initialization }
XMLAttributeDefaultValidator >> setName: aName defaultValue: aDefaultValue [
	name := aName.
	defaultValue := aDefaultValue.
]

{ #category : #validation }
XMLAttributeDefaultValidator >> validateDefaultValueIn: anAttributeDictionary [
	self subclassResponsibility
]
