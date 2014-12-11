"
This is a parser of lists in the form of ""(one|two|three)""
(Assumes spaces have been removed)
"
Class {
	#name : #DTDEnumerationListParser,
	#superclass : #Object,
	#instVars : [
		'listString',
		'listValues',
		'startIndex'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #'instance creation' }
DTDEnumerationListParser class >> on: aString [
	^ self new on: aString
]

{ #category : #private }
DTDEnumerationListParser >> addListValue: aListValue [
	| oldSize |

	"checking the size avoids includes: hash lookup"
	oldSize := listValues size.
	listValues add: aListValue.
	(listValues size > oldSize)
		ifFalse: [self errorDuplicateListValue: aListValue].
]

{ #category : #private }
DTDEnumerationListParser >> errorDuplicateListValue: aValue [
	XMLValidationException
		formatSignal: 'Duplicate value "{1}" in list'
		with: aValue
]

{ #category : #initialization }
DTDEnumerationListParser >> on: aString [
	listString := aString.
	listValues := Set new.
	startIndex := 2.
]

{ #category : #parsing }
DTDEnumerationListParser >> parse [
	"the tokenizer removes all spaces from lists"
	| valueStartIndex nextChar |

	valueStartIndex := startIndex.
	startIndex to: listString size do: [:i | 
		((nextChar := listString at: i) == $)
			or: [nextChar == $|])
			ifTrue: [
				self addListValue:
					(listString
						copyFrom: valueStartIndex
						to: i - 1).
				nextChar == $)
					ifTrue: [^ listValues].
				valueStartIndex := i + 1]].
	^ listValues.
]
