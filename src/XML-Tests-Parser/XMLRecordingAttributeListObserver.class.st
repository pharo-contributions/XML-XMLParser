"
This observer records notifications from XMLAttributeLists.
"
Class {
	#name : #XMLRecordingAttributeListObserver,
	#superclass : #XMLRecordingListObserver,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #notifications }
XMLRecordingAttributeListObserver >> addedAttribute: anAttribute [
	self recordNotification:
		(MessageSend
			receiver: self
			selector: #addedAttribute:
			arguments: (Array with: anAttribute))
]

{ #category : #notifications }
XMLRecordingAttributeListObserver >> addingAttribute: anAttribute [
	self recordNotification:
		(MessageSend
			receiver: self
			selector: #addingAttribute:
			arguments: (Array with: anAttribute))
]

{ #category : #notifications }
XMLRecordingAttributeListObserver >> removedAttribute: anAttribute [
	self recordNotification:
		(MessageSend
			receiver: self
			selector: #removedAttribute:
			arguments: (Array with: anAttribute))
]
