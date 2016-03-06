Class {
	#name : #XMLBinaryReadStreamAdapterTest,
	#superclass : #XMLReadStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLBinaryReadStreamAdapterTest >> inputCollection [
	^ super inputCollection asArray collect: [:each | each asciiValue]
]

{ #category : #accessing }
XMLBinaryReadStreamAdapterTest >> streamAdapterClass [
	^ XMLBinaryReadStreamAdapter
]
