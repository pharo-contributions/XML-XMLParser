Class {
	#name : #XMLEncodingWriteStreamAdapterUTF8Test,
	#superclass : #XMLEncodingWriteStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF8Test >> inputCollection [
	^ self decodedUTF8String
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF8Test >> invalidStreamCollections [
	^ self invalidInputCollections
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF8Test >> outputCollection [
	^ self encodedUTF8String
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF8Test >> streamConverterClass [
	^ XMLUTF8StreamConverter
]
