"
A write stream adapter that encodes streams with sequences of ""%HH"" hex byte values for printing URIs.
"
Class {
	#name : #XMLPercentEncodingWriteStreamAdapter,
	#superclass : #XMLEncodingWriteStreamAdapter,
	#category : #'XML-Parser-Streams'
}

{ #category : #private }
XMLPercentEncodingWriteStreamAdapter >> basicNextPut: aByteCharacter [
	| asciiValue |

	stream nextPut: $%.

	"pad it if needed"
	(asciiValue := aByteCharacter asciiValue) < 16
		ifTrue: [stream nextPut: $0].

	"printOn:base: on GS shows the radix, so printOn:base:showRadix:
	is used instead"
	asciiValue
		printOn: stream
		base: 16
		showRadix: false.
]

{ #category : #accessing }
XMLPercentEncodingWriteStreamAdapter >> nextPutByteOrderMark [
	self shouldNotImplement
]
