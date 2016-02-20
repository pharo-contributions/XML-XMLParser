"
This is a base class for attribute validators.
"
Class {
	#name : #XMLAttributeValidator,
	#superclass : #Object,
	#instVars : [
		'element',
		'attribute',
		'defaultValidator'
	],
	#classVars : [
		'NormalizedSpace'
	],
	#category : #'XML-Parser-Validation'
}

{ #category : #'instance creation' }
XMLAttributeValidator class >> element: anElement attribute: anAttribute defaultValidator: aDefaultValidator [
	^ self new
		setElement: anElement
		attribute: anAttribute
		defaultValidator: aDefaultValidator
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
XMLAttributeValidator >> defaultValidator [
	^ defaultValidator
]

{ #category : #accessing }
XMLAttributeValidator >> element [
	^ element
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
	"must use #writeStream instead of WriteStream on: to get a 0-based stream
	on Gemstone"
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
						writeStream position > 0
							ifTrue: [writeStream nextPut: NormalizedSpace].
						isInWhitespace := false].
				writeStream nextPut: nextChar]].
	attributeAssociation value: writeStream contents.
]

{ #category : #initialization }
XMLAttributeValidator >> initializeWithValidatorsFrom: aValidatorContainer [
]

{ #category : #private }
XMLAttributeValidator >> listValuesIn: aSpaceSeparatedList do: aBlock [
	NormalizedSpace
		xmlParserSplit: aSpaceSeparatedList
		do: aBlock
]

{ #category : #printing }
XMLAttributeValidator >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPutAll: '(<';
		nextPutAll: self element;
		space;
		nextPutAll: self attribute;
		nextPutAll: '="">)'.
]

{ #category : #initialization }
XMLAttributeValidator >> setElement: anElement attribute: anAttribute defaultValidator: aDefaultValidator [
	element := anElement.
	attribute := anAttribute.
	defaultValidator := aDefaultValidator.
]

{ #category : #testing }
XMLAttributeValidator >> shouldFurtherNormalizeAttributeValue [
	^ true
]

{ #category : #validating }
XMLAttributeValidator >> validateAttributeDefaultIn: anAttributeDictionary [
	self defaultValidator validateAttributeDefaultIn: anAttributeDictionary.

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
XMLAttributeValidator >> validateDeclaration [
	(self attribute at: 1) == $x "optimization"
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
