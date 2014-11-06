"
This is a base class for attribute validators.
"
Class {
	#name : #XMLAttributeValidator,
	#superclass : #Object,
	#instVars : [
		'element',
		'attribute',
		'defaultValueValidator'
	],
	#category : #'XML-Parser-Validation'
}

{ #category : #'instance creation' }
XMLAttributeValidator class >> element: anElement attribute: anAttribute defaultValueValidator: aDefaultValueValidator [
	^ self new
		setElement: anElement
		attribute: anAttribute
		defaultValueValidator: aDefaultValueValidator
]

{ #category : #accessing }
XMLAttributeValidator >> attribute [
	^ attribute
]

{ #category : #accessing }
XMLAttributeValidator >> element [
	^ element
]

{ #category : #private }
XMLAttributeValidator >> errorInvalidID: anId [
	XMLValidationException
		formatSignal: 'Invalid ID "{1}" in attribute "{2}"'
		with: anId
		with: self attribute
]

{ #category : #private }
XMLAttributeValidator >> errorInvalidName: aName [
	XMLValidationException
		formatSignal: 'Invalid name "{1}" in attribute "{2}"'
		with: aName
		with: self attribute
]

{ #category : #private }
XMLAttributeValidator >> furtherNormalizeAttributeValueIn: anAttributeDictionary [
	| attributeValue writeStream isInWhitespace |

	attributeValue := anAttributeDictionary at: self attribute ifAbsent: [^ self].
	writeStream := WriteStream on: (String new: attributeValue size).
	isInWhitespace := false.
	attributeValue do: [:each |
		isInWhitespace
			ifTrue: [
				each isSeparator
					ifFalse: [
						writeStream position > 0
							ifTrue: [writeStream space].
						isInWhitespace := false.
						writeStream nextPut: each]]
			ifFalse: [
				each isSeparator
					ifTrue: [isInWhitespace := true]
					ifFalse: [writeStream nextPut: each]]].
	anAttributeDictionary
		at: self attribute
		put: writeStream contents.
]

{ #category : #testing }
XMLAttributeValidator >> hasIDRefs [
	^ false
]

{ #category : #testing }
XMLAttributeValidator >> hasIDs [
	^ false
]

{ #category : #testing }
XMLAttributeValidator >> hasNotationValues [
	^ false
]

{ #category : #testing }
XMLAttributeValidator >> isIDValidator [
	^ false
]

{ #category : #testing }
XMLAttributeValidator >> isValueListValidator [
	^ false
]

{ #category : #private }
XMLAttributeValidator >> listValuesIn: aSpaceSeparatedList do: aBlock [
	Character space
		xmlSplit: aSpaceSeparatedList
		do: aBlock
]

{ #category : #initialization }
XMLAttributeValidator >> setElement: anElement attribute: anAttribute defaultValueValidator: aDefaultValueValidator [
	element := anElement.
	attribute := anAttribute.
	defaultValueValidator := aDefaultValueValidator.
]

{ #category : #testing }
XMLAttributeValidator >> shouldFurtherNormalizeAttributeValue [
	^ true
]

{ #category : #validation }
XMLAttributeValidator >> validateAndAddTo: anAttributeValidatorDictionary usingDeclarationsFrom: aDeclarationDelegate [
	anAttributeValidatorDictionary
		at: attribute
		put: self
]

{ #category : #validation }
XMLAttributeValidator >> validateAttributeDefaultIn: anAttributeDictionary [
	defaultValueValidator validateAttributeDefaultIn: anAttributeDictionary.

	self shouldFurtherNormalizeAttributeValue
		ifTrue: [self furtherNormalizeAttributeValueIn: anAttributeDictionary].
]

{ #category : #validation }
XMLAttributeValidator >> validateAttributeValue: aValue [
	self subclassResponsibility
]

{ #category : #validation }
XMLAttributeValidator >> validateAttributes: anAttributeDictionary [
	self
		validateAttributeDefaultIn: anAttributeDictionary;
		validateAttributeValue: (anAttributeDictionary at: attribute ifAbsent: [^ self])
]

{ #category : #validation }
XMLAttributeValidator >> validateID: anId [
	(XMLWellFormedParserTokenizer isName: anId)
		ifFalse: [self errorInvalidID: anId]
]

{ #category : #validation }
XMLAttributeValidator >> validateName: aName [
	(XMLWellFormedParserTokenizer isNmtoken: aName)
		ifFalse: [self errorInvalidName: aName]
]
