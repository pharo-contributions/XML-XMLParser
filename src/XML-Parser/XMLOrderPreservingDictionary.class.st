"
The class is a Dictionary that preserves the order in which associations are added to it.
"
Class {
	#name : #XMLOrderPreservingDictionary,
	#superclass : #Dictionary,
	#instVars : [
		'orderedKeys'
	],
	#category : #'XML-Parser'
}

{ #category : #'instance creation' }
XMLOrderPreservingDictionary class >> newFrom: aDictionary [
	^ self new setAssociationsFrom: aDictionary
]

{ #category : #accessing }
XMLOrderPreservingDictionary >> add: anAssociation [
	self at: anAssociation key put: anAssociation value.
	^ anAssociation.
]

{ #category : #accessing }
XMLOrderPreservingDictionary >> addAll: anAssociationCollection [
	anAssociationCollection do: [:association | self add: association].
	^ anAssociationCollection.
]

{ #category : #private }
XMLOrderPreservingDictionary >> addKeyToSequence: aString [
	super at: aString ifAbsent: [orderedKeys addLast: aString]
]

{ #category : #converting }
XMLOrderPreservingDictionary >> asOrderedCollection [
	^ self associations asOrderedCollection
]

{ #category : #accessing }
XMLOrderPreservingDictionary >> associationAt: aKey [
	^ self associationAt: aKey ifAbsent: [self defaultValue]
]

{ #category : #accessing }
XMLOrderPreservingDictionary >> associations [
	^ self keys collect: [:key | self associationAt: key]
]

{ #category : #enumerating }
XMLOrderPreservingDictionary >> associationsDo: aBlock [
	^ self associations do: [:each | aBlock value: each]
]

{ #category : #accessing }
XMLOrderPreservingDictionary >> at: aKey [
	^ self at: aKey ifAbsent: [self defaultValue]
]

{ #category : #accessing }
XMLOrderPreservingDictionary >> at: aKey ifAbsentPut: aBlock [
	self addKeyToSequence: aKey.
	^ super at: aKey ifAbsentPut: aBlock.
]

{ #category : #accessing }
XMLOrderPreservingDictionary >> at: aKey put: aBlock [
	self addKeyToSequence: aKey.
	^ super at: aKey put: aBlock.
]

{ #category : #accessing }
XMLOrderPreservingDictionary >> defaultValue [
	^ nil
]

{ #category : #initialization }
XMLOrderPreservingDictionary >> initialize: aSize [
	super initialize: aSize.
	orderedKeys := OrderedCollection new: aSize.
]

{ #category : #accessing }
XMLOrderPreservingDictionary >> keys [
	^ orderedKeys copy
]

{ #category : #enumerating }
XMLOrderPreservingDictionary >> keysAndValuesDo: aBlock [
	self keysDo: [:each | aBlock value: each value: (self at: each)]
]

{ #category : #enumerating }
XMLOrderPreservingDictionary >> keysDo: aBlock [
	orderedKeys do: aBlock
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

{ #category : #accessing }
XMLOrderPreservingDictionary >> removeAll [
	orderedKeys removeAll.
	super removeAll.
]

{ #category : #accessing }
XMLOrderPreservingDictionary >> removeKey: aKey [
	^ self removeKey: aKey ifAbsent: [self defaultValue]
]

{ #category : #accessing }
XMLOrderPreservingDictionary >> removeKey: aKey ifAbsent: aBlock [
	self removeKeyFromSequence: aKey.
	^ super removeKey: aKey ifAbsent: aBlock.
]

{ #category : #private }
XMLOrderPreservingDictionary >> removeKeyFromSequence: aKey [
	(self includesKey: aKey)
		ifTrue: [orderedKeys remove: aKey]
]

{ #category : #initialization }
XMLOrderPreservingDictionary >> setAssociationsFrom: aDictionary [
	self addAll: aDictionary associations
]
