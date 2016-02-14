"
An abstract class for stream converters.

Subclasses need to implement nextFromStream: to use basicNext on the argument to read byte characters and decode them, and implement nextPut:toStream: to use basicNextPut:/basicNextPutByte: on the second argument to encode the first.

The class basicEncodingNames method should return a basic list of names for the encoding handled by the class, and byteOrderMarkBytes can return the bytes of a BOM if the encoding has one.
"
Class {
	#name : #XMLStreamConverter,
	#superclass : #Object,
	#instVars : [
		'encodingName'
	],
	#classVars : [
		'EncodingNamesAndClassesCache',
		'PreferredClasses'
	],
	#classInstVars : [
		'encodingNames'
	],
	#category : #'XML-Parser-Streams'
}

{ #category : #private }
XMLStreamConverter class >> basicEncodingNames [
	"encodingNames will have these names + upper/lowercase versions"
	^ #()
]

{ #category : #accessing }
XMLStreamConverter class >> byteOrderMark [
	"avoid asString for portability"
	^ String withAll: (self byteOrderMarkBytes collect: [:each | each asCharacter])
]

{ #category : #private }
XMLStreamConverter class >> byteOrderMarkBytes [
	^ #()
]

{ #category : #testing }
XMLStreamConverter class >> canConvertEncoding: anEncodingName [
	^ self encodingNames includes: anEncodingName
]

{ #category : #accessing }
XMLStreamConverter class >> classForEncoding: anEncodingName [
	^ self encodingNamesAndClassesCache
		at: anEncodingName
		ifAbsentPut: [self findClassForEncoding: anEncodingName]
]

{ #category : #'instance creation' }
XMLStreamConverter class >> default [
	^ self defaultClass new
]

{ #category : #accessing }
XMLStreamConverter class >> defaultClass [
	^ XMLUTF8StreamConverter
]

{ #category : #accessing }
XMLStreamConverter class >> defaultEncodingName [
	^ self basicEncodingNames
		at: 1
		ifAbsent: ['']
]

{ #category : #accessing }
XMLStreamConverter class >> encodingNames [
	^ encodingNames ifNil: [
		encodingNames := Set new.
		self basicEncodingNames do: [:each |
			encodingNames
				add: each;
				add: each asLowercase;
				add: each asUppercase].
		encodingNames]
]

{ #category : #private }
XMLStreamConverter class >> encodingNames: aSet [
	encodingNames := aSet
]

{ #category : #private }
XMLStreamConverter class >> encodingNamesAndClassesCache [
	^ EncodingNamesAndClassesCache
]

{ #category : #private }
XMLStreamConverter class >> findClassForEncoding: anEncodingName [
	self preferredClasses do: [:each |
		(each canConvertEncoding: anEncodingName)
			ifTrue: [^ each]].

	(self isPreferred not
		and: [self canConvertEncoding: anEncodingName])
			ifTrue: [^ self].
	self allSubclassesDo: [:each |
		(each isPreferred not
			and: [each canConvertEncoding: anEncodingName])
			ifTrue: [^ each]].

	^ nil.
]

{ #category : #'class initialization' }
XMLStreamConverter class >> initialize [
	"self initialize"

	self
		initializeEncodingNamesAndClassesCache;
		initializePreferredClasses
]

{ #category : #'class initialization' }
XMLStreamConverter class >> initializeEncodingNamesAndClassesCache [
	EncodingNamesAndClassesCache := XMLKeyValueCache maxSize: 128
]

{ #category : #'class initialization' }
XMLStreamConverter class >> initializePreferredClasses [
	(PreferredClasses := IdentitySet new)
		addAll: XMLUTFStreamConverter allSubclasses;
		add: XMLByteStreamConverter
]

{ #category : #testing }
XMLStreamConverter class >> isDefaultClass [
	^ self == self defaultClass
]

{ #category : #testing }
XMLStreamConverter class >> isPreferred [
	^ self preferredClasses includes: self
]

{ #category : #'instance creation' }
XMLStreamConverter class >> newForEncoding: anEncodingName [
	^ (self classForEncoding: anEncodingName)
		ifNotNil: [:converterClass |
			converterClass new encodingName: anEncodingName]
]

{ #category : #private }
XMLStreamConverter class >> preferredClasses [
	^ PreferredClasses
]

{ #category : #accessing }
XMLStreamConverter >> defaultEncodingName [
	^ self class defaultEncodingName
]

{ #category : #accessing }
XMLStreamConverter >> encodingName [
	^ encodingName ifNil: [encodingName := self defaultEncodingName]
]

{ #category : #accessing }
XMLStreamConverter >> encodingName: anEncodingName [
	encodingName := anEncodingName
]

{ #category : #private }
XMLStreamConverter >> errorInvalidCharacter [
	XMLEncodingException
		formatSignal: 'Invalid {1} character'
		with: self defaultEncodingName
]

{ #category : #testing }
XMLStreamConverter >> isDefault [
	^ self class isDefaultClass
]

{ #category : #decoding }
XMLStreamConverter >> nextFromStream: aStream [
	self subclassResponsibility
]

{ #category : #encoding }
XMLStreamConverter >> nextPut: aCharacter toStream: aStream [
	self subclassResponsibility
]

{ #category : #encoding }
XMLStreamConverter >> nextPutByteOrderMarkToStream: aStream [
	self class byteOrderMarkBytes do: [:each | aStream basicNextPutByte: each]
]

{ #category : #printing }
XMLStreamConverter >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self encodingName;
		nextPut: $).
]
