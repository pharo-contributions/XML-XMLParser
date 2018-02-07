Class {
	#name : #XMLEncodingWriteStreamAdapterUTF16LETest,
	#superclass : #XMLEncodingWriteStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF16LETest >> binaryOutputCollection [
	^ self encodedUTF16LEBinary
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF16LETest >> inputCollection [
	^ self decodedUTF16String
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF16LETest >> streamConverterClass [
	^ XMLUTF16LittleEndianStreamConverter
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF16LETest >> stringInvalidInputCollections [
	^ self stringInvalidUTFInputCollections
]
