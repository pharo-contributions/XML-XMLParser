"
This class wraps any readable stream that at the very least supports #next and #atEnd and makes it peekable. Additionally, it ensures that #next and #peek can be used at the end of a stream safely without raising an exception (the Squeak and Pharo behavior).
"
Class {
	#name : #XMLPeekableStreamAdapter,
	#superclass : #Object,
	#instVars : [
		'stream',
		'peekChar',
		'onClose'
	],
	#category : #'XML-Parser-Streams'
}

{ #category : #'instance creation' }
XMLPeekableStreamAdapter class >> on: aStream [
	^ self
		on: aStream
		onClose: nil
]

{ #category : #'instance creation' }
XMLPeekableStreamAdapter class >> on: aStream onClose: aBlock [
	^ self new
		setStream: aStream
		onClose: aBlock
]

{ #category : #testing }
XMLPeekableStreamAdapter >> atEnd [
	^ peekChar == nil and: [stream atEnd]
]

{ #category : #'file open/close' }
XMLPeekableStreamAdapter >> close [
	stream close.
	onClose ifNotNil: [onClose value].
]

{ #category : #accessing }
XMLPeekableStreamAdapter >> converter: aConverter [
	(stream respondsTo: #converter:)
		ifTrue: [stream converter: aConverter]
]

{ #category : #accessing }
XMLPeekableStreamAdapter >> next [
	peekChar
		ifNotNil: [| nextChar |
			nextChar := peekChar.
			peekChar := nil.
			^ nextChar]
		ifNil: [
			^ stream atEnd
				ifTrue: [nil]
				ifFalse: [stream next]]
]

{ #category : #accessing }
XMLPeekableStreamAdapter >> peek [
	^ peekChar
		ifNil: [
			stream atEnd
				ifFalse: [peekChar := stream next].
			peekChar]
]

{ #category : #initialization }
XMLPeekableStreamAdapter >> setStream: aStream onClose: aBlock [
	stream := aStream.
	peekChar := nil.
	onClose := aBlock.
]
