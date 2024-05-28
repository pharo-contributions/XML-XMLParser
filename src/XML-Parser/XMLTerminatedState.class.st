"
A state for when tokenizing has stopped.
"
Class {
	#name : 'XMLTerminatedState',
	#superclass : 'XMLTokenizerState',
	#category : 'XML-Parser-Drivers',
	#package : 'XML-Parser',
	#tag : 'Drivers'
}

{ #category : 'testing' }
XMLTerminatedState >> isTerminatedState [
	^ true
]

{ #category : 'tokenizing' }
XMLTerminatedState >> nextTokenFrom: aTokenizer [
	^ aTokenizer nextEndDocument
]
