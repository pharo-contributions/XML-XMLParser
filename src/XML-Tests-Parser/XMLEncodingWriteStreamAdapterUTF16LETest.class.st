Class {
	#name : #XMLEncodingWriteStreamAdapterUTF16LETest,
	#superclass : #XMLEncodingWriteStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #converting }
XMLEncodingWriteStreamAdapterUTF16LETest >> contentsFromCharacter: aCharacter [
	^ self class asciiToUTF16LE: aCharacter asString
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF16LETest >> inputCollection [
	^ self decodedUTF16String
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF16LETest >> invalidStreamCollections [
	^ self invalidInputCollections
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF16LETest >> outputCollection [
	^ self encodedUTF16LEString
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF16LETest >> streamConverterClass [
	^ XMLUTF16LittleEndianStreamConverter
]
