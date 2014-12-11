"
An abstract class for Unicode stream decoders.
"
Class {
	#name : #XMLUTFStreamDecoder,
	#superclass : #XMLStreamDecoder,
	#classInstVars : [
		'encodingNames'
	],
	#category : #'XML-Parser-Streams'
}

{ #category : #private }
XMLUTFStreamDecoder class >> basicEncodingNames [
	^ #()
]

{ #category : #accessing }
XMLUTFStreamDecoder class >> byteOrderMark [
	^ String newFrom: (self byteOrderMarkBytes collect: [:each | each asCharacter])
]

{ #category : #private }
XMLUTFStreamDecoder class >> byteOrderMarkBytes [
	^ #()
]

{ #category : #testing }
XMLUTFStreamDecoder class >> canDecodeEncoding: anEncoding [
	^ self encodingNames includes: anEncoding
]

{ #category : #accessing }
XMLUTFStreamDecoder class >> encodingNames [
	^ encodingNames ifNil: [
		encodingNames := self basicEncodingNames asSet.
		self basicEncodingNames do: [:each |
			encodingNames
				add: each asLowercase;
				add: each asUppercase].
		encodingNames]
]

{ #category : #'instance creation' }
XMLUTFStreamDecoder class >> newForEncoding: anEncoding [
	^ self new
]

{ #category : #converting }
XMLUTFStreamDecoder >> characterWithValue: aCodePoint [
	aCodePoint > 16r10FFFF
		ifTrue: [self errorInvalidCodePoint].

	^ Character value: aCodePoint.
]

{ #category : #private }
XMLUTFStreamDecoder >> errorInvalidCodePoint [
	self subclassResponsibility
]
