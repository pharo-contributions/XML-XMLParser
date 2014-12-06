"
A stream decoder that uses Pharo TextConverter classes.
"
Class {
	#name : #XMLTextConverterStreamDecoder,
	#superclass : #XMLStreamDecoder,
	#instVars : [
		'textConverter'
	],
	#classVars : [
		'TextConverterCache'
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

{ #category : #'class initialization' }
XMLTextConverterStreamDecoder class >> initialize [
	"self initialize"

	TextConverterCache := XMLKeyValueCache maxSize: 32
]

{ #category : #'instance creation' }
XMLTextConverterStreamDecoder class >> newForEncoding: anEncoding [
	^ self new textConverter: (self textConverterForEncoding: anEncoding) new
]

{ #category : #'instance creation' }
XMLTextConverterStreamDecoder class >> textConverterForEncoding: anEncoding [
	^ TextConverterCache
		at: anEncoding
		ifAbsentPut: [
			(Smalltalk at: #TextConverter)
				defaultConverterClassForEncoding: anEncoding asLowercase]
]

{ #category : #decoding }
XMLTextConverterStreamDecoder >> nextFromStream: aStream [
	^ textConverter nextFromStream: aStream
]

{ #category : #accessing }
XMLTextConverterStreamDecoder >> textConverter [
	^ textConverter
]

{ #category : #accessing }
XMLTextConverterStreamDecoder >> textConverter: aTextConverter [
	textConverter := aTextConverter
]
