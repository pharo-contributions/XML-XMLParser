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
XMLAttributeValidator >> errorInvalidDefaultValue: aDefaultValue [
	XMLValidationException
		formatSignal: 'Invalid default value "{1}" in attribute "{2}" of element <3>'
		with: aDefaultValue
		with: self attribute
		with: self element
]

{ #category : #private }
XMLAttributeValidator >> errorInvalidXMLIDAttributeValidator [
	XMLValidationException signal:
		'All "xml:id" attributes must be declared to be of ID type'
]

{ #category : #private }
XMLAttributeValidator >> errorInvalidXMLSpaceAttributeValidator [
	XMLValidationException
		formatSignal:
			'Attribute "xml:space" of element <{1}> must be declared as ',
			'an enumeration type with "default" and/or "preserve" values'
		with: self element
]

{ #category : #private }
XMLAttributeValidator >> furtherNormalizeAttributeValue: aSemiNormalizedAttributeValue [
	"The tokenizer normalizes all (non-char escaped) whitespace in attribute
	values to spaces (0x20), and this further normalizes them by removing
	leading and trailing spaces and turing multiple spaces to single spaces."
	| writeStream isInWhitespace |

	"must use #writeStream instead of WriteStream on: to get a 0-based stream
	on Gemstone"
	writeStream := (String new: aSemiNormalizedAttributeValue size) writeStream.
	isInWhitespace := false.
	"to:do: for speed"
	1 to: aSemiNormalizedAttributeValue size do: [:i | | nextChar |
		(nextChar := aSemiNormalizedAttributeValue at: i) == NormalizedSpace
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
	^ writeStream contents.
]

{ #category : #private }
XMLAttributeValidator >> furtherNormalizeAttributeValueIn: aDictionary [
	| association |

	association :=
		aDictionary
			associationAt: self attribute
			ifAbsent: [^ self].

	association value:
		(self furtherNormalizeAttributeValue: association value).
]

{ #category : #initialization }
XMLAttributeValidator >> initializeWithValidatorsFrom: aValidatorContainer [
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

{ #category : #private }
XMLAttributeValidator >> spaceSeparatedListValuesIn: aSpaceSeparatedList do: aBlock [
	NormalizedSpace
		xmlSplit: aSpaceSeparatedList
		do: aBlock
]

{ #category : #validating }
XMLAttributeValidator >> validateAttributeDeclaration [
	self defaultValidator hasDefaultValue
		ifTrue: [| defaultValue |
			self shouldFurtherNormalizeAttributeValue
				ifTrue: [
					defaultValue :=
						self furtherNormalizeAttributeValue:
							self defaultValidator defaultValue.
					self defaultValidator defaultValue: defaultValue]
				ifFalse: [defaultValue := self defaultValidator defaultValue].
			self validateAttributeDefaultValue: defaultValue].

	(self attribute at: 1) == $x "optimization"
		ifTrue: [
			(self attribute = 'xml:id')
				ifTrue: [^ self validateXMLIDAttributeValidator].
			(self attribute = 'xml:space')
				ifTrue: [^ self validateXMLSpaceAttributeValidator]].
]

{ #category : #validating }
XMLAttributeValidator >> validateAttributeDefaultValue: aDefaultValue [
	"This is overriden in subclasses to check default values, but CDATA types
	should not be validated, and ID types cannot have default values at all"
]

{ #category : #validating }
XMLAttributeValidator >> validateAttributeValue: aValue [
	self subclassResponsibility
]

{ #category : #validating }
XMLAttributeValidator >> validateAttributes: aDictionary [
	self shouldFurtherNormalizeAttributeValue
		ifTrue: [self furtherNormalizeAttributeValueIn: aDictionary].

	self defaultValidator validateAttributeDefaultIn: aDictionary.

	self validateAttributeValue:
		(aDictionary
			at: self attribute
			ifAbsent: [^ self]).
]

{ #category : #validating }
XMLAttributeValidator >> validateXMLIDAttributeValidator [
	self errorInvalidXMLIDAttributeValidator
]

{ #category : #validating }
XMLAttributeValidator >> validateXMLSpaceAttributeValidator [
	self errorInvalidXMLSpaceAttributeValidator
]
