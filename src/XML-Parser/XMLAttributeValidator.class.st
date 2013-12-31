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

{ #category : #normalization }
XMLAttributeValidator >> furtherNormalizeAttributeValueIn: anAttributeDictionary [
	| readStream writeStream |

	readStream := (anAttributeDictionary at: attribute) readStream.
	writeStream := (String new: readStream size) writeStream.
	readStream skipSeparators.
	[readStream atEnd]
		whileFalse: [
			readStream peek isSeparator
				ifTrue: [
					readStream skipSeparators.
					readStream atEnd
						ifFalse: [writeStream space]]
				ifFalse: [writeStream nextPut: readStream next]].
	anAttributeDictionary
		at: attribute
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
XMLAttributeValidator >> isEntityValidator [
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

	(self shouldFurtherNormalizeAttributeValue
		and: [anAttributeDictionary includesKey: attribute])
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
	(XMLTokenizer isName: anId)
		ifFalse: [XMLValidationException signal: 'Invalid ID ', anId, ' in attribute "', attribute, '"']
]

{ #category : #validation }
XMLAttributeValidator >> validateName: aName [
	(XMLTokenizer isNmtoken: aName)
		ifFalse: [XMLValidationException signal: 'Invalid name "', aName, '" in attribute "', attribute, '"']
]
