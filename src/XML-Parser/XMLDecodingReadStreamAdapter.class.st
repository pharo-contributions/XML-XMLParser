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

{ #category : #private }
XMLDecodingReadStreamAdapter class >> basicOn: aStream streamConverter: aStreamConverter [
	^ self new
		on: aStream;
		streamConverter: aStreamConverter
]

{ #category : #'instance creation' }
XMLDecodingReadStreamAdapter class >> on: aStream [
	^ self
		on: aStream
		streamConverter: XMLStreamConverter default
]

{ #category : #'instance creation' }
XMLDecodingReadStreamAdapter class >> on: aStream streamConverter: aStreamConverter [
	^ self
		basicOn: (XMLBinaryReadStreamAdapter onStreamIfBinary: aStream)
		streamConverter: aStreamConverter
]

{ #category : #'instance creation' }
XMLDecodingReadStreamAdapter class >> onStreamIfBinary: aStream [
	| binaryReadStreamAdapter |

	binaryReadStreamAdapter :=
		XMLBinaryReadStreamAdapter onStreamIfBinary: aStream.
	binaryReadStreamAdapter == aStream
		ifTrue: [^ aStream]
		ifFalse: [
			^ self
				basicOn: binaryReadStreamAdapter
				streamConverter: XMLStreamConverter default].
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
	(XMLEncodingDetector on: stream) streamConverterForEncoding
		ifNotNil: [:converter |
			self streamConverter: converter].
]

{ #category : #testing }
XMLDecodingReadStreamAdapter >> hasDefaultStreamConverter [
	^ streamConverter isDefault
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
