Class {
	#name : #XMLEncodingWriteStreamAdapterByteTest,
	#superclass : #XMLEncodingWriteStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLEncodingWriteStreamAdapterByteTest >> decodedInvalidCharacters [
	^ self decodedUnicodeInvalidCharacters copyWithFirst: 256 asCharacter
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterByteTest >> streamConverterClass [
	^ XMLByteStreamConverter
]
