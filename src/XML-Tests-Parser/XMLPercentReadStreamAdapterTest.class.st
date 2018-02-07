Class {
	#name : #XMLPercentReadStreamAdapterTest,
	#superclass : #XMLReadStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLPercentReadStreamAdapterTest >> inputCollection [
	^ String streamContents: [:stream |
		super inputCollection do: [:each |
			stream nextPutAll:
				(self class percentEncodeCharacter: each)]]
]

{ #category : #accessing }
XMLPercentReadStreamAdapterTest >> outputCollection [
	^ 'test' asByteArray
]

{ #category : #accessing }
XMLPercentReadStreamAdapterTest >> streamAdapterClass [
	^ XMLPercentReadStreamAdapter
]
