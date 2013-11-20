Class {
	#name : #XMLFAState,
	#superclass : #Object,
	#instVars : [
		'isAccepting',
		'transitions'
	],
	#category : #'XML-Parser-Validation-DFA'
}

{ #category : #'instance creation' }
XMLFAState class >> transition: aTransition [
	^ self new
		addTransition: aTransition;
		yourself
]

{ #category : #transitions }
XMLFAState >> addTransition: aTransition [
	self transitions addIfNotPresent: aTransition
]

{ #category : #transitions }
XMLFAState >> addTransitionsTo: aState [
	self transitionsDo: [:each | aState addTransition: each].
]

{ #category : #enumerating }
XMLFAState >> detectNextStateMatching: aMatcherBlock [
	^ self detectNextStateMatching: aMatcherBlock ifNone: [nil]
]

{ #category : #enumerating }
XMLFAState >> detectNextStateMatching: aMatcherBlock ifNone: aNoneBlock [
	self transitionsDo: [:each |
		(aMatcherBlock value: each matcher)
			ifTrue: [^ each nextState]].
	^ aNoneBlock value.
]

{ #category : #testing }
XMLFAState >> isAccepting [
	^ isAccepting ifNil: [isAccepting := false]
]

{ #category : #accessing }
XMLFAState >> isAccepting: aBoolean [
	isAccepting := aBoolean
]

{ #category : #printing }
XMLFAState >> printOn: aStream [
	self identityHash printOn: aStream.
	aStream nextPutAll: ': '.
	self transitionsDo: [:each | each printOn: aStream].
	aStream cr.
]

{ #category : #accessing }
XMLFAState >> transitionCollectionClass [
	^ OrderedCollection
]

{ #category : #accessing }
XMLFAState >> transitions [
	^ transitions ifNil: [transitions := self transitionCollectionClass new]
]

{ #category : #enumerating }
XMLFAState >> transitionsDo: aBlock [
	self transitions do: aBlock
]
