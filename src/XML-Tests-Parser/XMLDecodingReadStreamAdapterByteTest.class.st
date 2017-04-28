Class {
	#name : #XMLDecodingReadStreamAdapterByteTest,
	#superclass : #XMLDecodingReadStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLDecodingReadStreamAdapterByteTest >> inputCollection [
	^ self encodedByteString
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterByteTest >> invalidEncodedInputCollections [
	^ Array with: (self stringFrom: #(16r100))
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterByteTest >> outputCollection [
	^ self decodedByteString
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterByteTest >> streamConverterClass [
	^ XMLByteStreamConverter
]
