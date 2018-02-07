Class {
	#name : #XMLPercentWriteStreamAdapterTest,
	#superclass : #XMLWriteStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #converting }
XMLPercentWriteStreamAdapterTest >> contentsFromCharacter: aCharacter [
	^ self class percentEncodeCharacter: aCharacter
]

{ #category : #accessing }
XMLPercentWriteStreamAdapterTest >> outputCollection [
	^ String streamContents: [:stream |
		super outputCollection do: [:each |
			stream nextPutAll:
				(self class percentEncodeCharacter: each)]]
]

{ #category : #accessing }
XMLPercentWriteStreamAdapterTest >> streamAdapterClass [
	^ XMLPercentWriteStreamAdapter
]
