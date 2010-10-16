"
This an abstract class for tables with integer character code keys. It is not a subclass of ArrayedCollection becuase its indexes (character codes) are zero-based rather than one-based and nil elements of the table are ignored during enumeration.
"
Class {
	#name : #XMLCharacterCodeTable,
	#superclass : #Collection,
	#instVars : [
		'codeTable',
		'codeIndexes',
		'tally'
	],
	#category : #'XML-Parser-Utilities'
}

{ #category : #'instance creation' }
XMLCharacterCodeTable class >> new [
	^ self new: 10
]

{ #category : #'instance creation' }
XMLCharacterCodeTable class >> new: aCapacity [
	^ self basicNew initialize: aCapacity
]

{ #category : #private }
XMLCharacterCodeTable >> addCodeIndex: aCodeIndex [
	tally < codeIndexes size
		ifFalse: [
			codeIndexes :=
				(Array new: ((codeIndexes size * 2) max: 10))
					replaceFrom: 1
					to: tally
					with: codeIndexes
					startingAt: 1].
	codeIndexes at: (tally := tally + 1) put: aCodeIndex.
]

{ #category : #accessing }
XMLCharacterCodeTable >> at: aCharacterCode [
	^ self at: aCharacterCode ifAbsent: [self errorCodeNotInTable: aCharacterCode]
]

{ #category : #accessing }
XMLCharacterCodeTable >> at: aCharacterCode ifAbsent: aBlock [
	self subclassResponsibility
]

{ #category : #accessing }
XMLCharacterCodeTable >> at: aCharacterCode put: aValue [
	self subclassResponsibility
]

{ #category : #private }
XMLCharacterCodeTable >> codeIndexesDo: aBlock [
	1 to: tally do: [:i | aBlock value: (codeIndexes at: i)]
]

{ #category : #enumerating }
XMLCharacterCodeTable >> do: aBlock [
	self codeIndexesDo: [:each | aBlock value: (self at: each)]
]

{ #category : #enumerating }
XMLCharacterCodeTable >> doWithIndex: aBlock [
	self codeIndexesDo: [:each | aBlock value: (self at: each) value: each]
]

{ #category : #private }
XMLCharacterCodeTable >> errorCodeNotInTable: aCharacterCode [
	self error: 'Character code ', aCharacterCode asString, ' not in table'
]

{ #category : #initialization }
XMLCharacterCodeTable >> initialize: aCapacity [
	codeTable := self newByteIndexedTable.
	codeIndexes := Array new: aCapacity.
	tally := 0.
]

{ #category : #testing }
XMLCharacterCodeTable >> isWideCharacterCodeTable [
	^ false
]

{ #category : #private }
XMLCharacterCodeTable >> newByteIndexedTable [
	^ Array new: 256
]

{ #category : #accessing }
XMLCharacterCodeTable >> postCopy [
	codeTable := codeTable copy.
	codeIndexes := codeIndexes copy.
]

{ #category : #removing }
XMLCharacterCodeTable >> removeAll [
	self codeIndexesDo: [:each | self removeAt: each]
]

{ #category : #removing }
XMLCharacterCodeTable >> removeAt: aCharacterCode [
	^ self removeAt: aCharacterCode ifAbsent: [self errorCodeNotInTable: aCharacterCode]
]

{ #category : #removing }
XMLCharacterCodeTable >> removeAt: aCharacterCode ifAbsent: aBlock [
	self subclassResponsibility
]

{ #category : #private }
XMLCharacterCodeTable >> removeCodeIndex: aCodeIndex [
	codeIndexes := codeIndexes copyWithout: aCodeIndex.
	tally := tally - 1.
]

{ #category : #accessing }
XMLCharacterCodeTable >> size [
	^ tally
]
