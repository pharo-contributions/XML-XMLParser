Class {
	#name : #XMLEncodingWriteStreamAdapterUTF8Test,
	#superclass : #XMLEncodingWriteStreamAdapterTest,
	#category : #'XML-Parser-Tests-Streams'
}

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF8Test >> basicInputCollection [
	^ self decodedUTF8String
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF8Test >> basicInvalidInputCollections [
	^ self basicInvalidUTFInputCollections
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF8Test >> basicOutputCollection [
	^ self encodedUTF8Binary
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF8Test >> streamConverterClass [
	^ XMLUTF8StreamConverter
]
