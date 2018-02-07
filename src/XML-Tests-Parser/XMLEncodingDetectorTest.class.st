"
Abstract, do not run.
"
Class {
	#name : #XMLEncodingDetectorTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #testing }
XMLEncodingDetectorTest class >> isAbstract [
	^ true
]

{ #category : #testing }
XMLEncodingDetectorTest class >> shouldInheritSelectors [
	^ true
]

{ #category : #accessing }
XMLEncodingDetectorTest >> binaryExplicitEncodedCollections [
	^ self binaryImplicitEncodedCollections collect: [:each |
		self byteOrderMarkBytes, each]
]

{ #category : #accessing }
XMLEncodingDetectorTest >> binaryImplicitEncodedCollections [
	^ #()
]

{ #category : #accessing }
XMLEncodingDetectorTest >> binaryInvalidImplicitEncodedCollections [
	^ #()
]

{ #category : #accessing }
XMLEncodingDetectorTest >> byteOrderMarkBytes [
	^ self explicitStreamConverterClass byteOrderMarkBytes
]

{ #category : #accessing }
XMLEncodingDetectorTest >> encodingDetectorClass [
	^ XMLEncodingDetector
]

{ #category : #accessing }
XMLEncodingDetectorTest >> explicitEncodedCollections [
	^ self isBinary
		ifTrue: [self binaryExplicitEncodedCollections]
		ifFalse: [self stringExplicitEncodedCollections]
]

{ #category : #accessing }
XMLEncodingDetectorTest >> explicitEncodingDetectorClass [
	^ XMLEncodingDetector
]

{ #category : #accessing }
XMLEncodingDetectorTest >> explicitStreamConverterClass [
	^ XMLStreamConverter
]

{ #category : #accessing }
XMLEncodingDetectorTest >> implicitEncodedCollections [
	^ self isBinary
		ifTrue: [self binaryImplicitEncodedCollections]
		ifFalse: [self stringImplicitEncodedCollections]
]

{ #category : #accessing }
XMLEncodingDetectorTest >> implicitEncodingDetectorClass [
	^ XMLImplicitEncodingDetector
]

{ #category : #accessing }
XMLEncodingDetectorTest >> implicitStreamConverterClass [
	^ XMLStreamConverter
]

{ #category : #accessing }
XMLEncodingDetectorTest >> invalidImplicitEncodedCollections [
	^ self isBinary
		ifTrue: [self binaryInvalidImplicitEncodedCollections]
		ifFalse: [self stringInvalidImplicitEncodedCollections]
]

{ #category : #testing }
XMLEncodingDetectorTest >> isBinary [
	^ true
]

{ #category : #'instance creation' }
XMLEncodingDetectorTest >> newExplicitEncodingDetectorOn: aStream [
	^ self explicitEncodingDetectorClass on: aStream
]

{ #category : #'instance creation' }
XMLEncodingDetectorTest >> newImplicitEncodingDetectorOn: aStream [
	^ self implicitEncodingDetectorClass on: aStream
]

{ #category : #'instance creation' }
XMLEncodingDetectorTest >> newStreamOn: aString [
	^ aString readStream
]

{ #category : #accessing }
XMLEncodingDetectorTest >> stringExplicitEncodedCollections [
	^ self stringsFromAll: self binaryExplicitEncodedCollections
]

{ #category : #accessing }
XMLEncodingDetectorTest >> stringImplicitEncodedCollections [
	^ self stringsFromAll: self binaryImplicitEncodedCollections
]

{ #category : #accessing }
XMLEncodingDetectorTest >> stringInvalidImplicitEncodedCollections [
	^ self stringsFromAll: self binaryInvalidImplicitEncodedCollections
]

{ #category : #converting }
XMLEncodingDetectorTest >> stringsFromAll: aCollectionOfByteCollection [
	^ aCollectionOfByteCollection collect: [:each |
		XMLStreamAdapterTest stringFrom: each]
]

{ #category : #tests }
XMLEncodingDetectorTest >> testStreamConverterForEncoding [
	self explicitEncodedCollections do: [:each |
		| stream startPosition streamConverter |
	
		stream := self newStreamOn: each.
		startPosition := stream position.
		streamConverter :=
			(self newExplicitEncodingDetectorOn: stream)
				streamConverterForEncoding.
		self
			deny: streamConverter isNil;
		 	assert: streamConverter class == self explicitStreamConverterClass;
			deny: streamConverter isImplicit;
			assert:
				stream position =
					(startPosition + self byteOrderMarkBytes size)].

	self implicitEncodedCollections do: [:each |
		| stream startPosition streamConverter |
	
		stream := self newStreamOn: each.
		startPosition := stream position.
		streamConverter :=
			(self newExplicitEncodingDetectorOn: stream)
				streamConverterForEncoding.
		self
			assert: streamConverter isNil;
			assert: stream position = startPosition.

		stream := self newStreamOn: each.
		startPosition := stream position.
		streamConverter :=
			(self newImplicitEncodingDetectorOn: stream)
				streamConverterForEncoding.
		self
			deny: streamConverter isNil;
		 	assert: streamConverter class == self implicitStreamConverterClass;
			assert: streamConverter isImplicit;
			assert: stream position = startPosition].

	self invalidImplicitEncodedCollections do: [:each |
		| stream startPosition streamConverter |

		stream := self newStreamOn: each.
		startPosition := stream position.
		streamConverter :=
			(self newImplicitEncodingDetectorOn: stream)
				streamConverterForEncoding.
		self
			assert: streamConverter isNil;
			assert: stream position = startPosition].
]
