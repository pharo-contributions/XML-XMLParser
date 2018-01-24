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
XMLEncodingDetectorTest >> byteOrderMark [
	^ self explicitStreamConverterClass byteOrderMark
]

{ #category : #accessing }
XMLEncodingDetectorTest >> encodingDetectorClass [
	^ XMLEncodingDetector
]

{ #category : #accessing }
XMLEncodingDetectorTest >> explicitEncodedStrings [
	^ self implicitEncodedStrings collect: [:each |
		self byteOrderMark, each]
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
XMLEncodingDetectorTest >> implicitEncodedStrings [
	^ #()
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
XMLEncodingDetectorTest >> invalidImplicitEncodedStrings [
	^ #()
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

{ #category : #converting }
XMLEncodingDetectorTest >> stringsFromAll: aCollectionOfByteCollection [
	^ aCollectionOfByteCollection collect: [:each |
		XMLStreamAdapterTest stringFrom: each]
]

{ #category : #tests }
XMLEncodingDetectorTest >> testStreamConverterForEncoding [
	self explicitEncodedStrings do: [:each |
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
			assert: stream position = (startPosition + self byteOrderMark size)].

	self implicitEncodedStrings do: [:each |
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

	self invalidImplicitEncodedStrings do: [:each |
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
