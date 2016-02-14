Class {
	#name : #XMLDecodingReadStreamAdapterUTF8Test,
	#superclass : #XMLDecodingReadStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF8Test >> inputCollection [
	^ self encodedUTF8String
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF8Test >> outputCollection [
	^ self decodedUTF8String
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF8Test >> streamConverterClass [
	^ XMLUTF8StreamConverter
]
