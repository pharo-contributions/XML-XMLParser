Class {
	#name : #XMLEncodingWriteStreamAdapterUTF32LETest,
	#superclass : #XMLEncodingWriteStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF32LETest >> binaryOutputCollection [
	^ self encodedUTF32LEBinary
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF32LETest >> inputCollection [
	^ self decodedUTF32String
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF32LETest >> streamConverterClass [
	^ XMLUTF32LittleEndianStreamConverter
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF32LETest >> stringInvalidInputCollections [
	^ self stringInvalidUTFInputCollections
]
