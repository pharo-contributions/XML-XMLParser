Class {
	#name : #XMLStubListObserver,
	#superclass : #Object,
	#instVars : [
		'notifications'
	],
	#category : #'XML-Tests-Parser-Nodes'
}

{ #category : #notifications }
XMLStubListObserver >> added: anObject to: aList [
	self recordNotification
]

{ #category : #notifications }
XMLStubListObserver >> adding: anObject to: aList [
	self recordNotification
]

{ #category : #accessing }
XMLStubListObserver >> notifications [
	^ notifications ifNil: [notifications := OrderedCollection new]
]

{ #category : #notifications }
XMLStubListObserver >> recordNotification [
	self notifications add:
		(MessageSend
			receiver: self
			selector: thisContext sender selector
			arguments: thisContext sender arguments)
]

{ #category : #notifications }
XMLStubListObserver >> removed: anObject from: aList [
	self recordNotification
]
