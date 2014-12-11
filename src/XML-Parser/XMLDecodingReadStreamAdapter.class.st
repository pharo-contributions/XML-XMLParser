"
This stream adapter decodes stream contents using a stream decoder.
"
Class {
	#name : #XMLDecodingReadStreamAdapter,
	#superclass : #XMLReadStreamAdapter,
	#instVars : [
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
	^ (self new on: aStream)
		streamDecoder: aDecoder
]

{ #category : #testing }
XMLDecodingReadStreamAdapter >> atEnd [
	^ peekChar == nil and: [stream atEnd]
]

{ #category : #accessing }
XMLDecodingReadStreamAdapter >> basicNext [
	stream atEnd
		ifTrue: [^ nil]
		ifFalse: [^ stream next].
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

{ #category : #accessing }
XMLDecodingReadStreamAdapter >> streamDecoder [
	^ streamDecoder
]

{ #category : #accessing }
XMLDecodingReadStreamAdapter >> streamDecoder: aStreamDecoder [
	streamDecoder := aStreamDecoder
]
