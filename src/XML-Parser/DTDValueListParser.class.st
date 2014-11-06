"
This is an abstract parser of lists in the form of ""(one | two | three)""
"
Class {
	#name : #DTDValueListParser,
	#superclass : #Object,
	#instVars : [
		'valueListStream',
		'valueStream',
		'listValues'
	],
	#classVars : [
		'ListValueDelimiters'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #'class initialization' }
DTDValueListParser class >> initialize [
	"self initialize"

	super initialize.

	(ListValueDelimiters := BitmapCharacterSet new)
		add: $|;
		add: $);
		addAll: Character separators
]

{ #category : #'instance creation' }
DTDValueListParser class >> on: aString [
	^ self new on: aString
]

{ #category : #private }
DTDValueListParser >> errorDuplicateListValue: aValue [
	XMLValidationException
		formatSignal: 'Duplicate value "{1}" in list'
		with: aValue
]

{ #category : #private }
DTDValueListParser >> errorEmptyListValue [
	XMLValidationException signal: 'Empty list value'
]

{ #category : #private }
DTDValueListParser >> errorInvalidListValue: aValue [
	XMLValidationException
		formatSignal: 'Invalid value "{1}" in list'
		with: aValue
]

{ #category : #private }
DTDValueListParser >> errorMissingListEnd [
	XMLValidationException signal: 'Expected end of value list ")" character'
]

{ #category : #private }
DTDValueListParser >> errorMissingListStart [
	XMLValidationException signal: 'Expected value list starting with "("'
]

{ #category : #testing }
DTDValueListParser >> isValidListValue: aValue [
	self subclassResponsibility
]

{ #category : #initialization }
DTDValueListParser >> on: aString [
	valueListStream := ReadStream on: aString.
	valueStream := WriteStream on: (String new: (aString size / 4) asInteger).
	listValues := Set new.
]

{ #category : #parsing }
DTDValueListParser >> parse [
	(valueListStream atEnd not
		and: [valueListStream next == $(])
		ifFalse: [self errorMissingListStart].

	[valueListStream atEnd
		or: [valueListStream peek == $)]]
		whileFalse: [
			valueListStream skipSeparators.
			self parseListValue.
			valueListStream skipSeparators.

			(valueListStream atEnd not
				and: [valueListStream peek == $|])
				ifTrue: [valueListStream next]].
	self parseListTerminator.

	^ listValues.
]

{ #category : #private }
DTDValueListParser >> parseAfterList [
]

{ #category : #private }
DTDValueListParser >> parseListTerminator [
	(valueListStream atEnd not
		and: [valueListStream next == $)])
		ifFalse: [self errorMissingListEnd].

	self parseAfterList.
]

{ #category : #private }
DTDValueListParser >> parseListValue [
	| value oldSize |

	valueStream reset.
	[valueListStream atEnd
		or: [ListValueDelimiters includes: valueListStream peek]]
		whileFalse: [valueStream nextPut: valueListStream next].

	(value := valueStream contents)
		ifEmpty: [self errorEmptyListValue].
	(self isValidListValue: value)
		ifFalse: [self errorInvalidListValue: value].

	"checking the size avoids includes: hash lookup"
	oldSize := listValues size.
	listValues add: value.
	(listValues size > oldSize)
		ifFalse: [self errorDuplicateListValue: value].
]
