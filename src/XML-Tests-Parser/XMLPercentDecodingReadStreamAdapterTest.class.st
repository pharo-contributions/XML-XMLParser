Class {
	#name : #XMLPercentDecodingReadStreamAdapterTest,
	#superclass : #XMLDecodingReadStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLPercentDecodingReadStreamAdapterTest >> adapterClass [
	^ XMLPercentDecodingReadStreamAdapter
]

{ #category : #accessing }
XMLPercentDecodingReadStreamAdapterTest >> inputCollection [
	^ self percentEncodedUTF8String
]

{ #category : #accessing }
XMLPercentDecodingReadStreamAdapterTest >> outputCollection [
	^ self decodedUTF8String
]

{ #category : #accessing }
XMLPercentDecodingReadStreamAdapterTest >> streamConverterClass [
	^ XMLUTF8StreamConverter
]
