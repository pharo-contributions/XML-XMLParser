Class {
	#name : #XMLEncodingWriteStreamAdapterUTF16BETest,
	#superclass : #XMLEncodingWriteStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #converting }
XMLEncodingWriteStreamAdapterUTF16BETest >> contentsFromCharacter: aCharacter [
	^ self class asciiToUTF16BE: aCharacter asString
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF16BETest >> inputCollection [
	^ self decodedUTF16String
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF16BETest >> invalidStreamCollections [
	^ self invalidInputCollections
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF16BETest >> outputCollection [
	^ self encodedUTF16BEString
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF16BETest >> streamConverterClass [
	^ XMLUTF16BigEndianStreamConverter
]
