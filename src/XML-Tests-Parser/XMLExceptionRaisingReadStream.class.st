"
This is a read stream that raises errors if sent peek or next when atEnd, which streams on other platforms disallow, or if sent close multiple times or if sent atEnd, next, or peek when closed, which StandardFileStream disallows . Used to test portability.
"
Class {
	#name : #XMLExceptionRaisingReadStream,
	#superclass : #Object,
	#instVars : [
		'stream',
		'wasClosed'
	],
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #'instance creation' }
XMLExceptionRaisingReadStream class >> on: aCollection [
	^ self new on: aCollection
]

{ #category : #testing }
XMLExceptionRaisingReadStream >> atEnd [
	wasClosed
		ifTrue: [self errorClosedStreamCannotBeSent: #atEnd].
	^ stream atEnd
]

{ #category : #closing }
XMLExceptionRaisingReadStream >> close [
	wasClosed
		ifTrue: [self errorClosedStreamCannotBeSent: #close].

	"must use respondsTo: to support streams only implementing the basic
	protocol"
	(stream respondsTo: #close)
		ifTrue: [stream close].
	wasClosed := true.
]

{ #category : #private }
XMLExceptionRaisingReadStream >> errorAtEndStreamCannotBeSent: aSelector [
	Error signal:
		'Cannot send ', aSelector printString, ' on this stream when it''s atEnd'
]

{ #category : #private }
XMLExceptionRaisingReadStream >> errorClosedStreamCannotBeSent: aSelector [
	Error signal:
		'Cannot send ', aSelector printString, ' on this stream when closed'
]

{ #category : #testing }
XMLExceptionRaisingReadStream >> isBinary [
	^ false
]

{ #category : #testing }
XMLExceptionRaisingReadStream >> isStream [
	^ true
]

{ #category : #accessing }
XMLExceptionRaisingReadStream >> next [
	stream atEnd
		ifTrue: [self errorAtEndStreamCannotBeSent: #next].
	^ stream next.
]

{ #category : #initialization }
XMLExceptionRaisingReadStream >> on: aCollection [
	stream := aCollection readStream.
	wasClosed := false.
]

{ #category : #accessing }
XMLExceptionRaisingReadStream >> peek [
	stream atEnd
		ifTrue: [self errorAtEndStreamCannotBeSent: #peek].
	^ stream peek.
]

{ #category : #positioning }
XMLExceptionRaisingReadStream >> position [
	wasClosed
		ifTrue: [self errorClosedStreamCannotBeSent: #position].
	^ stream position
]

{ #category : #positioning }
XMLExceptionRaisingReadStream >> position: anInteger [
	wasClosed
		ifTrue: [self errorClosedStreamCannotBeSent: #position:].
	stream position: anInteger.
]

{ #category : #positioning }
XMLExceptionRaisingReadStream >> reset [
	wasClosed
		ifTrue: [self errorClosedStreamCannotBeSent: #reset].
	stream reset.
]

{ #category : #testing }
XMLExceptionRaisingReadStream >> wasClosed [
	^ wasClosed
]
