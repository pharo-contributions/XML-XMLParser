Class {
	#name : #XMLDecodingReadStreamAdapterUTF32BETest,
	#superclass : #XMLDecodingReadStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF32BETest >> inputCollection [
	^ self encodedUTF32BEString
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF32BETest >> outputCollection [
	^ self decodedUTF32String
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF32BETest >> streamConverterClass [
	^ XMLUTF32BigEndianStreamConverter
]
