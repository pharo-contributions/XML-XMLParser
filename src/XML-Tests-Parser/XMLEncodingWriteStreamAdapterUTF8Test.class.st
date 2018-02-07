Class {
	#name : #XMLEncodingWriteStreamAdapterUTF8Test,
	#superclass : #XMLEncodingWriteStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF8Test >> binaryOutputCollection [
	^ self encodedUTF8Binary
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF8Test >> inputCollection [
	^ self decodedUTF8String
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF8Test >> streamConverterClass [
	^ XMLUTF8StreamConverter
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF8Test >> stringInvalidInputCollections [
	^ self stringInvalidUTFInputCollections
]
