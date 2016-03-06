"
An abstract class for stream converters.

Subclasses need to implement nextFromStream: to use basicNext on the argument to read byte characters and decode them, and implement nextPut:toStream: to use basicNextPut:/basicNextPutByte: on the second argument to encode the first.

The class basicEncodingNames method should return a basic list of names for the encoding handled by the class, and byteOrderMarkBytes can return the bytes of a BOM if the encoding has one.
"
Class {
	#name : #XMLStreamConverter,
	#superclass : #Object,
	#instVars : [
		'encoding'
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

{ #category : #accessing }
XMLStreamConverter class >> anyEncodingName [
	^ self basicEncodingNames
		at: 1
		ifAbsent: ['']
]

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

{ #category : #accessing }
XMLStreamConverter class >> encodingNames: aSet [
	encodingNames := aSet
]

{ #category : #private }
XMLStreamConverter class >> encodingNamesAndClassesCache [
	^ EncodingNamesAndClassesCache
]

{ #category : #private }
XMLStreamConverter class >> findClassForEncoding: anEncodingName [
	"check preferred classes first"
	self preferredClasses do: [:each |
		(each canConvertEncoding: anEncodingName)
			ifTrue: [^ each]].

	(self isNonPreferredClassForEncoding: anEncodingName)
		ifTrue: [^ self].
	self allSubclassesDo: [:each |
		(each isNonPreferredClassForEncoding: anEncodingName)
			ifTrue: [^ each]].

	^ nil.
]

{ #category : #'class initialization' }
XMLStreamConverter class >> initialize [
	"self initialize"

	self
		initializeEncodingNamesAndClassesCache;
		initializePreferredClasses.
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
XMLStreamConverter class >> isNonPreferredClassForEncoding: anEncoding [
	^ self isPreferredClass not
		and: [self canConvertEncoding: anEncoding]
]

{ #category : #testing }
XMLStreamConverter class >> isPreferredClass [
	^ self preferredClasses includes: self
]

{ #category : #'instance creation' }
XMLStreamConverter class >> newForEncoding: anEncodingName [
	(self classForEncoding: anEncodingName)
		ifNil: [^ self null]
		ifNotNil: [:converterClass | ^ converterClass new encoding: anEncodingName]
]

{ #category : #'instance creation' }
XMLStreamConverter class >> null [
	^ XMLNullStreamConverter new
]

{ #category : #accessing }
XMLStreamConverter class >> preferredClasses [
	^ PreferredClasses
]

{ #category : #converting }
XMLStreamConverter >> asXMLStreamConverter [
	^ self
]

{ #category : #accessing }
XMLStreamConverter >> encoding [
	^ encoding ifNil: [encoding := self class anyEncodingName]
]

{ #category : #accessing }
XMLStreamConverter >> encoding: anEncodingName [
	encoding := anEncodingName
]

{ #category : #private }
XMLStreamConverter >> errorInvalidCharacter [
	XMLEncodingException
		formatSignal: 'Invalid {1} character'
		with: self encoding
]

{ #category : #testing }
XMLStreamConverter >> isDefault [
	^ self class isDefaultClass
]

{ #category : #testing }
XMLStreamConverter >> isNull [
	^ false
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
		nextPutAll: self encoding;
		nextPut: $).
]
