Class {
	#name : 'XMLStringReadStreamAdapterTest',
	#superclass : 'XMLReadStreamAdapterTest',
	#category : 'XML-Parser-Tests-Streams',
	#package : 'XML-Parser-Tests',
	#tag : 'Streams'
}

{ #category : 'testing' }
XMLStringReadStreamAdapterTest >> expectsBinaryOutput [
	^ true
]

{ #category : 'accessing' }
XMLStringReadStreamAdapterTest >> streamAdapterClass [
	^ XMLStringReadStreamAdapter
]
