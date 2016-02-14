Class {
	#name : #XMLPercentEncodingWriteStreamAdapterTest,
	#superclass : #XMLEncodingWriteStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLPercentEncodingWriteStreamAdapterTest >> adapterClass [
	^ XMLPercentEncodingWriteStreamAdapter
]

{ #category : #converting }
XMLPercentEncodingWriteStreamAdapterTest >> contentsFromCharacter: aCharacter [
	^ self percentEncode: aCharacter
]

{ #category : #accessing }
XMLPercentEncodingWriteStreamAdapterTest >> inputCollection [
	^ self decodedUTF8String
]

{ #category : #accessing }
XMLPercentEncodingWriteStreamAdapterTest >> outputCollection [
	^ self percentEncodedUTF8String
]

{ #category : #accessing }
XMLPercentEncodingWriteStreamAdapterTest >> streamConverterClass [
	^ XMLUTF8StreamConverter
]
