"
A read stream adapter that decodes stream contents using a stream decoder.
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
	^ (self new on: aStream) streamDecoder: aDecoder
]

{ #category : #'instance creation' }
XMLDecodingReadStreamAdapter class >> onExternalStream: aReadStream [
	^ self on: (XMLBinaryReadStreamAdapter onStreamIfBinary: aReadStream)
]

{ #category : #'instance creation' }
XMLDecodingReadStreamAdapter class >> onStreamIfBinary: aStream [
	| streamAdapter |

	(streamAdapter := XMLBinaryReadStreamAdapter onStreamIfBinary: aStream) == aStream
		ifTrue: [^ aStream]
		ifFalse: [^ self on: streamAdapter]
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

{ #category : #testing }
XMLDecodingReadStreamAdapter >> isDecodingReadStreamAdapter [
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

{ #category : #printing }
XMLDecodingReadStreamAdapter >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		print: streamDecoder;
		nextPut: $).
]

{ #category : #accessing }
XMLDecodingReadStreamAdapter >> streamDecoder [
	^ streamDecoder
]

{ #category : #accessing }
XMLDecodingReadStreamAdapter >> streamDecoder: aStreamDecoder [
	streamDecoder := aStreamDecoder
]
