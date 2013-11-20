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

{ #category : #parsing }
DTDEnumerationListParser >> parse [
	| values value |

	values := Set new.

	((enumerationList beginsWith: '(')
		and: [enumerationList endsWith: ')'])
		ifFalse: [XMLValidationException signal: 'Expected enumeration list'].

	($| split: enumerationList)
		do: [:each |
			value := each copyWithoutAll: '( )'.
			(values includes: value)
				ifTrue: [XMLValidationException signal: 'Duplicate "', value, '" in list'].
			values add: value].

	^ values.
]
