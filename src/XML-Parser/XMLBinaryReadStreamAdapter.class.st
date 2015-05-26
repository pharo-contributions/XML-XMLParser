"
A read stream adapter for binary streams so that next and peek return characters instead of integers.
"
Class {
	#name : #XMLBinaryReadStreamAdapter,
	#superclass : #XMLReadStreamAdapter,
	#category : #'XML-Parser-Streams'
}

{ #category : #'instance creation' }
XMLBinaryReadStreamAdapter class >> onStreamIfBinary: aStream [
	(aStream atEnd
		or: [aStream peek isCharacter])
		ifTrue: [^ aStream]
		ifFalse: [^ self on: aStream]
]

{ #category : #testing }
XMLBinaryReadStreamAdapter >> atEnd [
	^ stream atEnd
]

{ #category : #accessing }
XMLBinaryReadStreamAdapter >> basicNext [
	^ Character value: stream next
]

{ #category : #accessing }
XMLBinaryReadStreamAdapter >> next [
	^ Character value: stream next
]

{ #category : #accessing }
XMLBinaryReadStreamAdapter >> peek [
	^ Character value: stream peek
]
