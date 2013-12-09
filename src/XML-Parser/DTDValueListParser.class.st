"
This is an abstract parser of lists in the form of ""(one | two | three)""
"
Class {
	#name : #DTDValueListParser,
	#superclass : #Object,
	#instVars : [
		'valueList'
	],
	#category : #'XML-Parser-DTD'
}

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
	| listValues value |

	(valueList notEmpty
		and: [valueList first == $(
			and: [valueList last == $)]])
		ifFalse: [XMLValidationException signal: 'Expected value list'].

	listValues := Set new.
	$|
		split: (valueList copyFrom: 2 to: valueList size - 1)
		do: [:each |
			value := each copyWithout: Character space.
			(self isValidListValue: value)
				ifFalse: [XMLValidationException signal: 'Invalid value "', value, '" in list'].
			(listValues includes: value)
				ifTrue: [XMLValidationException signal: 'Duplicate "', value, '" in list'].
			listValues add: value].

	^ listValues.
]

{ #category : #accessing }
DTDValueListParser >> valueList: aString [
	valueList := aString
]
