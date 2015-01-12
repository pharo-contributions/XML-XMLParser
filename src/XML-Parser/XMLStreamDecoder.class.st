"
An abstract class for stream decoders.
"
Class {
	#name : #XMLStreamDecoder,
	#superclass : #Object,
	#instVars : [
		'encodingName'
	],
	#classVars : [
		'PreferredStreamDecoders',
		'StreamDecoderCache'
	],
	#classInstVars : [
		'encodingNames'
	],
	#category : #'XML-Parser-Streams'
}

{ #category : #private }
XMLStreamDecoder class >> basicEncodingNames [
	^ #()
]

{ #category : #testing }
XMLStreamDecoder class >> canDecodeEncoding: anEncoding [
	^ self encodingNames includes: anEncoding
]

{ #category : #accessing }
XMLStreamDecoder class >> defaultStreamDecoder [
	^ XMLUTF8StreamDecoder
]

{ #category : #accessing }
XMLStreamDecoder class >> encodingNames [
	^ encodingNames ifNil: [
		encodingNames := self basicEncodingNames asSet.
		self basicEncodingNames do: [:each |
			encodingNames
				add: each asLowercase;
				add: each asUppercase].
		encodingNames]
]

{ #category : #private }
XMLStreamDecoder class >> findStreamDecoderForEncoding: anEncoding [
	self preferredStreamDecoders do: [:each |
		(each canDecodeEncoding: anEncoding)
			ifTrue: [^ each]].

	self allSubclassesDo: [:each |
		((self preferredStreamDecoders includes: each) not
			and: [each canDecodeEncoding: anEncoding])
			ifTrue: [^ each]].

	^ nil.
]

{ #category : #'class initialization' }
XMLStreamDecoder class >> initialize [
	"self initialize"

	StreamDecoderCache := XMLKeyValueCache maxSize: 128.
	(PreferredStreamDecoders := IdentitySet new)
		addAll: XMLUTFStreamDecoder allSubclasses;
		add: XMLByteStreamDecoder.
]

{ #category : #testing }
XMLStreamDecoder class >> isDefaultStreamDecoder [
	^ self == self defaultStreamDecoder
]

{ #category : #'instance creation' }
XMLStreamDecoder class >> newForEncoding: anEncoding [
	^ (StreamDecoderCache
		at: anEncoding
		ifAbsentPut: [self findStreamDecoderForEncoding: anEncoding])
			ifNotNil: [:decoderClass |
				decoderClass new
					setEncodingName: anEncoding]
]

{ #category : #accessing }
XMLStreamDecoder class >> preferredStreamDecoders [
	^ PreferredStreamDecoders
]

{ #category : #accessing }
XMLStreamDecoder >> encodingName [
	^ encodingName
		ifNil: [encodingName := self class encodingName anyOne]
]

{ #category : #testing }
XMLStreamDecoder >> isDefaultStreamDecoder [
	^ self class isDefaultStreamDecoder
]

{ #category : #decoding }
XMLStreamDecoder >> nextFromStream: aStream [
	self subclassResponsibility
]

{ #category : #initialization }
XMLStreamDecoder >> setEncodingName: anEncodingName [
	encodingName := anEncodingName
]
