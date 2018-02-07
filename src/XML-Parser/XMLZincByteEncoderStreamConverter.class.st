"
A stream converter that wraps the ZnByteEncoder legacy byte encoder class. (Requires Zinc.)
"
Class {
	#name : #XMLZincByteEncoderStreamConverter,
	#superclass : #XMLStreamConverter,
	#instVars : [
		'zincByteEncoder'
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
		(XMLClassFinder classNamed: #ZnByteEncoder) newForEncoding: anEncodingName
]

{ #category : #decoding }
XMLZincByteEncoderStreamConverter >> nextFromStream: aStream [
	"ZnByteEncoder does not check for #atEnd before sending #next"
	aStream atEnd
		ifTrue: [^ nil]
		ifFalse: [^ zincByteEncoder nextFromStream: aStream]
]

{ #category : #encoding }
XMLZincByteEncoderStreamConverter >> nextPut: aCharacter toStream: aStream [
	zincByteEncoder
		nextPut: aCharacter
		toStream: aStream
]
