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
	#classVars : [
		'NormalizedSpace'
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

{ #category : #'class initialization' }
XMLAttributeValidator class >> initialize [
	"self initialize"

	NormalizedSpace := Character space
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
XMLAttributeValidator >> furtherNormalizeAttributeValueIn: anAttributeDictionary [
	"The tokenizer normalizes all whitespace in attribute values to spaces
	and this step normalizes again by removing leading and trailing spaces
	and turing multiple spaces to single spaces."
	| attributeAssociation semiNormalizedValue writeStream isInWhitespace |

	attributeAssociation :=
		anAttributeDictionary
			associationAt: self attribute
			ifAbsent: [^ self].
	semiNormalizedValue := attributeAssociation value.
	writeStream := (String new: semiNormalizedValue size) writeStream.
	isInWhitespace := false.
	semiNormalizedValue do: [:each |
		each == NormalizedSpace
			ifTrue: [
				isInWhitespace
					ifFalse: [isInWhitespace := true]]
			ifFalse: [
				isInWhitespace
					ifTrue: [
						writeStream xmlParserAtBeginning
							ifFalse: [writeStream nextPut: NormalizedSpace].
						isInWhitespace := false].
				writeStream nextPut: each]].
	attributeAssociation value: writeStream contents.
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
XMLAttributeValidator >> isEnumerationValidator [
	^ false
]

{ #category : #testing }
XMLAttributeValidator >> isIDValidator [
	^ false
]

{ #category : #private }
XMLAttributeValidator >> listValuesIn: aSpaceSeparatedList do: aBlock [
	NormalizedSpace
		xmlParserSplit: aSpaceSeparatedList
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
		at: self attribute
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
		validateAttributeValue:
			(anAttributeDictionary
				at: self attribute
				ifAbsent: [^ self])
]

{ #category : #validation }
XMLAttributeValidator >> validateID: anId [
	(XMLWellFormedParserTokenizer isName: anId)
		ifFalse: [self errorInvalidID: anId]
]
