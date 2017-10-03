"
A read stream adapter that decodes streams encoded with  sequences of ""%HH"" byte hex values for parsing URIs.
"
Class {
	#name : #XMLPercentDecodingReadStreamAdapter,
	#superclass : #XMLDecodingReadStreamAdapter,
	#category : #'XML-Parser-Streams'
}

{ #category : #testing }
XMLPercentDecodingReadStreamAdapter >> atEnd [
	^ peekChar == nil
		and: [stream atEnd
			or: [stream peek ~~ $%]]
]

{ #category : #private }
XMLPercentDecodingReadStreamAdapter >> basicNext [
	| byteValue |

	(stream atEnd not
		and: [stream peek == $%])
		ifFalse: [^ nil].
	stream next.

	byteValue :=
		XMLIntegerReader
			readFrom: stream
			withBase: 16
			upTo: 2.
	^ (byteValue ifNil: [$%]) asCharacter.
]
