"
This is a stream adapter for basic read streams that support peek, next, and atEnd that can also decode them using stream decoder classes.
"
Class {
	#name : #XMLDecodingReadStreamAdapter,
	#superclass : #Object,
	#instVars : [
		'stream',
		'streamDecoder',
		'peekChar'
	],
	#category : #'XML-Parser-Streams'
}

{ #category : #'instance creation' }
XMLDecodingReadStreamAdapter class >> on: aStream [
	^ self
		on: aStream
		streamDecoder: XMLStreamDecoder defaultStreamDecoder new
]

{ #category : #'instance creation' }
XMLDecodingReadStreamAdapter class >> on: aStream streamDecoder: aDecoder [
	^ self new
		setStream: aStream
		streamDecoder: aDecoder
]

{ #category : #testing }
XMLDecodingReadStreamAdapter >> atEnd [
	^ peekChar == nil and: [stream atEnd]
]

{ #category : #private }
XMLDecodingReadStreamAdapter >> basicNext [
	stream atEnd
		ifTrue: [^ nil]
		ifFalse: [^ stream next].
]

{ #category : #'file open/close' }
XMLDecodingReadStreamAdapter >> close [
	(stream respondsTo: #close)
		ifTrue: [stream close]
]

{ #category : #testing }
XMLDecodingReadStreamAdapter >> isBinary [
	^ false
]

{ #category : #testing }
XMLDecodingReadStreamAdapter >> isStream [
	^ true
]

{ #category : #accessing }
XMLDecodingReadStreamAdapter >> next [
	peekChar
		ifNil: [^ streamDecoder nextFromStream: self]
		ifNotNil: [:nextChar |
			peekChar := nil.
			^ nextChar]
]

{ #category : #accessing }
XMLDecodingReadStreamAdapter >> peek [
	^ peekChar ifNil: [peekChar := streamDecoder nextFromStream: self]
]

{ #category : #initialization }
XMLDecodingReadStreamAdapter >> setStream: aStream streamDecoder: aDecoder [
	stream := aStream.
	streamDecoder := aDecoder.
]

{ #category : #accessing }
XMLDecodingReadStreamAdapter >> streamDecoder [
	^ streamDecoder
]

{ #category : #accessing }
XMLDecodingReadStreamAdapter >> streamDecoder: aStreamDecoder [
	streamDecoder := aStreamDecoder
]
