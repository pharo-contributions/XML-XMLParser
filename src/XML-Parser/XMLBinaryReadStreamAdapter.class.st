"
A read stream adapter for binary streams so that next and peek return characters instead of integers.
"
Class {
	#name : #XMLBinaryReadStreamAdapter,
	#superclass : #XMLReadStreamAdapter,
	#category : #'XML-Parser-Streams'
}

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
