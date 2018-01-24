"
A read stream adapter that decodes streams encoded with  sequences of ""%HH"" byte hex values for parsing URIs.
"
Class {
	#name : #XMLPercentDecodingReadStreamAdapter,
	#superclass : #XMLDecodingReadStreamAdapter,
	#category : #'XML-Parser-Streams'
}

{ #category : #defaults }
XMLPercentDecodingReadStreamAdapter class >> binaryReadStreamAdapterClass [
	^ XMLBinaryPercentDecodingReadStreamAdapter
]

{ #category : #testing }
XMLPercentDecodingReadStreamAdapter >> atEnd [
	^ peekChar == nil
		and: [stream atEnd
			or: [stream peek ~~ $%]]
]

{ #category : #basic }
XMLPercentDecodingReadStreamAdapter >> basicNext [
	| byteValue |

	(stream atEnd not
		and: [stream peek == $%])
		ifFalse: [^ nil].
	stream next.

	byteValue :=
		XMLSmallIntegerReader
			readFrom: stream
			withBase: 16
			upToLimit: 2.
	^ (byteValue ifNil: [$%]) asCharacter.
]
