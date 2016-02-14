Class {
	#name : #XMLDecodingReadStreamAdapterUTF16BETest,
	#superclass : #XMLDecodingReadStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF16BETest >> inputCollection [
	^ self encodedUTF16BEString
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF16BETest >> outputCollection [
	^ self decodedUTF16String
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF16BETest >> streamConverterClass [
	^ XMLUTF16BigEndianStreamConverter
]
