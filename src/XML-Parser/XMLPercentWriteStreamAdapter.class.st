"
A write stream adapter for percent encoding octets for URIs.
"
Class {
	#name : #XMLPercentWriteStreamAdapter,
	#superclass : #XMLWriteStreamAdapter,
	#category : #'XML-Parser-Streams'
}

{ #category : #accessing }
XMLPercentWriteStreamAdapter >> nextPut: anObject [
	| byte |

	stream nextPut: $%.

	"pad it if needed"
	(byte := anObject asInteger) < 16r10
		ifTrue: [stream nextPut: $0].

	"printOn:base: on GS shows the radix, so printOn:base:showRadix:
	is used instead"
	byte
		printOn: stream
		base: 16
		showRadix: false.
	^ anObject.
]

{ #category : #accessing }
XMLPercentWriteStreamAdapter >> nextPutAll: aCollection [
	aCollection do: [:each |
		self nextPut: each].
	^ aCollection.
]
