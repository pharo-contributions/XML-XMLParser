Class {
	#name : #XMLEncodingWriteStreamAdapterLatin1Test,
	#superclass : #XMLEncodingWriteStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLEncodingWriteStreamAdapterLatin1Test >> binaryOutputCollection [
	^ self encodedLatin1Binary
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterLatin1Test >> inputCollection [
	^ self decodedLatin1String
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterLatin1Test >> streamConverterClass [
	^ XMLLatin1StreamConverter
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterLatin1Test >> stringInvalidInputCollections [
	^ self stringInvalidLatin1InputCollections
]
