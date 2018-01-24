"
An decoding read stream adapter for binary streams that implicitly converts bytes to character objects.
"
Class {
	#name : #XMLBinaryDecodingReadStreamAdapter,
	#superclass : #XMLDecodingReadStreamAdapter,
	#category : #'XML-Parser-Streams'
}

{ #category : #basic }
XMLBinaryDecodingReadStreamAdapter >> basicNext [
	stream atEnd
		ifTrue: [^ nil]
		ifFalse: [^ Character value: stream next]
]
