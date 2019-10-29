Class {
	#name : #XMLStringReadStreamAdapterTest,
	#superclass : #XMLReadStreamAdapterTest,
	#category : #'XML-Parser-Tests-Streams'
}

{ #category : #testing }
XMLStringReadStreamAdapterTest >> expectsBinaryOutput [
	^ true
]

{ #category : #accessing }
XMLStringReadStreamAdapterTest >> streamAdapterClass [
	^ XMLStringReadStreamAdapter
]
