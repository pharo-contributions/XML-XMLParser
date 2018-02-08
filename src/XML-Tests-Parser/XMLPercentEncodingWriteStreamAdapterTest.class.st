Class {
	#name : #XMLPercentEncodingWriteStreamAdapterTest,
	#superclass : #XMLWriteStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #converting }
XMLPercentEncodingWriteStreamAdapterTest >> contentsFromCharacter: aCharacter [
	^ self class percentEncodeCharacter: aCharacter
]

{ #category : #testing }
XMLPercentEncodingWriteStreamAdapterTest >> isBinary [
	^ true
]

{ #category : #accessing }
XMLPercentEncodingWriteStreamAdapterTest >> outputCollection [
	^ String streamContents: [:stream |
		super outputCollection do: [:each |
			stream nextPutAll:
				(self class percentEncodeCharacter: each)]]
]

{ #category : #accessing }
XMLPercentEncodingWriteStreamAdapterTest >> streamAdapterClass [
	^ XMLPercentEncodingWriteStreamAdapter
]
