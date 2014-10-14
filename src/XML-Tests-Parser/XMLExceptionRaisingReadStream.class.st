"
This is a read stream that raises errors when sent peek or next when atEnd.
"
Class {
	#name : #XMLExceptionRaisingReadStream,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #'XML-Tests-Parser'
}

{ #category : #'instance creation' }
XMLExceptionRaisingReadStream class >> on: aString [
	^ self new stream: aString readStream
]

{ #category : #testing }
XMLExceptionRaisingReadStream >> atEnd [
	^ stream atEnd
]

{ #category : #'initialize-release' }
XMLExceptionRaisingReadStream >> close [
	stream close
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

{ #category : #accessing }
XMLExceptionRaisingReadStream >> peek [
	stream atEnd
		ifTrue: [Error signal: 'Cannot call peek on this stream when atEnd'].
	^ stream peek.
]

{ #category : #accessing }
XMLExceptionRaisingReadStream >> stream: aStream [
	stream := aStream
]
