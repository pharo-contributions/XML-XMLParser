"
This class records sent messages in a queue.
"
Class {
	#name : #XMLMessageRecorder,
	#superclass : #Object,
	#instVars : [
		'messageQueue'
	],
	#category : #'XML-Tests-Parser'
}

{ #category : #accessing }
XMLMessageRecorder >> clearMessages [
	^ self messageQueue removeAll
]

{ #category : #testing }
XMLMessageRecorder >> hasMessages [
	^ self messageQueue notEmpty
]

{ #category : #private }
XMLMessageRecorder >> messageQueue [
	^ messageQueue ifNil: [messageQueue := OrderedCollection new]
]

{ #category : #enumerating }
XMLMessageRecorder >> messagesCollect: aBlock [
	^ self messageQueue collect: aBlock
]

{ #category : #enumerating }
XMLMessageRecorder >> messagesDo: aBlock [
	self messageQueue do: aBlock
]

{ #category : #enumerating }
XMLMessageRecorder >> messagesSelect: aBlock [
	^ self messageQueue select: aBlock
]

{ #category : #accessing }
XMLMessageRecorder >> nextMessage [
	^ self messageQueue removeFirst
]

{ #category : #recording }
XMLMessageRecorder >> recordMessage: aMessage [
	self messageQueue addLast: aMessage
]

{ #category : #recording }
XMLMessageRecorder >> recordMessageReceiver: anObject selector: aSelector [
	self recordMessage:
		(MessageSend
			receiver: anObject
			selector: aSelector
			arguments: #())
]

{ #category : #recording }
XMLMessageRecorder >> recordMessageReceiver: anObject selector: aSelector arguments: aSequenceableCollection [
	self recordMessage:
		(MessageSend
			receiver: anObject
			selector: aSelector
			arguments: aSequenceableCollection asArray)
]
