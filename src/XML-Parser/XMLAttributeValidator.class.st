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
XMLAttributeValidator >> errorInvalidID: anID [
	XMLValidationException
		formatSignal: 'Invalid ID "{1}" in attribute "{2}"'
		with: anID
		with: self attribute
]

{ #category : #private }
XMLAttributeValidator >> errorInvalidXMLIDAttributeValidator [
	XMLValidationException signal: 'Attribute "xml:id" must have ID type'
]

{ #category : #private }
XMLAttributeValidator >> errorInvalidXMLSpaceAttributeValidator [
	XMLValidationException signal:
		'Attribute "xml:space" must be declared as enumeration type
		with only "default" and "preserver" as values'
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
	"to:do: for speed"
	1 to: semiNormalizedValue size do: [:i | | nextChar |
		(nextChar := semiNormalizedValue at: i) == NormalizedSpace
			ifTrue: [
				isInWhitespace
					ifFalse: [isInWhitespace := true]]
			ifFalse: [
				isInWhitespace
					ifTrue: [
						writeStream xmlParserAtBeginning
							ifFalse: [writeStream nextPut: NormalizedSpace].
						isInWhitespace := false].
				writeStream nextPut: nextChar]].
	attributeAssociation value: writeStream contents.
]

{ #category : #testing }
XMLAttributeValidator >> hasIDRefs [
	^ false
]

{ #category : #testing }
XMLAttributeValidator >> hasNotationValues [
	^ false
]

{ #category : #initialization }
XMLAttributeValidator >> initializeWithValidatorsFrom: aValidatorContainer [
	self validateReservedAttributeValidator
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

{ #category : #validating }
XMLAttributeValidator >> validateAttributeDefaultIn: anAttributeDictionary [
	defaultValueValidator validateAttributeDefaultIn: anAttributeDictionary.

	self shouldFurtherNormalizeAttributeValue
		ifTrue: [self furtherNormalizeAttributeValueIn: anAttributeDictionary].
]

{ #category : #validating }
XMLAttributeValidator >> validateAttributeValue: aValue [
	self subclassResponsibility
]

{ #category : #validating }
XMLAttributeValidator >> validateAttributes: anAttributeDictionary [
	self
		validateAttributeDefaultIn: anAttributeDictionary;
		validateAttributeValue:
			(anAttributeDictionary
				at: self attribute
				ifAbsent: [^ self])
]

{ #category : #validating }
XMLAttributeValidator >> validateReservedAttributeValidator [
	(self attribute at: 1) == $x
		ifTrue: [
			(self attribute = 'xml:id')
				ifTrue: [^ self validateXMLIDAttributeValidator].
			(self attribute = 'xml:space')
				ifTrue: [^ self validateXMLSpaceAttributeValidator]]
]

{ #category : #validating }
XMLAttributeValidator >> validateXMLIDAttributeValidator [
	self errorInvalidXMLIDAttributeValidator
]

{ #category : #validating }
XMLAttributeValidator >> validateXMLSpaceAttributeValidator [
	self errorInvalidXMLSpaceAttributeValidator
]
