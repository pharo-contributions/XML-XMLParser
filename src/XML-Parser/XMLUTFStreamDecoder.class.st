"
An abstract class for Unicode stream decoders.
"
Class {
	#name : #XMLUTFStreamDecoder,
	#superclass : #XMLStreamDecoder,
	#category : #'XML-Parser-Streams'
}

{ #category : #accessing }
XMLUTFStreamDecoder class >> byteOrderMark [
	"avoid asString for portability"
	^ String withAll: (self byteOrderMarkBytes collect: [:each | each asCharacter])
]

{ #category : #private }
XMLUTFStreamDecoder class >> byteOrderMarkBytes [
	^ #()
]

{ #category : #converting }
XMLUTFStreamDecoder >> characterWithValue: aCodePoint [
	aCodePoint > 16r10FFFF
		ifTrue: [self errorInvalidCodePoint].

	^ Character value: aCodePoint.
]

{ #category : #private }
XMLUTFStreamDecoder >> errorInvalidCodePoint [
	self subclassResponsibility
]
