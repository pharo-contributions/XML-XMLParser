Class {
	#name : #XMLDecodingReadStreamAdapterUTF16LETest,
	#superclass : #XMLDecodingReadStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF16LETest >> inputCollection [
	^ self encodedUTF16LEString
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF16LETest >> outputCollection [
	^ self decodedUTF16String
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF16LETest >> streamConverterClass [
	^ XMLUTF16LittleEndianStreamConverter
]
