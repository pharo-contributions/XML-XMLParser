Class {
	#name : #XMLDecodingReadStreamAdapterASCIITest,
	#superclass : #XMLDecodingReadStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLDecodingReadStreamAdapterASCIITest >> binaryInputCollection [
	^ self encodedASCIIBinary
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterASCIITest >> binaryInvalidInputCollections [
	^ (16r80 to: 16rFF) asArray collect: [:each | ByteArray with: each]
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterASCIITest >> outputCollection [
	^ self decodedASCIIString
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterASCIITest >> streamConverterClass [
	^ XMLASCIIStreamConverter
]
