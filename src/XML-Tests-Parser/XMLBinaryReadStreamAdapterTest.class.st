Class {
	#name : #XMLBinaryReadStreamAdapterTest,
	#superclass : #XMLReadStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #testing }
XMLBinaryReadStreamAdapterTest >> isBinary [
	^ true
]

{ #category : #accessing }
XMLBinaryReadStreamAdapterTest >> streamAdapterClass [
	^ XMLBinaryReadStreamAdapter
]
