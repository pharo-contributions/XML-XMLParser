"
An abstract class for stream converters.

Subclasses need to implement #nextFromStream: to use #basicNext on the argument to read byte characters and decode them, and implement #nextPut:toStream: to use #basicNextPut:/#basicNextPutByte: on the second argument to encode the first.

The class #basicEncodingNames method should return a basic list of names for the encoding handled by the class, and #byteOrderMarkBytes can return the bytes of a BOM if the encoding has one.
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

{ #category : #basic }
XMLStreamConverter class >> basicByteOrderMarkBytes [
	^ #()
]

{ #category : #basic }
XMLStreamConverter class >> basicCanConvertEncoding: anEncodingName [
	^ self encodingNames includes: anEncodingName
]

{ #category : #basic }
XMLStreamConverter class >> basicEncodingNames [
	"encodingNames will have these names + upper/lowercase versions"
	^ #()
]

{ #category : #accessing }
XMLStreamConverter class >> byteOrderMark [
	"avoid #asString and #newFrom: for GS portability"
	^ String withAll: (self basicByteOrderMarkBytes collect: [:each | each asCharacter])
]

{ #category : #testing }
XMLStreamConverter class >> canConvertEncoding: anEncodingName [
	"Returns true if the receiver can decode the encoding anEncodingName.
	Lookup is case-insensitive."

	"we could remove whitespace from anEncodingName too, but the
	production rule for <?xml ...?> 'encoding' attributes disallows
	whitespace, and the HTML parser removes it from <meta> charset
	attributes before converting, so we just convert it to lowercase"
	^ self basicCanConvertEncoding: anEncodingName asLowercase
]

{ #category : #accessing }
XMLStreamConverter class >> classForEncoding: anEncodingName [
	"avoid #at:ifAbsent: and #at:ifAbsentPut: so the cache isn't locked
	during the class lookup, which could stall other processes"
	self encodingNamesAndClassesCache
		at: anEncodingName
		ifPresent: [:classForEncoding | ^ classForEncoding].

	"this will store the class as nil if it wasn't found to prevent future lookup"
	^ self encodingNamesAndClassesCache
		at: anEncodingName
		put: (self findClassForEncoding: anEncodingName).
]

{ #category : #'instance creation' }
XMLStreamConverter class >> default [
	^ self defaultClass new
]

{ #category : #defaults }
XMLStreamConverter class >> defaultClass [
	^ XMLUTF8StreamConverter
]

{ #category : #defaults }
XMLStreamConverter class >> defaultEncoding [
	^ self defaultClass primaryEncodingName
]

{ #category : #accessing }
XMLStreamConverter class >> encodingNames [
	^ encodingNames
		ifNil: [
			"assign the fully initialized object with #yourself to avoid
			possible race conditions when reinitialization the class"
			encodingNames :=
				Set new
					addAll: self basicEncodingNames;
					addAll:
						(self basicEncodingNames collect: [:each | each asLowercase]);
					addAll:
						(self basicEncodingNames collect: [:each | each asUppercase]);
					yourself]
]

{ #category : #accessing }
XMLStreamConverter class >> encodingNames: aCollectionOrNil [
	encodingNames :=
		aCollectionOrNil
			ifNotNil: [aCollectionOrNil asSet]
]

{ #category : #private }
XMLStreamConverter class >> encodingNamesAndClassesCache [
	"a class variable so it's shared by all subclasses, but lazy initialized
	so it isn't initialized unless needed"
	^ EncodingNamesAndClassesCache
		ifNil: [EncodingNamesAndClassesCache := XMLKeyValueCache maxSize: 128]
]

{ #category : #private }
XMLStreamConverter class >> findClassForEncoding: anEncodingName [
	"check preferred classes first"
	self preferredClasses do: [:each |
		(each canConvertEncoding: anEncodingName)
			ifTrue: [^ each]].

	"avoid #withAllSubclassesDo: because it does not enumerate the receiver first"
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

	PreferredClasses := nil.
	"reset to nil instead of just clearing to get full reinitialization"
	EncodingNamesAndClassesCache := nil.
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
		ifNotNil: [:converterClass |
			^ converterClass new initializeForEncoding: anEncodingName]
]

{ #category : #'instance creation' }
XMLStreamConverter class >> null [
	^ self nullClass new
]

{ #category : #defaults }
XMLStreamConverter class >> nullClass [
	^ XMLNullStreamConverter
]

{ #category : #accessing }
XMLStreamConverter class >> preferredClasses [
	"A class var because it should be shared by all subclasses.
	Assign the fully initialized object with #yourself to avoid
	possible race conditions when reinitialization the class."
	^ PreferredClasses
		ifNil: [
			PreferredClasses :=
				IdentitySet new
					addAll: XMLUTFStreamConverter allSubclasses;
					add: XMLByteStreamConverter;
					yourself]
]

{ #category : #accessing }
XMLStreamConverter class >> preferredClasses: aCollectionOrNil [
	PreferredClasses :=
		aCollectionOrNil
			ifNotNil: [aCollectionOrNil asSet]
]

{ #category : #accessing }
XMLStreamConverter class >> primaryEncodingName [
	^ self basicEncodingNames
		at: 1
		ifAbsent: ['']
]

{ #category : #converting }
XMLStreamConverter >> asXMLStreamConverter [
	^ self
]

{ #category : #accessing }
XMLStreamConverter >> encoding [
	^ self class primaryEncodingName
]

{ #category : #private }
XMLStreamConverter >> errorBadCharacterEncoding [
	XMLEncodingException
		formatSignal: 'Invalid {1} encoding for character'
		with: self encoding
]

{ #category : #private }
XMLStreamConverter >> errorBadCharacterValue: aValue [
	XMLEncodingException
		formatSignal: 'Invalid character 0x{1} for {2} encoding'
		with: aValue printStringHex
		with: self encoding
]

{ #category : #initialization }
XMLStreamConverter >> initializeForEncoding: anEncodingName [
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
	self class basicByteOrderMarkBytes do: [:each |
		aStream basicNextPutByte: each]
]

{ #category : #printing }
XMLStreamConverter >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self encoding;
		nextPut: $).
]
