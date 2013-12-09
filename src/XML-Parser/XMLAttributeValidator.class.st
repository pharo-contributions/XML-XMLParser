"
This is a base class for attribute validators.
"
Class {
	#name : #XMLAttributeValidator,
	#superclass : #Object,
	#instVars : [
		'element',
		'name',
		'defaultValueValidator'
	],
	#category : #'XML-Parser-Validation'
}

{ #category : #'instance creation' }
XMLAttributeValidator class >> element: anElement name: aName defaultValueValidator: aDefaultValueValidator [
	^ self new
		setElement: anElement
		name: aName
		defaultValueValidator: aDefaultValueValidator
]

{ #category : #normalization }
XMLAttributeValidator >> furtherNormalizeValueIn: anAttributeDictionary [
	| readStream writeStream |

	readStream := (anAttributeDictionary at: name) readStream.
	writeStream := (String new: readStream size) writeStream.
	readStream skipSeparators.
	[readStream atEnd]
		whileFalse: [
			readStream peek isSeparator
				ifTrue: [
					readStream skipSeparators.
					readStream atEnd
						ifFalse: [writeStream nextPut: Character space]]
				ifFalse: [writeStream nextPut: readStream next]].
	anAttributeDictionary
		at: name
		put: writeStream contents.
]

{ #category : #testing }
XMLAttributeValidator >> isEntityValidator [
	^ false
]

{ #category : #testing }
XMLAttributeValidator >> isValueListValidator [
	^ false
]

{ #category : #initialization }
XMLAttributeValidator >> setElement: anElement name: aName defaultValueValidator: aDefaultValueValidator [
	element := anElement.
	name := aName.
	defaultValueValidator := aDefaultValueValidator.
]

{ #category : #testing }
XMLAttributeValidator >> shouldFurtherNormalizeValue [
	^ true
]

{ #category : #validation }
XMLAttributeValidator >> validateAttributes: anAttributeDictionary [
	self
		validateDefaultValueIn: anAttributeDictionary;
		validateValue: (anAttributeDictionary at: name ifAbsent: [^ self])
						
]

{ #category : #validation }
XMLAttributeValidator >> validateDefaultValueIn: anAttributeDictionary [
	defaultValueValidator validateDefaultValueIn: anAttributeDictionary.

	(self shouldFurtherNormalizeValue and: [anAttributeDictionary includesKey: name])
		ifTrue: [self furtherNormalizeValueIn: anAttributeDictionary].
]

{ #category : #validation }
XMLAttributeValidator >> validateID: anId [
	(XMLTokenizer isName: anId)
		ifFalse: [XMLValidationException signal: 'Invalid ID ', anId, ' in attribute "', name, '"']
]

{ #category : #validation }
XMLAttributeValidator >> validateName: aName [
	(XMLTokenizer isNmtoken: aName)
		ifFalse: [XMLValidationException signal: 'Invalid name "', name, '" in attribute "', name, '"']
]

{ #category : #validation }
XMLAttributeValidator >> validateValue: aValue [
]
