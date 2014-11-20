"
An abstract class for stream decoders.
"
Class {
	#name : #XMLStreamDecoder,
	#superclass : #Object,
	#classVars : [
		'PreferredStreamDecoders',
		'StreamDecoderCache'
	],
	#category : #'XML-Parser-Streams'
}

{ #category : #testing }
XMLStreamDecoder class >> canDecodeEncoding: anEncoding [
	^ false
]

{ #category : #accessing }
XMLStreamDecoder class >> defaultStreamDecoder [
	^ XMLUTF8StreamDecoder
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
	PreferredStreamDecoders := IdentitySet newFrom: XMLUTFStreamDecoder allSubclasses.
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
			ifNotNil: [:decoderClass | decoderClass newForEncoding: anEncoding]
]

{ #category : #accessing }
XMLStreamDecoder class >> preferredStreamDecoders [
	^ PreferredStreamDecoders
]

{ #category : #testing }
XMLStreamDecoder >> isDefaultStreamDecoder [
	^ self class isDefaultStreamDecoder
]

{ #category : #decoding }
XMLStreamDecoder >> nextFromStream: aStream [
	self subclassResponsibility
]
