"
A stream converter that does no encoding or decoding.
"
Class {
	#name : #XMLNullStreamConverter,
	#superclass : #XMLStreamConverter,
	#category : #'XML-Parser-Streams'
}

{ #category : #testing }
XMLNullStreamConverter >> isNull [
	^ true
]

{ #category : #decoding }
XMLNullStreamConverter >> nextFromStream: aStream [
	^ aStream basicNext
]

{ #category : #encoding }
XMLNullStreamConverter >> nextPut: aCharacter toStream: aStream [
	aStream basicNextPut: aCharacter
]
