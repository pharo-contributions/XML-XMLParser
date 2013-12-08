Class {
	#name : #DTDEnumerationListParser,
	#superclass : #Object,
	#instVars : [
		'enumerationList'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #'instance creation' }
DTDEnumerationListParser class >> on: aString [
	^ self new enumerationList: aString
]

{ #category : #accessing }
DTDEnumerationListParser >> enumerationList: aString [
	enumerationList := aString
]

{ #category : #testing }
DTDEnumerationListParser >> isValidListValue: aValue [
	^ XMLTokenizer isNmtoken: aValue
]

{ #category : #parsing }
DTDEnumerationListParser >> parse [
	| listValues value |

	(enumerationList notEmpty
		and: [enumerationList first == $(
			and: [enumerationList last == $)]])
		ifFalse: [XMLValidationException signal: 'Expected enumeration list'].

	listValues := Set new.
	$|
		split: (enumerationList copyFrom: 2 to: enumerationList size - 1)
		do: [:each |
			value := each copyWithout: Character space.
			(self isValidListValue: value)
				ifFalse: [XMLValidationException signal: 'Invalid enumeration value "', value, '" in list'].
			(listValues includes: value)
				ifTrue: [XMLValidationException signal: 'Duplicate "', value, '" in list'].
			listValues add: value].

	^ listValues.
]
