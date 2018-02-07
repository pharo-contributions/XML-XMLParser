Class {
	#name : #XMLEncodingWriteStreamAdapterASCIITest,
	#superclass : #XMLEncodingWriteStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLEncodingWriteStreamAdapterASCIITest >> binaryOutputCollection [
	^ self encodedASCIIBinary
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterASCIITest >> inputCollection [
	^ self decodedASCIIString
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterASCIITest >> streamConverterClass [
	^ XMLASCIIStreamConverter
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterASCIITest >> stringInvalidInputCollections [
	^ self stringInvalidLatin1InputCollections,
		((16r80 to: 16rFF) asArray collect: [:each |
			String with: each asCharacter])
]
