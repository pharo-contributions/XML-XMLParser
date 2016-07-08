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

{ #category : #testing }
XMLTextConverterStreamConverter class >> canConvertEncoding: anEncodingName [
	^ (self textConverterClassForEncoding: anEncodingName) notNil
]

{ #category : #private }
XMLTextConverterStreamConverter class >> encodingNamesAndTextConverterClassesCache [
	^ EncodingNamesAndTextConverterClassesCache
		ifNil: [
			EncodingNamesAndTextConverterClassesCache :=
				XMLKeyValueCache maxSize: 32]
]

{ #category : #private }
XMLTextConverterStreamConverter class >> findTextConverterClassForEncoding: anEncoding [
	^ (XMLClassFinder
		classNamed: #TextConverter
		ifAbsent: [^ nil])
			defaultConverterClassForEncoding: anEncoding asLowercase
]

{ #category : #accessing }
XMLTextConverterStreamConverter class >> textConverterClassForEncoding: anEncodingName [
	^ self encodingNamesAndTextConverterClassesCache
		at: anEncodingName
		ifAbsentPut: [self findTextConverterClassForEncoding: anEncodingName]
]

{ #category : #accessing }
XMLTextConverterStreamConverter >> encoding: anEncodingName [
	super encoding: anEncodingName.
	self textConverter:
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

{ #category : #accessing }
XMLTextConverterStreamConverter >> textConverter [
	^ textConverter
]

{ #category : #accessing }
XMLTextConverterStreamConverter >> textConverter: aTextConverter [
	textConverter := aTextConverter
]
