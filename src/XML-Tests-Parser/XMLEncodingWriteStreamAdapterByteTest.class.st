Class {
	#name : #XMLEncodingWriteStreamAdapterByteTest,
	#superclass : #XMLEncodingWriteStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLEncodingWriteStreamAdapterByteTest >> inputCollection [
	^ self decodedByteString
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterByteTest >> outputCollection [
	^ self encodedByteString
]

{ #category : #accessing }
XMLEncodingWriteStreamAdapterByteTest >> streamConverterClass [
	^ XMLByteStreamConverter
]
