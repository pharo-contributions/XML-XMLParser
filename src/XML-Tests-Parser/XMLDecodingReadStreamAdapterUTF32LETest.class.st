Class {
	#name : #XMLDecodingReadStreamAdapterUTF32LETest,
	#superclass : #XMLDecodingReadStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF32LETest >> inputCollection [
	^ self encodedUTF32LEString
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF32LETest >> outputCollection [
	^ self decodedUTF32String
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF32LETest >> streamConverterClass [
	^ XMLUTF32LittleEndianStreamConverter
]
