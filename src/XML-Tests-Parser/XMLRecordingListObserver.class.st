"
This observer records notifications in a queue.
"
Class {
	#name : #XMLRecordingListObserver,
	#superclass : #Object,
	#instVars : [
		'notifications'
	],
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #notifications }
XMLRecordingListObserver >> added: anObject to: aList [
	self recordNotification:
		(MessageSend
			receiver: self
			selector: #added:to:
			arguments: (Array with: anObject with: aList))
]

{ #category : #notifications }
XMLRecordingListObserver >> adding: anObject to: aList [
	self recordNotification:
		(MessageSend
			receiver: self
			selector: #adding:to:
			arguments: (Array with: anObject with: aList))
]

{ #category : #accesing }
XMLRecordingListObserver >> clearNotifications [
	self notificationsQueue removeAll
]

{ #category : #testing }
XMLRecordingListObserver >> hasNotifications [
	^ self notificationsQueue notEmpty
]

{ #category : #accesing }
XMLRecordingListObserver >> nextNotification [
	^ self notificationsQueue removeFirst
]

{ #category : #private }
XMLRecordingListObserver >> notificationsQueue [
	^ notifications ifNil: [notifications := OrderedCollection new]
]

{ #category : #private }
XMLRecordingListObserver >> recordNotification: aMessageSend [
	self notificationsQueue addLast: aMessageSend 
]

{ #category : #notifications }
XMLRecordingListObserver >> removed: anObject from: aList [
	self recordNotification:
		(MessageSend
			receiver: self
			selector: #removed:from:
			arguments: (Array with: anObject with: aList))
]
