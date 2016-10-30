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
		ifTrue: [Error signal: 'Cannot send #atEnd to a closed stream'].
	^ stream atEnd
]

{ #category : #closing }
XMLExceptionRaisingReadStream >> close [
	wasClosed
		ifTrue: [Error signal: 'Cannot close already closed stream']
		ifFalse: [
			"must use respondsTo: to support streams only implementing the basic
			protocol"
			(stream respondsTo: #close)
				ifTrue: [stream close].
			wasClosed := true]
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
		ifTrue: [Error signal: 'Cannot call next on this stream when atEnd'].
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
		ifTrue: [Error signal: 'Cannot call peek on this stream when atEnd'].
	^ stream peek.
]

{ #category : #testing }
XMLExceptionRaisingReadStream >> wasClosed [
	^ wasClosed
]
