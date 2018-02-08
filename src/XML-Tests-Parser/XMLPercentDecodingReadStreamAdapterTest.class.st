Class {
	#name : #XMLPercentDecodingReadStreamAdapterTest,
	#superclass : #XMLReadStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLPercentDecodingReadStreamAdapterTest >> inputCollection [
	^ String streamContents: [:stream |
		super inputCollection do: [:each |
			stream nextPutAll:
				(self class percentEncodeCharacter: each)]]
]

{ #category : #testing }
XMLPercentDecodingReadStreamAdapterTest >> isBinary [
	^ true
]

{ #category : #accessing }
XMLPercentDecodingReadStreamAdapterTest >> outputCollection [
	^ 'test' asByteArray
]

{ #category : #accessing }
XMLPercentDecodingReadStreamAdapterTest >> streamAdapterClass [
	^ XMLPercentDecodingReadStreamAdapter
]
