Class {
	#name : #XMLBinaryReadStreamAdapterTest,
	#superclass : #XMLReadStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLBinaryReadStreamAdapterTest >> adapterClass [
	^ XMLBinaryReadStreamAdapter
]

{ #category : #accessing }
XMLBinaryReadStreamAdapterTest >> inputCollection [
	^ super inputCollection asArray collect: [:each | each asciiValue]
]
