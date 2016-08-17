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
	"consider any stream that returns ints to be binary, because not every
	stream implements isBinary and it isn't portable to GS"
	(aStream atEnd not
		and: [aStream peek isInteger])
		ifTrue: [^ self on: aStream]
		ifFalse: [^ aStream]
]

{ #category : #private }
XMLBinaryReadStreamAdapter >> basicNext [
	stream atEnd
		ifTrue: [^ nil]
		ifFalse: [^ Character value: stream next]
]

{ #category : #accessing }
XMLBinaryReadStreamAdapter >> next [
	stream atEnd
		ifTrue: [^ nil]
		ifFalse: [^ Character value: stream next]
]

{ #category : #accessing }
XMLBinaryReadStreamAdapter >> peek [
	stream atEnd
		ifTrue: [^ nil]
		ifFalse: [^ Character value: stream peek]
]
