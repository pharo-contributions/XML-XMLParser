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
	^ self new valueList: aString
]

{ #category : #testing }
DTDValueListParser >> isValidListValue: aValue [
	self subclassResponsibility
]

{ #category : #parsing }
DTDValueListParser >> parse [
	(valueListStream atEnd not
		and: [valueListStream next == $(])
		ifFalse: [XMLValidationException signal: 'Expected value list'].

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

{ #category : #parsing }
DTDValueListParser >> parseAfterList [
]

{ #category : #parsing }
DTDValueListParser >> parseListTerminator [
	(valueListStream atEnd not
		and: [valueListStream next == $)])
		ifFalse: [XMLValidationException signal: 'Missing list terminator ")"'].

	self parseAfterList.
]

{ #category : #parsing }
DTDValueListParser >> parseListValue [
	| value oldSize |

	valueStream reset.
	[valueListStream atEnd
		or: [ListValueDelimiters includes: valueListStream peek]]
		whileFalse: [valueStream nextPut: valueListStream next].

	(value := valueStream contents)
		ifEmpty: [XMLValidationException signal: 'Empty list value'].
	(self isValidListValue: value)
		ifFalse: [XMLValidationException signal: 'Invalid value "', value, '" in list value'].

	"checking the size avoids includes: hash lookup"
	oldSize := listValues size.
	listValues add: value.
	(listValues size > oldSize)
		ifFalse: [XMLValidationException signal: 'Duplicate "', value, '" in list'].
]

{ #category : #accessing }
DTDValueListParser >> valueList: aString [
	valueListStream := ReadStream on: aString.
	valueStream := WriteStream on: (String new: 16).
	listValues := Set new.
]
