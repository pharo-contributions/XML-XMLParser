"
This class is a Dictionary that preserves the order in which associations are added to it. That means #keys, #keysDo:, #keysAndValuesDo:, #values, #valuesDo:, #associations, and #associationsDo: are all ordered based on key insertion order.

This class is not a subclass of HashedCollection due to a belief that relying on the public API of Dictionary is probably a safer long-term bet than relying on the public and private API of a relatively recent addition to Squeak and Pharo.
"
Class {
	#name : #XMLOrderPreservingDictionary,
	#superclass : #Collection,
	#instVars : [
		'dictionary',
		'orderedKeys'
	],
	#category : #'XML-Parser'
}

{ #category : #'instance creation' }
XMLOrderPreservingDictionary class >> new [
	^ self new: 10
]

{ #category : #'instance creation' }
XMLOrderPreservingDictionary class >> new: aSize [
	^ self basicNew initialize: aSize
]

{ #category : #'instance creation' }
XMLOrderPreservingDictionary class >> newFrom: aDictionaryOrArray [
	| newDictionary |

	newDictionary := self new: aDictionaryOrArray size.
	aDictionaryOrArray associationsDo: [:each | newDictionary add: each].
	^ newDictionary.
]

{ #category : #comparing }
XMLOrderPreservingDictionary >> = anObject [
	^ self == anObject
		or: [self class == anObject class
			and: [self dictionary = anObject dictionary]]
]

{ #category : #adding }
XMLOrderPreservingDictionary >> add: anAssociation [
	self addOrderedKeyIfAbsent: anAssociation key.
	^ dictionary add: anAssociation.
]

{ #category : #adding }
XMLOrderPreservingDictionary >> addAll: aKeyedCollection [
	aKeyedCollection associationsDo: [:each | self add: each].
	^ aKeyedCollection.
]

{ #category : #private }
XMLOrderPreservingDictionary >> addOrderedKeyIfAbsent: aString [
	(dictionary includesKey: aString)
		ifFalse: [orderedKeys addLast: aString]
]

{ #category : #accessing }
XMLOrderPreservingDictionary >> associationAt: aKey [
	^ self associationAt: aKey ifAbsent: [self defaultValue]
]

{ #category : #accessing }
XMLOrderPreservingDictionary >> associationAt: aKey ifAbsent: aBlock [
	^ dictionary associationAt: aKey ifAbsent: aBlock
]

{ #category : #accessing }
XMLOrderPreservingDictionary >> associationDeclareAt: aKey [
	self addOrderedKeyIfAbsent: aKey.
	^ dictionary associationDeclareAt: aKey.
]

{ #category : #accessing }
XMLOrderPreservingDictionary >> associations [
	| associations i |

	associations := Array new: self size.
	i := 1.
	self associationsDo: [:each |
		associations at: i put: each.
		i := i + 1].
	^ associations.
]

{ #category : #enumerating }
XMLOrderPreservingDictionary >> associationsDo: aBlock [
	self keysDo: [:each | aBlock value: (self associationAt: each)]
]

{ #category : #enumerating }
XMLOrderPreservingDictionary >> associationsSelect: aBlock [
	^ self species newFrom: (self associations select: aBlock)
]

{ #category : #accessing }
XMLOrderPreservingDictionary >> at: aKey [
	^ self at: aKey ifAbsent: [self defaultValue]
]

{ #category : #accessing }
XMLOrderPreservingDictionary >> at: aKey ifAbsent: aBlock [
	^ dictionary at: aKey ifAbsent: aBlock
]

{ #category : #accessing }
XMLOrderPreservingDictionary >> at: aKey ifAbsentPut: aBlock [
	^ self at: aKey ifAbsent: [self at: aKey put: aBlock value]
]

{ #category : #accessing }
XMLOrderPreservingDictionary >> at: aKey ifPresent: aBlock [
	^ dictionary at: aKey ifPresent: aBlock
]

{ #category : #accessing }
XMLOrderPreservingDictionary >> at: aKey ifPresentAndInMemory: aBlock [
	^ dictionary at: aKey ifPresentAndInMemory: aBlock
]

{ #category : #accessing }
XMLOrderPreservingDictionary >> at: aKey put: aBlock [
	self addOrderedKeyIfAbsent: aKey.
	^ dictionary at: aKey put: aBlock.
]

{ #category : #accessing }
XMLOrderPreservingDictionary >> capacity [
	^ dictionary capacity
]

{ #category : #enumerating }
XMLOrderPreservingDictionary >> collect: aBlock [
	^ self species newFrom:
		(self associations collect: [:each |
			each key -> (aBlock value: each value)])
]

{ #category : #copying }
XMLOrderPreservingDictionary >> copyEmpty [
	^ self species new
]

{ #category : #adding }
XMLOrderPreservingDictionary >> declare: aKey from: aDictionary [
	self addOrderedKeyIfAbsent: aKey.
	dictionary declare: aKey from: aDictionary.
]

{ #category : #private }
XMLOrderPreservingDictionary >> defaultValue [
	^ ''
]

{ #category : #private }
XMLOrderPreservingDictionary >> dictionary [
	^ dictionary
]

{ #category : #enumerating }
XMLOrderPreservingDictionary >> do: aBlock [
	self valuesDo: aBlock
]

{ #category : #enumerating }
XMLOrderPreservingDictionary >> doWithIndex: aTwoArgumentBlock [
	| i |

	i := 1.
	self
		do: [:each | aTwoArgumentBlock value: each value: i]
		separatedBy: [i := i + 1].
]

{ #category : #testing }
XMLOrderPreservingDictionary >> hash [
	^ dictionary hash
]

{ #category : #testing }
XMLOrderPreservingDictionary >> includes: anObject [
	^ dictionary includes: anObject
]

{ #category : #testing }
XMLOrderPreservingDictionary >> includesAssociation: anAssociation [
	^ dictionary includesAssociation: anAssociation
]

{ #category : #testing }
XMLOrderPreservingDictionary >> includesIdentity: anObject [
	^ dictionary includesIdentity: anObject
]

{ #category : #testing }
XMLOrderPreservingDictionary >> includesKey: aKey [
	^ dictionary includesKey: aKey
]

{ #category : #initialization }
XMLOrderPreservingDictionary >> initialize: aSize [
	dictionary := Dictionary new: aSize.
	orderedKeys := OrderedCollection new: aSize.
]

{ #category : #inspecting }
XMLOrderPreservingDictionary >> inspectorClass [
	^ DictionaryInspector
]

{ #category : #testing }
XMLOrderPreservingDictionary >> isDictionary [
	^ true
]

{ #category : #accessing }
XMLOrderPreservingDictionary >> keyAtIdentityValue: aValue [
	^ self keyAtIdentityValue: aValue ifAbsent: [self defaultValue]
]

{ #category : #accessing }
XMLOrderPreservingDictionary >> keyAtIdentityValue: aValue ifAbsent: aBlock [
	^ dictionary keyAtIdentityValue: aValue ifAbsent: aBlock
]

{ #category : #accessing }
XMLOrderPreservingDictionary >> keyAtValue: aValue [
	^ self keyAtValue: aValue ifAbsent: [self defaultValue]
]

{ #category : #accessing }
XMLOrderPreservingDictionary >> keyAtValue: aValue ifAbsent: aBlock [
	^ dictionary keyAtValue: aValue ifAbsent: aBlock
]

{ #category : #accessing }
XMLOrderPreservingDictionary >> keyForIdentity: anObject [
	^ dictionary keyForIdentity: anObject
]

{ #category : #accessing }
XMLOrderPreservingDictionary >> keys [
	^ Array newFrom: orderedKeys
]

{ #category : #enumerating }
XMLOrderPreservingDictionary >> keysAndValuesDo: aBlock [
	self keysDo: [:each | aBlock value: each value: (self at: each)]
]

{ #category : #removing }
XMLOrderPreservingDictionary >> keysAndValuesRemove: aTwoArgumentBlock [
	| removedAssociations |

	removedAssociations := OrderedCollection new.
	self associationsDo: [:each |
		(aTwoArgumentBlock value: each key value: each value)
			ifTrue: [removedAssociations add: each]].
	removedAssociations do: [:each | self removeKey: each key].
]

{ #category : #enumerating }
XMLOrderPreservingDictionary >> keysDo: aBlock [
	orderedKeys do: aBlock
]

{ #category : #accessing }
XMLOrderPreservingDictionary >> keysSortedSafely [
	^ dictionary keysSortedSafely
]

{ #category : #testing }
XMLOrderPreservingDictionary >> occurrencesOf: anObject [
	^ self values
		inject: 0
		into: [:total :each |
			each = anObject
				ifTrue: [total + 1]
				ifFalse: [total]]
]

{ #category : #copying }
XMLOrderPreservingDictionary >> postCopy [
	orderedKeys := orderedKeys copy.
	dictionary := dictionary copy.
]

{ #category : #printing }
XMLOrderPreservingDictionary >> printElementsOn: aStream [
	self ifEmpty: [^ self].

	aStream nextPut: $(.
	self associations doWithIndex: [:associaiton :i |
		aStream
			print: associaiton key;
			nextPutAll: '->';
			print: associaiton value.
		(i < self size)
			ifTrue: [aStream space]].
	aStream nextPut: $).
]

{ #category : #printing }
XMLOrderPreservingDictionary >> printNameOn: aStream [
	aStream
		nextPutAll: 'an';
		space;
		nextPutAll: self class name
]

{ #category : #removing }
XMLOrderPreservingDictionary >> remove: anObject [
	self shouldNotImplement
]

{ #category : #removing }
XMLOrderPreservingDictionary >> remove: anObject ifAbsent: aBlock [
	self shouldNotImplement
]

{ #category : #removing }
XMLOrderPreservingDictionary >> removeAll [
	orderedKeys removeAll.
	dictionary removeAll.
]

{ #category : #removing }
XMLOrderPreservingDictionary >> removeKey: aKey [
	^ self removeKey: aKey ifAbsent: [self defaultValue]
]

{ #category : #removing }
XMLOrderPreservingDictionary >> removeKey: aKey ifAbsent: aBlock [
	self removeOrderedKeyIfPresent: aKey.
	^ dictionary removeKey: aKey ifAbsent: aBlock.
]

{ #category : #private }
XMLOrderPreservingDictionary >> removeOrderedKeyIfPresent: aKey [
	(self includesKey: aKey)
		ifTrue: [orderedKeys remove: aKey]
]

{ #category : #removing }
XMLOrderPreservingDictionary >> removeUnreferencedKeys [
	^ self unreferencedKeys collect: [:each | self removeKey: each. each]
]

{ #category : #enumerating }
XMLOrderPreservingDictionary >> select: aBlock [
	^ self species newFrom:
		(self associations select: [:each | aBlock value: each value])
]

{ #category : #accessing }
XMLOrderPreservingDictionary >> size [
	^ dictionary size
]

{ #category : #removing }
XMLOrderPreservingDictionary >> unreferencedKeys [
	^ dictionary unreferencedKeys
]

{ #category : #accessing }
XMLOrderPreservingDictionary >> values [
	^ self associations collect: [:each | each value]
]

{ #category : #enumerating }
XMLOrderPreservingDictionary >> valuesDo: aBlock [
	self keysDo: [:each | aBlock value: (self at: each)]
]
