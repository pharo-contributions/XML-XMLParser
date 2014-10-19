"
This class is an is an ordered list that sends notifications to observers when objects are added to it or removed from it. Subclasses should override the #beforeAdding:, #afterAdding: and #afterRemoving: messages to send custom notifications.
"
Class {
	#name : #XMLObservableList,
	#superclass : #XMLOrderedList,
	#instVars : [
		'observer'
	],
	#category : #'XML-Parser-DOM'
}

{ #category : #'instance creation' }
XMLObservableList class >> observer: anObject [
	^ self new observer: anObject
]

{ #category : #adding }
XMLObservableList >> add: anObject after: aPriorObject [
	^ self with: [super add: anObject after: aPriorObject] add: anObject
]

{ #category : #adding }
XMLObservableList >> add: anObject afterIndex: anIndex [
	^ self with: [super add: anObject afterIndex: anIndex] add: anObject
]

{ #category : #adding }
XMLObservableList >> add: anObject before: aSubsequentObject [
	^ self with: [super add: anObject before: aSubsequentObject] add: anObject
]

{ #category : #adding }
XMLObservableList >> add: anObject beforeIndex: anIndex [
	^ self with: [super add: anObject beforeIndex: anIndex] add: anObject
]

{ #category : #adding }
XMLObservableList >> addFirst: anObject [
	^ self with: [super addFirst: anObject] add: anObject
]

{ #category : #adding }
XMLObservableList >> addLast: anObject [
	"inlined for speed"
	self beforeAdding: anObject.
	collection addLast: anObject.
	self afterAdding: anObject.
	^ anObject.
]

{ #category : #private }
XMLObservableList >> afterAdding: anObject [
	observer ifNotNil: [observer added: anObject to: self]
]

{ #category : #private }
XMLObservableList >> afterRemoving: anObject [
	observer ifNotNil: [observer removed: anObject from: self]
]

{ #category : #accessing }
XMLObservableList >> at: anIndex put: anObject [
	| presentObject |

	(presentObject := self at: anIndex)
		ifNotNil: [
			self
				with: [super at: anIndex put: nil]
				remove: presentObject].

	^ self with: [super at: anIndex put: anObject] add: anObject.
]

{ #category : #private }
XMLObservableList >> beforeAdding: anObject [
	observer ifNotNil: [observer adding: anObject to: self]
]

{ #category : #observing }
XMLObservableList >> observer [
	^ observer
]

{ #category : #observing }
XMLObservableList >> observer: anObserver [
	observer := anObserver
]

{ #category : #removing }
XMLObservableList >> remove: anObject ifAbsent: aBlock [
	^ self with: [super remove: anObject ifAbsent: [^ aBlock value]] remove: anObject
]

{ #category : #removing }
XMLObservableList >> removeAt: anIndex [
	^ self with: [super removeAt: anIndex] remove: (self at: anIndex)
]

{ #category : #removing }
XMLObservableList >> reset [
	self removeAll
]

{ #category : #private }
XMLObservableList >> with: aBlock add: anObject [
	self beforeAdding: anObject.
	aBlock value.
	self afterAdding: anObject.
	^ anObject.
]

{ #category : #private }
XMLObservableList >> with: aBlock remove: anObject [
	aBlock value.
	self afterRemoving: anObject.
	^ anObject.
]
