"
This class percent decodes octets for URIs.
"
Class {
	#name : #XMLPercentReadStreamAdapter,
	#superclass : #XMLReadStreamAdapter,
	#category : #'XML-Parser-Streams'
}

{ #category : #testing }
XMLPercentReadStreamAdapter >> atEnd [
	^ stream atEnd
		or: [stream peek ~~ $%]
]

{ #category : #accessing }
XMLPercentReadStreamAdapter >> next [
	| byte |

	(stream atEnd not
		and: [stream peek == $%])
		ifTrue: [
			stream next.
			byte :=
				(XMLSmallIntegerReader
					readFrom: stream
					withBase: 16
					upToLimit: 2)
						ifNil: [37] "$% asciiValue"].
	^ byte.
]

{ #category : #accessing }
XMLPercentReadStreamAdapter >> peek [
	| byte |

	stream atEnd
		ifFalse: [| oldPosition |
			oldPosition := stream position.
			byte := self next.
			stream position: oldPosition].
	^ byte.
]

{ #category : #defaults }
XMLPercentReadStreamAdapter >> writeStreamCollectionClass [
	^ ByteArray
]
