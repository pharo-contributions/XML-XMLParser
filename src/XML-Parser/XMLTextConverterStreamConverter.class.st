"
A stream converter that delegates to a Pharo/Squeak TextConverter subclass. This will only be used on Pharo/Squeak if none of the other XML stream converters support the specified encoding but a TextConverter subclass does.
"
Class {
	#name : #XMLTextConverterStreamConverter,
	#superclass : #XMLStreamConverter,
	#instVars : [
		'textConverter'
	],
	#classVars : [
		'EncodingNamesAndTextConverterClassesCache'
	],
	#category : #'XML-Parser-Streams'
}

{ #category : #basic }
XMLTextConverterStreamConverter class >> basicCanConvertEncoding: anEncodingName [
	^ (self textConverterClassForEncoding: anEncodingName) notNil
]

{ #category : #private }
XMLTextConverterStreamConverter class >> encodingNamesAndTextConverterClassesCache [
	^ EncodingNamesAndTextConverterClassesCache
		ifNil: [
			EncodingNamesAndTextConverterClassesCache := XMLKeyValueCache maxSize: 32]
]

{ #category : #private }
XMLTextConverterStreamConverter class >> findTextConverterClassForEncoding: anEncoding [
	"#defaultConverterClassForEncoding: expects the name to be in lowercase"
	^ (XMLClassFinder
		classNamed: #TextConverter
		ifAbsent: [^ nil])
			defaultConverterClassForEncoding: anEncoding asLowercase
]

{ #category : #'class initialization' }
XMLTextConverterStreamConverter class >> initialize [
	"self initialize"

	"reset to nil instead of just clearing to get full reinitialization"
	EncodingNamesAndTextConverterClassesCache := nil
]

{ #category : #accessing }
XMLTextConverterStreamConverter class >> textConverterClassForEncoding: anEncodingName [
	"Returns the TextConverter class for anEncodingName (case insensitive)"

	"avoid #at:ifAbsent: and #at:ifAbsentPut: so the cache isn't locked
	during the class lookup, which could stall other processes"
	self encodingNamesAndTextConverterClassesCache
		at: anEncodingName
		ifPresent: [:classForEncoding | ^ classForEncoding].

	"this will store the class as nil if it wasn't found to prevent future lookup"
	^ self encodingNamesAndTextConverterClassesCache
		at: anEncodingName
		put: (self findTextConverterClassForEncoding: anEncodingName)
]

{ #category : #accessing }
XMLTextConverterStreamConverter >> encoding [
	^ encoding
]

{ #category : #initialization }
XMLTextConverterStreamConverter >> initializeForEncoding: anEncodingName [
	super initializeForEncoding: anEncodingName.
 
	self
		setEncoding: anEncodingName
		textConverter:
			(self class textConverterClassForEncoding: anEncodingName) new.
]

{ #category : #decoding }
XMLTextConverterStreamConverter >> nextFromStream: aStream [
	^ textConverter nextFromStream: aStream
]

{ #category : #encoding }
XMLTextConverterStreamConverter >> nextPut: aCharacter toStream: aStream [
	textConverter
		nextPut: aCharacter
		toStream: aStream
]

{ #category : #initialization }
XMLTextConverterStreamConverter >> setEncoding: anEncodingName textConverter: aTextConverter [
	encoding := anEncodingName.
	textConverter := aTextConverter.
]

{ #category : #accessing }
XMLTextConverterStreamConverter >> textConverter [
	^ textConverter
]
