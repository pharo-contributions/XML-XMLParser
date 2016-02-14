"
A read stream adapter that decodes stream contents using a stream converter. Used to handle encoded external streams.
"
Class {
	#name : #XMLDecodingReadStreamAdapter,
	#superclass : #XMLReadStreamAdapter,
	#instVars : [
		'peekChar',
		'streamConverter'
	],
	#category : #'XML-Parser-Streams'
}

{ #category : #'instance creation' }
XMLDecodingReadStreamAdapter class >> on: aStream [
	^ self
		on: aStream
		streamConverter: XMLStreamConverter default
]

{ #category : #'instance creation' }
XMLDecodingReadStreamAdapter class >> on: aStream streamConverter: aStreamConverter [
	^ self new
		on: (XMLBinaryReadStreamAdapter onStreamIfBinary: aStream);
		streamConverter: aStreamConverter
]

{ #category : #'instance creation' }
XMLDecodingReadStreamAdapter class >> onStreamIfBinary: aStream [
	| streamAdapter |

	streamAdapter := XMLBinaryReadStreamAdapter onStreamIfBinary: aStream.
	streamAdapter == aStream
		ifTrue: [^ aStream]
		ifFalse: [
			^ self new
				on: streamAdapter;
				streamConverter: XMLStreamConverter default]
]

{ #category : #testing }
XMLDecodingReadStreamAdapter >> atEnd [
	^ peekChar == nil and: [stream atEnd]
]

{ #category : #testing }
XMLDecodingReadStreamAdapter >> hasDefaultStreamConverter [
	^ streamConverter isDefault
]

{ #category : #testing }
XMLDecodingReadStreamAdapter >> isConvertingStreamAdapter [
	^ true
]

{ #category : #accessing }
XMLDecodingReadStreamAdapter >> next [
	peekChar
		ifNil: [^ streamConverter nextFromStream: self]
		ifNotNil: [:nextChar |
			peekChar := nil.
			^ nextChar]
]

{ #category : #accessing }
XMLDecodingReadStreamAdapter >> peek [
	^ peekChar
		ifNil: [peekChar := streamConverter nextFromStream: self]
]

{ #category : #printing }
XMLDecodingReadStreamAdapter >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		print: streamConverter;
		nextPut: $).
]

{ #category : #accessing }
XMLDecodingReadStreamAdapter >> streamConverter [
	^ streamConverter
]

{ #category : #accessing }
XMLDecodingReadStreamAdapter >> streamConverter: aStreamConverter [
	streamConverter :=
		(aStreamConverter ifNil: [XMLNullStreamConverter new])
]
