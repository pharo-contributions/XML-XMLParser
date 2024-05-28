"
A state for before tokenizing has started.
"
Class {
	#name : 'XMLUninitializedState',
	#superclass : 'XMLTokenizerState',
	#category : 'XML-Parser-Drivers',
	#package : 'XML-Parser',
	#tag : 'Drivers'
}

{ #category : 'testing' }
XMLUninitializedState >> isInitializedState [
	^ false
]

{ #category : 'tokenizing' }
XMLUninitializedState >> nextTokenFrom: aTokenizer [
	^ aTokenizer nextStartDocument
]
