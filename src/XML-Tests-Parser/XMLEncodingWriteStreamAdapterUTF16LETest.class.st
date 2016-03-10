Class {
	#name : #XMLEncodingWriteStreamAdapterUTF16LETest,
	#superclass : #XMLEncodingWriteStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #converting }
XMLEncodingWriteStreamAdapterUTF16LETest >> contentsFromCharacter: aCharacter [
	^ self asciiToUTF16LE: aCharacter asString
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF16LETest >> decodedInvalidCharacters [
	^ self decodedUnicodeInvalidCharacters
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF16LETest >> inputCollection [
	^ self decodedUTF16String
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF16LETest >> outputCollection [
	^ self encodedUTF16LEString
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterUTF16LETest >> streamConverterClass [
	^ XMLUTF16LittleEndianStreamConverter
]
