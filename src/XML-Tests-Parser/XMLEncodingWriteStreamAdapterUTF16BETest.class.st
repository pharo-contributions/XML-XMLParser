Class {
	#name : #XMLEncodingWriteStreamAdapterUTF16BETest,
	#superclass : #XMLEncodingWriteStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF16BETest >> binaryOutputCollection [
	^ self encodedUTF16BEBinary
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF16BETest >> inputCollection [
	^ self decodedUTF16String
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF16BETest >> streamConverterClass [
	^ XMLUTF16BigEndianStreamConverter
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF16BETest >> stringInvalidInputCollections [
	^ self stringInvalidUTFInputCollections
]
