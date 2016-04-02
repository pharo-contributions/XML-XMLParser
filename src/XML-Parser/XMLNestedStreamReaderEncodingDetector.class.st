"
An automatic encoding detector for stream reader streams.
"
Class {
	#name : #XMLNestedStreamReaderEncodingDetector,
	#superclass : #XMLEncodingDetector,
	#instVars : [
		'streamReader'
	],
	#category : #'XML-Parser-Streams'
}

{ #category : #'instance creation' }
XMLNestedStreamReaderEncodingDetector class >> on: aStreamReader [
	^ (super on: aStreamReader stream)
		streamReader: aStreamReader
]

{ #category : #private }
XMLNestedStreamReaderEncodingDetector >> canSkipDetection [
	^ super canSkipDetection
		or: [stream isXMLConvertingStreamAdapter
			and: [stream hasDefaultStreamConverter not]]
]

{ #category : #private }
XMLNestedStreamReaderEncodingDetector >> decodeStreamWithConverter: aStreamConverter [
	streamReader decodeStreamWithConverter: aStreamConverter
]

{ #category : #private }
XMLNestedStreamReaderEncodingDetector >> pushBack: aString [
	streamReader pushBack: aString
]

{ #category : #private }
XMLNestedStreamReaderEncodingDetector >> pushBackCharacter: aCharacter [
	streamReader pushBackCharacter: aCharacter
]

{ #category : #private }
XMLNestedStreamReaderEncodingDetector >> streamReader: aStreamReader [
	streamReader := aStreamReader
]
