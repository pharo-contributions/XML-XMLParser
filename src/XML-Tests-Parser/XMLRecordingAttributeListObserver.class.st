"
This observer records notifications from XMLAttributeLists.
"
Class {
	#name : #XMLRecordingAttributeListObserver,
	#superclass : #XMLRecordingListObserver,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #notifying }
XMLRecordingAttributeListObserver >> addedAttribute: anAttribute [
	self recordNotification:
		(MessageSend
			receiver: self
			selector: #addedAttribute:
			arguments: (Array with: anAttribute))
]

{ #category : #notifying }
XMLRecordingAttributeListObserver >> addingAttribute: anAttribute [
	self recordNotification:
		(MessageSend
			receiver: self
			selector: #addingAttribute:
			arguments: (Array with: anAttribute))
]

{ #category : #notifying }
XMLRecordingAttributeListObserver >> removedAttribute: anAttribute [
	self recordNotification:
		(MessageSend
			receiver: self
			selector: #removedAttribute:
			arguments: (Array with: anAttribute))
]
