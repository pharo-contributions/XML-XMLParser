"
This class is an is an ordered list that sends notifications to observers when objects are added to it or removed from it. Subclasses should override the #beforeAdding:, #afterAdding: and #afterRemoving: messages to send custom notifications.
"
Class {
	#name : #XMLObservableList,
	#superclass : #XMLOrderedList,
	#traits : 'TXMLObservable',
	#classTraits : 'TXMLObservable classTrait',
	#instVars : [
		'notifier'
	],
	#category : #'XML-Parser-Nodes'
}

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
	^ self with: [super addLast: anObject] add: anObject
]

{ #category : #private }
XMLObservableList >> afterAdding: anObject [
	self notifyOf: #added:to: with: anObject with: self.
]

{ #category : #private }
XMLObservableList >> afterRemoving: anObject [
	self notifyOf: #removed:from: with: anObject with: self.
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
	self notifyOf: #adding:to: with: anObject with: self
]

{ #category : #accessing }
XMLObservableList >> notifier [
	^ notifier ifNil: [notifier := XMLNotifier new]
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
XMLObservableList >> removeFirst [
	^ self removeAt: 1
]

{ #category : #removing }
XMLObservableList >> removeLast [
	^ self removeAt: self size
]

{ #category : #private }
XMLObservableList >> with: aBlock add: anObject [
	self
		beforeAdding: anObject;
		with: [aBlock value] onError: [^ nil];
		afterAdding: anObject.
	^ anObject.
]

{ #category : #private }
XMLObservableList >> with: aBlock onError: errorBlock [
	^ aBlock
		on: Error
		do: [:error |
			errorBlock valueWithPossibleArgument: error.
			error signal]
]

{ #category : #private }
XMLObservableList >> with: aBlock remove: anObject [
	self
		with: [aBlock value] onError: [^ nil];
		afterRemoving: anObject.
	^ anObject.
]
