"
A stream converter that wraps the ZnByteEncoder legacy byte encoder class. (Requires Zinc.)
"
Class {
	#name : #XMLZincByteEncoderStreamConverter,
	#superclass : #XMLStreamConverter,
	#instVars : [
		'zincByteEncoder',
		'stringReadStreamAdapter',
		'nullStream'
	],
	#category : #'XML-Parser-Streams'
}

{ #category : #basic }
XMLZincByteEncoderStreamConverter class >> basicCanConvertEncoding: anEncodingName [
	^ XMLClassFinder
		classNamed: #ZnByteEncoder
		ifPresent: [:zincByteEncoderClass |
			zincByteEncoderClass handlesEncoding: anEncodingName]
		ifAbsent: [false]
]

{ #category : #initialization }
XMLZincByteEncoderStreamConverter >> initializeForEncoding: anEncodingName [
	zincByteEncoder :=
		(XMLClassFinder classNamed: #ZnByteEncoder) newForEncoding: anEncodingName.

	"we use an XMLStringReadStreamAdapter to transparently handle non-binary
	character streams for ZnByteEncoder, which exepcts binary streams, and
	since it's only ever set to a non-null stream during #nextFromStream:,
	instances can still be shared by multiple streams, just not re-entrently,
	which is OK since this class is explicitly stateful and doesn't promise
	thread-safety."
	nullStream := XMLNullReadStream new.
	stringReadStreamAdapter :=
		XMLStringReadStreamAdapter on: nullStream.
]

{ #category : #decoding }
XMLZincByteEncoderStreamConverter >> nextFromStream: aStream [
	"ZnByteEncoder does not check for #atEnd before sending #next"
	aStream atEnd
		ifTrue: [^ nil]
		ifFalse: [| nextChar |
			nextChar :=
				zincByteEncoder nextFromStream:
					(stringReadStreamAdapter on: aStream).
			stringReadStreamAdapter on: nullStream.
			^ nextChar]
]

{ #category : #encoding }
XMLZincByteEncoderStreamConverter >> nextPut: aCharacter toStream: aStream [
	zincByteEncoder
		nextPut: aCharacter
		toStream: aStream
]
