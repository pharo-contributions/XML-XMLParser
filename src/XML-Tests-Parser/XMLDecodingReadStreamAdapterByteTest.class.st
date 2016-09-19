Class {
	#name : #XMLDecodingReadStreamAdapterByteTest,
	#superclass : #XMLDecodingReadStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLDecodingReadStreamAdapterByteTest >> encodedInvalidCharacters [
	^ self stringFrom: #(16r0100)
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterByteTest >> inputCollection [
	^ self encodedByteString
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterByteTest >> outputCollection [
	^ self decodedByteString
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterByteTest >> streamConverterClass [
	^ XMLByteStreamConverter
]
