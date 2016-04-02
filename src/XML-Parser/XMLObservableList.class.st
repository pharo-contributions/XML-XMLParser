"
This class is an ordered list that sends notifications to an observer when objects are added to it or removed from it. Subclasses should override the #beforeAdding:, #afterAdding:at:, #afterAddingLast: and #afterRemoving: messages to send custom notifications.
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

{ #category : #'instance creation' }
XMLObservableList class >> ofSize: aSize [
	self shouldNotImplement
]

{ #category : #adding }
XMLObservableList >> add: anObject after: aPreviousObject [
	^ self
		add: anObject
		afterIndex:
			(collection
				indexOf: aPreviousObject
				ifAbsent: [-1])
]

{ #category : #adding }
XMLObservableList >> add: anObject afterIndex: anIndex [
	self beforeAdding: anObject.
	collection
		add: anObject
		afterIndex: anIndex.
	self
		afterAdding: anObject
		at: anIndex + 1.
	^ anObject.
]

{ #category : #adding }
XMLObservableList >> add: anObject before: aNextObject [
	^ self
		add: anObject
		beforeIndex:
			(collection
				indexOf: aNextObject
				ifAbsent: [-1])
]

{ #category : #adding }
XMLObservableList >> add: anObject beforeIndex: anIndex [
	self beforeAdding: anObject.
	collection
		add: anObject
		beforeIndex: anIndex.
	self
		afterAdding: anObject
		at: anIndex.
	^ anObject.
]

{ #category : #adding }
XMLObservableList >> addFirst: anObject [
	self beforeAdding: anObject.
	collection addFirst: anObject.
	self afterAdding: anObject at: 1.
	^ anObject.
]

{ #category : #adding }
XMLObservableList >> addLast: anObject [
	self beforeAdding: anObject.
	collection addLast: anObject.
	self afterAddingLast: anObject.
	^ anObject.
]

{ #category : #private }
XMLObservableList >> afterAdding: anObject at: anIndex [
	observer ifNotNil: [observer added: anObject to: self]
]

{ #category : #private }
XMLObservableList >> afterAddingLast: anObject [
	self
		afterAdding: anObject
		at: self size
]

{ #category : #private }
XMLObservableList >> afterRemoving: anObject [
	observer ifNotNil: [observer removed: anObject from: self]
]

{ #category : #accessing }
XMLObservableList >> at: anIndex put: anObject [
	| oldObject |

	"gemstone behavior"
	anIndex = (self size + 1)
		ifTrue: [^ self addLast: anObject].

	self beforeAdding: anObject.

	oldObject := collection at: anIndex.
	collection at: anIndex put: nil.
	oldObject
		ifNotNil: [self afterRemoving: oldObject].
	
	collection at: anIndex put: anObject.
	self
		afterAdding: anObject
		at: anIndex.
	^ anObject.
]

{ #category : #private }
XMLObservableList >> beforeAdding: anObject [
	observer ifNotNil: [observer adding: anObject to: self]
]

{ #category : #private }
XMLObservableList >> indexOf: anObject otherThan: anIndex [
	"used by subclasses to remove duplicates"
	1 to: anIndex - 1 do: [:i |
		(collection at: i) = anObject
			ifTrue: [^ i]].
	anIndex + 1 to: collection size do: [:i |
		(collection at: i) = anObject
			ifTrue: [^ i]].
	^ 0.
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
	collection remove: anObject ifAbsent: [^ aBlock value].
	self afterRemoving: anObject.
	^ anObject.
]

{ #category : #removing }
XMLObservableList >> removeAt: anIndex [
	| removed |

	removed := super removeAt: anIndex.
	self afterRemoving: removed.
	^ removed.
]

{ #category : #removing }
XMLObservableList >> reset [
	| removed |

	removed := collection copy.
	collection reset.
	removed do: [:each | self afterRemoving: each].
]
