Class {
	#name : #XMLPercentDecodingReadStreamAdapterTest,
	#superclass : #XMLDecodingReadStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLPercentDecodingReadStreamAdapterTest >> inputCollection [
	^ self percentEncodedUTF8String
]

{ #category : #accessing }
XMLPercentDecodingReadStreamAdapterTest >> outputCollection [
	^ self decodedUTF8String
]

{ #category : #accessing }
XMLPercentDecodingReadStreamAdapterTest >> streamAdapterClass [
	^ XMLPercentDecodingReadStreamAdapter
]

{ #category : #accessing }
XMLPercentDecodingReadStreamAdapterTest >> streamConverterClass [
	^ XMLUTF8StreamConverter
]
