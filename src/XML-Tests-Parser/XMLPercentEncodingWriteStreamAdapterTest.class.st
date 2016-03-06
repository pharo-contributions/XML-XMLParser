Class {
	#name : #XMLPercentEncodingWriteStreamAdapterTest,
	#superclass : #XMLEncodingWriteStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #converting }
XMLPercentEncodingWriteStreamAdapterTest >> contentsFromCharacter: aCharacter [
	^ self percentEncodeCharacter: aCharacter
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
XMLPercentEncodingWriteStreamAdapterTest >> streamAdapterClass [
	^ XMLPercentEncodingWriteStreamAdapter
]

{ #category : #accessing }
XMLPercentEncodingWriteStreamAdapterTest >> streamConverterClass [
	^ XMLUTF8StreamConverter
]

{ #category : #'as yet unclassified' }
XMLPercentEncodingWriteStreamAdapterTest >> testNextPutByteOrderMark [
	self
		should: [self newStreamAdapter nextPutByteOrderMark]
		raise: Error
]
