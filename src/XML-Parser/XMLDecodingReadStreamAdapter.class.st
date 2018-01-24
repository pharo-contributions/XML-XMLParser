"
A read stream adapter that decodes stream contents using a stream converter. Used to handle encoded external streams.

The class  #on: and #on:streamConverter: instance creation messages accept character and binary streams.
"
Class {
	#name : #XMLDecodingReadStreamAdapter,
	#superclass : #XMLReadStreamAdapter,
	#instVars : [
		'peekChar',
		'prePeekStreamPosition',
		'streamConverter'
	],
	#category : #'XML-Parser-Streams'
}

{ #category : #defaults }
XMLDecodingReadStreamAdapter class >> binaryReadStreamAdapterClass [
	^ XMLBinaryDecodingReadStreamAdapter
]

{ #category : #'instance creation' }
XMLDecodingReadStreamAdapter class >> nonDecodingOn: aStream [
	^ self
		on: aStream
		streamConverter: XMLStreamConverter null
]

{ #category : #'instance creation' }
XMLDecodingReadStreamAdapter class >> nonDecodingOnIfBinary: aStream [
	^ (self isBinary: aStream)
		ifTrue: [
			self
				on: aStream
				streamConverter: XMLStreamConverter null]
		ifFalse: [nil]
]

{ #category : #'instance creation' }
XMLDecodingReadStreamAdapter class >> on: aStream [
	^ self
		on: aStream
		streamConverter: XMLStreamConverter default
]

{ #category : #'instance creation' }
XMLDecodingReadStreamAdapter class >> on: aStream streamConverter: aStreamConverter [
	| binaryReadStreamAdapterClass |

	binaryReadStreamAdapterClass := self binaryReadStreamAdapterClass.
	^ (((aStream class == binaryReadStreamAdapterClass
		or: [self isBinary: aStream])
		ifTrue: [binaryReadStreamAdapterClass]
		ifFalse: [self])
			basicOn: aStream)
				streamConverter: aStreamConverter.
]

{ #category : #testing }
XMLDecodingReadStreamAdapter >> atEnd [
	^ peekChar == nil
		and: [stream atEnd]
]

{ #category : #decoding }
XMLDecodingReadStreamAdapter >> detectEncoding [
	prePeekStreamPosition := nil.
	peekChar := nil.
	stream reset.

	(((self hasNullStreamConverter
		or: [self hasImplicitStreamConverter])
		ifTrue: [XMLImplicitEncodingDetector]
		ifFalse: [XMLEncodingDetector])
			on: stream) streamConverterForEncoding
				ifNotNil: [:converter |
					self streamConverter: converter].
]

{ #category : #testing }
XMLDecodingReadStreamAdapter >> hasDefaultStreamConverter [
	^ streamConverter isDefault
]

{ #category : #testing }
XMLDecodingReadStreamAdapter >> hasImplicitStreamConverter [
	^ streamConverter isImplicit
]

{ #category : #testing }
XMLDecodingReadStreamAdapter >> hasNullStreamConverter [
	^ streamConverter isNull
]

{ #category : #testing }
XMLDecodingReadStreamAdapter >> isXMLConvertingStreamAdapter [
	^ true
]

{ #category : #accessing }
XMLDecodingReadStreamAdapter >> next [
	peekChar
		ifNil: [^ streamConverter nextFromStream: self]
		ifNotNil: [:nextChar |
			prePeekStreamPosition := nil.
			peekChar := nil.
			^ nextChar]
]

{ #category : #accessing }
XMLDecodingReadStreamAdapter >> peek [
	^ peekChar
		ifNil: [
			prePeekStreamPosition := stream position.
			peekChar := streamConverter nextFromStream: self]
]

{ #category : #positioning }
XMLDecodingReadStreamAdapter >> position [
	^ prePeekStreamPosition ifNil: [stream position]
]

{ #category : #positioning }
XMLDecodingReadStreamAdapter >> position: anInteger [
	prePeekStreamPosition := nil.
	peekChar := nil.
	stream position: anInteger.
]

{ #category : #printing }
XMLDecodingReadStreamAdapter >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		print: streamConverter;
		nextPut: $).
]

{ #category : #positioning }
XMLDecodingReadStreamAdapter >> reset [
	prePeekStreamPosition := nil.
	peekChar := nil.
	stream reset.
]

{ #category : #accessing }
XMLDecodingReadStreamAdapter >> streamConverter [
	^ streamConverter
]

{ #category : #accessing }
XMLDecodingReadStreamAdapter >> streamConverter: aStreamConverter [
	streamConverter :=
		aStreamConverter ifNil: [XMLStreamConverter null].
	peekChar
		ifNotNil: [
			stream position: prePeekStreamPosition.
			prePeekStreamPosition := nil.
			peekChar := nil].
]
