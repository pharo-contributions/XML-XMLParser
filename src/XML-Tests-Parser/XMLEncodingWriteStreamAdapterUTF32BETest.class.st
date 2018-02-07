Class {
	#name : #XMLEncodingWriteStreamAdapterUTF32BETest,
	#superclass : #XMLEncodingWriteStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF32BETest >> binaryOutputCollection [
	^ self encodedUTF32BEBinary
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF32BETest >> inputCollection [
	^ self decodedUTF32String
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF32BETest >> streamConverterClass [
	^ XMLUTF32BigEndianStreamConverter
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF32BETest >> stringInvalidInputCollections [
	^ self stringInvalidUTFInputCollections
]
