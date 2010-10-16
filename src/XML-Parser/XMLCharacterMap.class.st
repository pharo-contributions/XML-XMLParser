"
This class maps characters to other kinds of objects.
"
Class {
	#name : #XMLCharacterMap,
	#superclass : #Collection,
	#instVars : [
		'characterCodeTable'
	],
	#category : #'XML-Parser-Utilities'
}

{ #category : #'instance creation' }
XMLCharacterMap class >> new [
	^ self new: 10
]

{ #category : #'instance creation' }
XMLCharacterMap class >> new: aCapacity [
	^ self basicNew initialize: aCapacity
]

{ #category : #'instance creation' }
XMLCharacterMap class >> newFrom: aCollection [
	^ self new
		addAll: aCollection;
		yourself
]

{ #category : #adding }
XMLCharacterMap >> add: anAssociation [
	self at: anAssociation key put: anAssociation value.
	^ anAssociation.
]

{ #category : #adding }
XMLCharacterMap >> addAll: aCollection [
	aCollection associationsDo: [:each | self add: each].
	^ aCollection.
]

{ #category : #accessing }
XMLCharacterMap >> associations [
	^ Array streamContents: [:stream | self associationsDo: [:each | stream nextPut: each]]
]

{ #category : #enumerating }
XMLCharacterMap >> associationsDo: aBlock [
	characterCodeTable doWithIndex: [:each :i | aBlock value: (Character value: i)  -> each]
]

{ #category : #accessing }
XMLCharacterMap >> at: aCharacter [
	^ self at: aCharacter ifAbsent: [self errorCharacterNotInMap: aCharacter]
]

{ #category : #accessing }
XMLCharacterMap >> at: aCharacter ifAbsent: aBlock [
	| asciiValue |

	((asciiValue := aCharacter asciiValue) > 255
		and: [characterCodeTable isWideCharacterCodeTable not])
		ifTrue: [^ aBlock value].

	^ characterCodeTable at: asciiValue ifAbsent: aBlock.
]

{ #category : #accessing }
XMLCharacterMap >> at: aCharacter ifAbsentPut: aBlock [
	^ self at: aCharacter ifAbsent: [self at: aCharacter put: aBlock value]
]

{ #category : #accessing }
XMLCharacterMap >> at: aCharacter ifPresent: aBlock [
	^ aBlock value: (self at: aCharacter ifAbsent: [^ nil])
]

{ #category : #accessing }
XMLCharacterMap >> at: aCharacter put: aValue [
	| asciiValue |

	((asciiValue := aCharacter asciiValue) > 256
		and: [characterCodeTable isWideCharacterCodeTable not])
		ifTrue: [self swapInWideCharacterCodeTable].

	^ characterCodeTable at: asciiValue put: aValue.
]

{ #category : #enumerating }
XMLCharacterMap >> do: aBlock [
	self associationsDo: aBlock
]

{ #category : #accessing }
XMLCharacterMap >> errorCharacterNotInMap: aCharacter [
	self error: 'Character "', aCharacter asString, '" not in map'
]

{ #category : #testing }
XMLCharacterMap >> includesKey: aCharacter [
	self at: aCharacter ifAbsent: [^ false].
	^ true.
]

{ #category : #initialization }
XMLCharacterMap >> initialize: aCapacity [
	characterCodeTable := XMLByteCharacterCodeTable new: aCapacity
]

{ #category : #enumerating }
XMLCharacterMap >> keys [
	^ Array streamContents: [:stream | self keysDo: [:each | stream nextPut: each]]
]

{ #category : #enumerating }
XMLCharacterMap >> keysAndValuesDo: aTwoArgumentBlock [
	characterCodeTable doWithIndex: [:each :i | aTwoArgumentBlock value: (Character value: i) value: each]
]

{ #category : #enumerating }
XMLCharacterMap >> keysDo: aBlock [
	characterCodeTable codeIndexesDo: [:each | aBlock value: (Character value: each)]
]

{ #category : #copying }
XMLCharacterMap >> postCopy [
	characterCodeTable := characterCodeTable copy
]

{ #category : #removing }
XMLCharacterMap >> remove: anObject ifAbsent: aBlock [
	self shouldNotImplement
]

{ #category : #removing }
XMLCharacterMap >> removeAll [
	characterCodeTable removeAll
]

{ #category : #removing }
XMLCharacterMap >> removeKey: aCharacter [
	^ self
		removeKey: aCharacter
		ifAbsent: [self errorCharacterNotInMap: aCharacter]
]

{ #category : #removing }
XMLCharacterMap >> removeKey: aCharacter ifAbsent: aBlock [
	^ characterCodeTable removeAt: aCharacter asciiValue ifAbsent: aBlock
]

{ #category : #accessing }
XMLCharacterMap >> size [
	^ characterCodeTable size
]

{ #category : #accessing }
XMLCharacterMap >> swapInWideCharacterCodeTable [
	characterCodeTable := characterCodeTable asWideCharacterCodeTable
]

{ #category : #accessing }
XMLCharacterMap >> values [
	^ Array streamContents: [:stream | self valuesDo: [:each | stream nextPut: each]]
]

{ #category : #enumerating }
XMLCharacterMap >> valuesDo: aBlock [
	characterCodeTable do: aBlock
]
