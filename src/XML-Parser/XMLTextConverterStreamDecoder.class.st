"
A stream decoder that uses Pharo TextConverter classes.
"
Class {
	#name : #XMLTextConverterStreamDecoder,
	#superclass : #XMLStreamDecoder,
	#instVars : [
		'textConverter'
	],
	#classInstVars : [
		'textConverterCache'
	],
	#category : #'XML-Parser-Streams'
}

{ #category : #testing }
XMLTextConverterStreamDecoder class >> canDecodeEncoding: anEncoding [
	^ (Smalltalk includesKey: #TextConverter)
		and: [(self textConverterForEncoding: anEncoding) notNil]
]

{ #category : #private }
XMLTextConverterStreamDecoder class >> textConverterCache [
	^ textConverterCache
		ifNil: [textConverterCache := XMLKeyValueCache maxSize: 32]
]

{ #category : #private }
XMLTextConverterStreamDecoder class >> textConverterForEncoding: anEncoding [
	^ self textConverterCache
		at: anEncoding
		ifAbsentPut: [
			(Smalltalk at: #TextConverter)
				defaultConverterClassForEncoding: anEncoding asLowercase]
]

{ #category : #decoding }
XMLTextConverterStreamDecoder >> nextFromStream: aStream [
	^ textConverter nextFromStream: aStream
]

{ #category : #initialization }
XMLTextConverterStreamDecoder >> setEncodingName: anEncodingName [
	super setEncodingName: anEncodingName.
	self textConverter:
		(self class textConverterForEncoding: anEncodingName) new.
]

{ #category : #accessing }
XMLTextConverterStreamDecoder >> textConverter [
	^ textConverter
]

{ #category : #accessing }
XMLTextConverterStreamDecoder >> textConverter: aTextConverter [
	textConverter := aTextConverter
]
