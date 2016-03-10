"
An automatic encoding detector for file streams wrapped by decoding read stream adapters. It assumes the wrapped stream supports reset.
"
Class {
	#name : #XMLFileStreamEncodingDetector,
	#superclass : #XMLEncodingDetector,
	#instVars : [
		'decodingReadStreamAdapter'
	],
	#category : #'XML-Parser-Streams'
}

{ #category : #'instance creation' }
XMLFileStreamEncodingDetector class >> on: aDecodingReadStreamAdapter [
	^ (super on: aDecodingReadStreamAdapter stream)
		decodingReadStreamAdapter: aDecodingReadStreamAdapter
]

{ #category : #private }
XMLFileStreamEncodingDetector >> decodeStreamWithConverter: aStreamConverter [
	decodingReadStreamAdapter streamConverter: aStreamConverter
]

{ #category : #private }
XMLFileStreamEncodingDetector >> decodingReadStreamAdapter: aDecodingReadStreamAdapter [
	decodingReadStreamAdapter := aDecodingReadStreamAdapter
]

{ #category : #private }
XMLFileStreamEncodingDetector >> pushBack: aString [
	"file streams should support reset"
	stream reset
]

{ #category : #private }
XMLFileStreamEncodingDetector >> pushBackCharacter: aCharacter [
	"file streams should support reset"
	stream reset
]
