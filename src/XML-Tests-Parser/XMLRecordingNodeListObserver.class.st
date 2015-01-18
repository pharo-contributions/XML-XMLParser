"
This observer records notifications from XMLNodeLists.
"
Class {
	#name : #XMLRecordingNodeListObserver,
	#superclass : #XMLRecordingListObserver,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #notifications }
XMLRecordingNodeListObserver >> addedElement: anElement [
	self recordNotification:
		(MessageSend
			receiver: self
			selector: #addedElement:
			arguments: (Array with: anElement))
]

{ #category : #notifications }
XMLRecordingNodeListObserver >> addedNode: aNode [
	self recordNotification:
		(MessageSend
			receiver: self
			selector: #addedNode:
			arguments: (Array with: aNode))
]

{ #category : #notifications }
XMLRecordingNodeListObserver >> addingNode: aNode [
	self recordNotification:
		(MessageSend
			receiver: self
			selector: #addingNode:
			arguments: (Array with: aNode))
]

{ #category : #notifications }
XMLRecordingNodeListObserver >> removedElement: anElement [
	self recordNotification:
		(MessageSend
			receiver: self
			selector: #removedElement:
			arguments: (Array with: anElement))
]

{ #category : #notifications }
XMLRecordingNodeListObserver >> removedNode: aNode [
	self recordNotification:
		(MessageSend
			receiver: self
			selector: #removedNode:
			arguments: (Array with: aNode))
]
