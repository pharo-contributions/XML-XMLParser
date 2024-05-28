"
Abstract; do not run.
"
Class {
	#name : 'XMLHTTPMessageTest',
	#superclass : 'TestCase',
	#category : 'XML-Parser-Tests-HTTP',
	#package : 'XML-Parser-Tests',
	#tag : 'HTTP'
}

{ #category : 'testing' }
XMLHTTPMessageTest class >> isAbstract [
	^ true
]

{ #category : 'testing' }
XMLHTTPMessageTest class >> shouldInheritSelectors [
	^ true
]

{ #category : 'asserting' }
XMLHTTPMessageTest >> assertMessage: aMessage hasHeaders: anAssociationCollection [
	| addedHeaders |

	addedHeaders := OrderedCollection new.
	"use #associationsDo: to support Dictionaries and SequenceableCollections"
	anAssociationCollection associationsDo: [:each |
		addedHeaders add: each].
	self assert: aMessage headers sorted equals: addedHeaders sorted
]

{ #category : 'accessing' }
XMLHTTPMessageTest >> headerDictionaryFrom: aSequenceableCollection [
	| headerDictionary |

	headerDictionary := Dictionary new.
	aSequenceableCollection associationsDo: [:each |
		headerDictionary add: each].
	^ headerDictionary
]

{ #category : 'accessing' }
XMLHTTPMessageTest >> headerKeysFrom: aSequenceableCollection [
	^ aSequenceableCollection collect: [:each | each key]
]

{ #category : 'accessing' }
XMLHTTPMessageTest >> headerValuesAt: aKey from: aSequenceableCollection [
	| headerValues |

	headerValues := OrderedCollection new.
	aSequenceableCollection do: [:each |
		(each key = aKey)
			ifTrue: [headerValues addLast: each value]].
	^ headerValues
]

{ #category : 'accessing' }
XMLHTTPMessageTest >> headerValuesFrom: aSequenceableCollection [
	^ aSequenceableCollection collect: [:each | each value]
]

{ #category : 'accessing' }
XMLHTTPMessageTest >> headers [
	^ OrderedCollection
		with: 'X-Unique-One' -> 'zero'
		with: 'X-Duplicate' -> 'one'
		with: 'X-Unique-Two' -> 'two'
		with: 'X-Duplicate' -> 'three'
]

{ #category : 'testing' }
XMLHTTPMessageTest >> isSupported [
	^ self messageClass hasSupportedImplementation
]

{ #category : 'accessing' }
XMLHTTPMessageTest >> messageClass [
	^ XMLHTTPMessage
]

{ #category : 'instance creation' }
XMLHTTPMessageTest >> newMessage [
	^ self messageClass new
]

{ #category : 'tests' }
XMLHTTPMessageTest >> testAddHeader [
	| message addedHeaders |

	self isSupported
		ifFalse: [^ self].

	message := self newMessage.
	addedHeaders := message headers.
	self headers do: [:each |
		self deny: (message headers includes: each).

		self assert: (message addHeader: each) equals: each.
		addedHeaders addLast: each.
		self
			assertMessage: message
			hasHeaders: addedHeaders].

	SystemVersion current major >= 10
		ifFalse: [^ self].

	self headers do: [:each |
		self assert: (message addHeader: each) equals: each.
		self
			assertMessage: message
			hasHeaders: addedHeaders]
]

{ #category : 'tests' }
XMLHTTPMessageTest >> testContent [

	| message |
	self isSupported ifFalse: [ ^ self ].

	message := self newMessage.
	self
		assert: message content equals: '';
		assert: (message content: 'test') identicalTo: message;
		assert: message content equals: 'test'
]

{ #category : 'tests' }
XMLHTTPMessageTest >> testContentCharset [

	| message firstType secondType |
	self isSupported ifFalse: [ ^ self ].

	message := self newMessage.
	firstType := XMLHTTPMIMEType
		             mainType: 'application'
		             subType: 'xml'
		             parameters:
		             (OrderedCollection with: 'charset' -> 'utf8').
	secondType := XMLHTTPMIMEType mainType: 'text' subType: 'html'.
	self
		assert: message contentType isNil;
		assert: (message contentType: firstType) identicalTo: message;
		assert: message contentCharset equals: firstType charset;
		assert: (message contentType: secondType) identicalTo: message;
		assert: message contentCharset equals: secondType charset;
		assert: (message contentType: nil) identicalTo: message;
		assert: message contentCharset
		equals: XMLHTTPMIMEType defaultCharset.

	message headerAt: 'Content-Type' put: firstType asString.
	self assert: message contentCharset equals: firstType charset.

	message removeHeaderAt: 'Content-Type'.
	self
		assert: message contentCharset
		equals: XMLHTTPMIMEType defaultCharset
]

{ #category : 'tests' }
XMLHTTPMessageTest >> testContentEncoding [

	| message defaultValue absentValue |
	self isSupported ifFalse: [ ^ self ].

	message := self newMessage.
	defaultValue := OrderedCollection new.
	absentValue := defaultValue.
	self
		assert: message contentEncoding equals: defaultValue;
		assert: (message contentEncoding: 'one') identicalTo: message;
		assert: message contentEncoding
		equals: #( 'one' ) asOrderedCollection;
		assert: (message contentEncoding: ' one, identity, two')
		identicalTo: message;
		assert: message contentEncoding
		equals: #( 'one' 'two' ) asOrderedCollection;
		assert: (message contentEncoding: #( 'one' )) identicalTo: message;
		assert: message contentEncoding
		equals: #( 'one' ) asOrderedCollection;
		assert: (message contentEncoding: #( 'one' 'identity' 'two' ))
		identicalTo: message;
		assert: message contentEncoding
		equals: #( 'one' 'two' ) asOrderedCollection;
		assert: (message contentEncoding: '') identicalTo: message;
		assert: message contentEncoding equals: absentValue;
		assert: (message contentEncoding: #(  )) identicalTo: message;
		assert: message contentEncoding equals: absentValue.

	message
		headerAt: 'Content-Encoding'
		put: 'identity,one,identity,two,identity,three,identity'.
	self
		assert: message contentEncoding
		equals: #( 'one' 'two' 'three' ) asOrderedCollection.

	message removeHeaderAt: 'Content-Encoding'.
	self assert: message contentEncoding equals: absentValue
]

{ #category : 'tests' }
XMLHTTPMessageTest >> testContentLength [

	| message |
	self isSupported ifFalse: [ ^ self ].

	message := self newMessage.
	self
		assert: message contentLength isNil;
		assert: (message contentLength: 100) identicalTo: message;
		assert: message contentLength equals: 100;
		assert: (message contentLength: nil) identicalTo: message;
		assert: message contentLength isNil;
		assert: (message contentLength: nil) identicalTo: message;
		assert: message contentLength isNil.

	message headerAt: 'Content-Length' put: '200'.
	self assert: message contentLength equals: 200.

	message removeHeaderAt: 'Content-Length'.
	self assert: message contentLength isNil
]

{ #category : 'tests' }
XMLHTTPMessageTest >> testContentType [

	| message firstType secondType |
	self isSupported ifFalse: [ ^ self ].

	message := self newMessage.
	firstType := XMLHTTPMIMEType mainType: 'application' subType: 'xml'.
	secondType := XMLHTTPMIMEType mainType: 'text' subType: 'html'.
	self
		assert: message contentType isNil;
		assert: (message contentType: firstType) identicalTo: message;
		assert: message contentType equals: firstType;
		deny: message contentType equals: secondType;
		assert: (message contentType: nil) identicalTo: message;
		assert: message contentType isNil;
		assert: (message contentType: nil) identicalTo: message;
		assert: message contentType isNil.

	message headerAt: 'Content-Type' put: secondType asString.
	self
		assert: message contentType equals: secondType;
		deny: message contentType equals: firstType.

	message removeHeaderAt: 'Content-Type'.
	self assert: message contentType isNil
]

{ #category : 'tests' }
XMLHTTPMessageTest >> testHasContent [
	| message |

	self isSupported
		ifFalse: [^ self].

	message := self newMessage.
	self deny: message hasContent.

	message content: 'test'.
	self assert: message hasContent
]

{ #category : 'tests' }
XMLHTTPMessageTest >> testHasHeaders [

	| message |
	self isSupported ifFalse: [ ^ self ].

	message := self newMessage.
	self assert: message hasHeaders equals: message headers isNotEmpty.

	message removeHeaders.
	self deny: message hasHeaders.

	message addHeader: self headers first.
	self assert: message hasHeaders
]

{ #category : 'tests' }
XMLHTTPMessageTest >> testHeaderAt [

	| message addedHeaderDictionary |
	self isSupported ifFalse: [ ^ self ].

	message := self newMessage.
	addedHeaderDictionary := self headerDictionaryFrom: message headers.
	self headers do: [ :each |
		self
			assert: (message headerAt: each key)
			equals: (addedHeaderDictionary at: each key ifAbsent: [ '' ]).

		message headerAt: each key put: each value.
		addedHeaderDictionary add: each.
		self assert: (message headerAt: each key) equals: each value ].

	self headers do: [ :each | message addHeader: each ].
	addedHeaderDictionary keysAndValuesDo: [ :key :value |
		self assert: (message headerAt: key) equals: value ]
]

{ #category : 'tests' }
XMLHTTPMessageTest >> testHeaderAtIfAbsent [

	| message addedHeaderDictionary |
	self isSupported ifFalse: [ ^ self ].

	message := self newMessage.
	addedHeaderDictionary := self headerDictionaryFrom: message headers.
	self headers do: [ :each |
		self
			assert: (message headerAt: each key ifAbsent: [ #absent ])
			equals: (addedHeaderDictionary at: each key ifAbsent: [ #absent ]).

		message headerAt: each key put: each value.
		addedHeaderDictionary add: each.
		self
			assert: (message headerAt: each key ifAbsent: [ self fail ])
			equals: each value ].

	self headers do: [ :each | message addHeader: each ].
	addedHeaderDictionary keysAndValuesDo: [ :key :value |
		self
			assert: (message headerAt: key ifAbsent: [ self fail ])
			equals: value ]
]

{ #category : 'tests' }
XMLHTTPMessageTest >> testHeaderAtIfAbsentPut [

	| message addedHeaderDictionary |
	self isSupported ifFalse: [ ^ self ].

	message := self newMessage.
	addedHeaderDictionary := self headerDictionaryFrom: message headers.
	self headers do: [ :each |
		self
			assert: (message headerAt: each key ifAbsentPut: [ each value ])
			equals:
			(addedHeaderDictionary at: each key ifAbsentPut: [ each value ]).
		self
			assert: (message headerAt: each key)
			equals: (addedHeaderDictionary at: each key).
		self
			assertMessage: message
			hasHeaders: addedHeaderDictionary associations ]
]

{ #category : 'tests' }
XMLHTTPMessageTest >> testHeaderAtPut [

	| message addedHeaderDictionary |
	self isSupported ifFalse: [ ^ self ].

	message := self newMessage.
	addedHeaderDictionary := self headerDictionaryFrom: message headers.
	self headers do: [ :each |
		self
			assert: (message headerAt: each key put: each value)
			equals: each value.
		addedHeaderDictionary add: each.
		self assert: (message headerAt: each key) equals: each value.
		self
			assertMessage: message
			hasHeaders: addedHeaderDictionary associations ]
]

{ #category : 'tests' }
XMLHTTPMessageTest >> testHeaderKeys [

	| message addedHeaderKeys |
	self isSupported ifFalse: [ ^ self ].

	message := self newMessage.
	addedHeaderKeys := self headerKeysFrom: message headers.
	self headers do: [ :each |
		self
			assert: message headerKeys sorted
			equals: addedHeaderKeys sorted.

		message addHeader: each.
		addedHeaderKeys add: each key.
		self
			assert: message headerKeys sorted
			equals: addedHeaderKeys sorted ]
]

{ #category : 'tests' }
XMLHTTPMessageTest >> testHeaderKeysAndValuesDo [
	| message addedHeaders |

	self isSupported
		ifFalse: [^ self].

	message := self newMessage.
	addedHeaders := message headers.
	self
		xmlShould: [:block | message headerKeysAndValuesDo: block]
		unorderedEnumerate: (self headerKeysFrom: addedHeaders)
		and: (self headerValuesFrom: addedHeaders).

	self headers do: [:each |
		message addHeader: each.
		addedHeaders addLast: each].
	self
		xmlShould: [:block | message headerKeysAndValuesDo: block]
		unorderedEnumerate: (self headerKeysFrom: addedHeaders)
		and: (self headerValuesFrom: addedHeaders)
]

{ #category : 'tests' }
XMLHTTPMessageTest >> testHeaderKeysDo [
	| message addedHeaders |

	self isSupported
		ifFalse: [^ self].

	message := self newMessage.
	addedHeaders := message headers.
	self
		xmlShould: [:block | message headerKeysDo: block]
		unorderedEnumerate: (self headerKeysFrom: addedHeaders).

	self headers do: [:each |
		message addHeader: each.
		addedHeaders addLast: each].
	self
		xmlShould: [:block | message headerKeysDo: block]
		unorderedEnumerate: (self headerKeysFrom: addedHeaders)
]

{ #category : 'tests' }
XMLHTTPMessageTest >> testHeaderValuesAt [

	| message addedHeaders |
	self isSupported ifFalse: [ ^ self ].

	message := self newMessage.
	addedHeaders := message headers.
	self headers do: [ :each |
		self
			assert: (message headerValuesAt: each key) sorted
			equals: (self headerValuesAt: each key from: addedHeaders) sorted.

		message addHeader: each.
		addedHeaders addLast: each.
		self
			assert: (message headerValuesAt: each key) sorted
			equals: (self headerValuesAt: each key from: addedHeaders) sorted ]
]

{ #category : 'tests' }
XMLHTTPMessageTest >> testHeaderValuesAtAdd [
	| message addedHeaders |

	self isSupported
		ifFalse: [^ self].

	message := self newMessage.
	addedHeaders := message headers.
	self headers do: [:each |
		self deny: (message headers includes: each).

		self assert:
			(message
				headerValuesAt: each key
				add: each value) equals: each value.
		addedHeaders addLast: each.
		self
			assertMessage: message
			hasHeaders: addedHeaders].

	SystemVersion current major >= 10
		ifFalse: [^ self].

	self headers do: [:each |
		self assert:
			(message
				headerValuesAt: each key
				add: each value) equals: each value.
		self
			assertMessage: message
			hasHeaders: addedHeaders]
]

{ #category : 'tests' }
XMLHTTPMessageTest >> testHeaderValuesAtDo [
	| message addedHeaders |

	self isSupported
		ifFalse: [^ self].

	message := self newMessage.
	addedHeaders := message headers.
	(self headerKeysFrom: addedHeaders) do: [:each |
		self
			xmlShould: [:block |
				message
					headerValuesAt: each
					do: block]
			unorderedEnumerate:
				(self
					headerValuesAt: each
					from: addedHeaders)].

	self headers do: [:each |
		message addHeader: each.
		addedHeaders addLast: each].
	(self headerKeysFrom: addedHeaders) do: [:each |
		self
			xmlShould: [:block |
				message
					headerValuesAt: each
					do: block]
			unorderedEnumerate:
				(self
					headerValuesAt: each
					from: addedHeaders)].
]

{ #category : 'tests' }
XMLHTTPMessageTest >> testHeaders [

	| message addedHeaders |
	self isSupported ifFalse: [ ^ self ].

	message := self newMessage.
	addedHeaders := message headers.
	self
		assert: addedHeaders class identicalTo: OrderedCollection;
		assert: addedHeaders equals: message headers;
		deny: addedHeaders identicalTo: message headers
]

{ #category : 'tests' }
XMLHTTPMessageTest >> testIncludesHeaderAt [

	| message addedHeaderKeys |
	self isSupported ifFalse: [ ^ self ].

	message := self newMessage.
	addedHeaderKeys := self headerKeysFrom: message headers.
	self headers do: [ :each |
		self
			assert: (message includesHeaderAt: each key)
			equals: (addedHeaderKeys includes: each key).

		message addHeader: each.
		addedHeaderKeys add: each key.
		self assert: (message includesHeaderAt: each key) ]
]

{ #category : 'tests' }
XMLHTTPMessageTest >> testRemoveHeaderAt [

	| message addedHeaders addedHeaderKeys |
	self isSupported ifFalse: [ ^ self ].

	message := self newMessage.
	addedHeaders := message headers.
	self headers do: [ :each |
		message addHeader: each.
		addedHeaders addLast: each ].
	addedHeaderKeys := (addedHeaders collect: [ :each | each key ]) asSet.
	addedHeaderKeys do: [ :each |
		self
			assert: (message removeHeaderAt: each) sorted
			equals: (self headerValuesAt: each from: addedHeaders) sorted.
		self
			should: [ message removeHeaderAt: each ]
			raise: XMLHTTPException ]
]

{ #category : 'tests' }
XMLHTTPMessageTest >> testRemoveHeaderAtIfAbsent [

	| message addedHeaders addedHeaderKeys |
	self isSupported ifFalse: [ ^ self ].

	message := self newMessage.
	addedHeaders := message headers.
	self headers do: [ :each |
		message addHeader: each.
		addedHeaders addLast: each ].
	addedHeaderKeys := (addedHeaders collect: [ :each | each key ]) asSet.
	addedHeaderKeys do: [ :each |
		self
			assert:
			(message removeHeaderAt: each ifAbsent: [ self fail ]) sorted
			equals: (self headerValuesAt: each from: addedHeaders) sorted.
		self
			assert: (message removeHeaderAt: each ifAbsent: [ #absent ])
			equals: #absent ]
]

{ #category : 'tests' }
XMLHTTPMessageTest >> testRemoveHeaders [

	| message empty |
	self isSupported ifFalse: [ ^ self ].

	message := self newMessage.
	empty := OrderedCollection new.
	self assert: message removeHeaders identicalTo: message.
	self assertMessage: message hasHeaders: empty.

	self headers do: [ :each | message addHeader: each ].
	self assertMessage: message hasHeaders: self headers.
	self assert: message removeHeaders identicalTo: message.
	self assertMessage: message hasHeaders: empty
]
