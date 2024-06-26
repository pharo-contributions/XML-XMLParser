"
A state for prolog tokens.
"
Class {
	#name : 'XMLPrologState',
	#superclass : 'XMLTokenizerState',
	#category : 'XML-Parser-Drivers',
	#package : 'XML-Parser',
	#tag : 'Drivers'
}

{ #category : 'testing' }
XMLPrologState >> canTerminateInput [
	^ false
]

{ #category : 'testing' }
XMLPrologState >> isPrologState [
	^ true
]

{ #category : 'tokenizing' }
XMLPrologState >> nextTokenFrom: aTokenizer [
	^ aTokenizer nextPrologToken
]
