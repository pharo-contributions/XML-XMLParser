Class {
	#name : #XMLEncodingWriteStreamAdapterUTF32LETest,
	#superclass : #XMLEncodingWriteStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #converting }
XMLEncodingWriteStreamAdapterUTF32LETest >> contentsFromCharacter: aCharacter [
	^ self class asciiToUTF32LE: aCharacter asString
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF32LETest >> inputCollection [
	^ self decodedUTF32String
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF32LETest >> invalidStreamCollections [
	^ self invalidInputCollections
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF32LETest >> outputCollection [
	^ self encodedUTF32LEString
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF32LETest >> streamConverterClass [
	^ XMLUTF32LittleEndianStreamConverter
]
