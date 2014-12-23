"
This class validates ID attributes that must be unique in each element of the type.
"
Class {
	#name : #XMLIDAttributeValidator,
	#superclass : #XMLAttributeValidator,
	#instVars : [
		'ids'
	],
	#category : #'XML-Parser-Validation'
}

{ #category : #private }
XMLIDAttributeValidator class >> classForAttribute: anAttribute [
	anAttribute = 'xml:id'
		ifTrue: [^ XMLXMLIDIDAttributeValidator]
		ifFalse: [^ XMLIDAttributeValidator]
]

{ #category : #'instance creation' }
XMLIDAttributeValidator class >> element: anElement attribute: anAttribute defaultValueValidator: aDefaultValueValidator [
	^ (self classForAttribute: anAttribute) new
		setElement: anElement
		attribute: anAttribute
		defaultValueValidator: aDefaultValueValidator
]

{ #category : #private }
XMLIDAttributeValidator >> errorDuplicateID: anId [
	XMLValidationException
		formatSignal: 'ID "{1}" used more than once for attribute "{2}"'
		with: anId
		with: self attribute
]

{ #category : #private }
XMLIDAttributeValidator >> errorElementWithMultipleIDAttributes [
	XMLValidationException
		formatSignal: 'Element <{1}> has multiple ID attributes'
		with: self element
]

{ #category : #testing }
XMLIDAttributeValidator >> hasIDs [
	^ self ids notEmpty
]

{ #category : #accessing }
XMLIDAttributeValidator >> ids [
	^ ids ifNil: [ids := Set new]
	
]

{ #category : #testing }
XMLIDAttributeValidator >> isIDValidator [
	^ true
]

{ #category : #validation }
XMLIDAttributeValidator >> validateAttributeValue: aValue [
	self validateID: aValue.
	(self ids includes: aValue)
		ifTrue: [self errorDuplicateID: aValue].

	self ids add: aValue.
]

{ #category : #validation }
XMLIDAttributeValidator >> validateBeforeAddingTo: anAttributeValidatorDictionary usingDeclarationsFrom: aDeclarationDelegate [
	anAttributeValidatorDictionary valuesDo: [:each |
		each isIDValidator
			ifTrue: [self errorElementWithMultipleIDAttributes]].
	ids := aDeclarationDelegate elementIDs.
	self validateReservedAttributeValidator.
]
