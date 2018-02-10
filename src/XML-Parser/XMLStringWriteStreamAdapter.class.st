"
A write stream adapter that accepts binary input and converts it to character output for string write streams.
"
Class {
	#name : #XMLStringWriteStreamAdapter,
	#superclass : #XMLWriteStreamAdapter,
	#category : #'XML-Parser-Streams'
}

{ #category : #accessing }
XMLStringWriteStreamAdapter >> nextPut: anObject [
	stream nextPut: anObject asCharacter
]

{ #category : #accessing }
XMLStringWriteStreamAdapter >> nextPutAll: aCollection [
	aCollection do: [:each |
		stream nextPut: each asCharacter].
	^ aCollection.
]
