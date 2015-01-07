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
XMLAttributeValidator >> errorInvalidXMLIDAttributeValidator [
	XMLValidationException signal: 'Attribute "xml:id" must have ID type'
]

{ #category : #private }
XMLAttributeValidator >> errorInvalidXMLSpaceAttributeValidator [
	XMLValidationException signal:
		'Attribute "xml:space" must be declared as ',
		'enumeration "(default|preserve)" type'
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
XMLAttributeValidator >> validateReservedAttributeValidator [
	(self attribute at: 1) == $x
		ifTrue: [
			(self attribute = 'xml:id')
				ifTrue: [^ self validateXMLIDAttributeValidator].
			(self attribute = 'xml:space')
				ifTrue: [^ self validateXMLSpaceAttributeValidator]]
]

{ #category : #validation }
XMLAttributeValidator >> validateXMLIDAttributeValidator [
	self isIDValidator
		ifFalse: [self errorInvalidXMLIDAttributeValidator]
]

{ #category : #validation }
XMLAttributeValidator >> validateXMLSpaceAttributeValidator [
	(self isEnumerationValidator
		and: [self allowedValues size = 2
			and: [#('preserve' 'default') allSatisfy: [:each | self allowedValues includes: each]]])
		ifFalse: [self errorInvalidXMLSpaceAttributeValidator]
]
