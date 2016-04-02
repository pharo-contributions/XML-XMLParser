"
An abstract class for read stream adapters for basic streams that support next, peek, and atEnd.
"
Class {
	#name : #XMLReadStreamAdapter,
	#superclass : #XMLStreamAdapter,
	#category : #'XML-Parser-Streams'
}

{ #category : #'instance creation' }
XMLReadStreamAdapter class >> onStreamIfBinary: aStream [
	"consider any stream that returns ints to be binary, because not every
	stream implements isBinary and it isn't portable to GS"
	(aStream atEnd not
		and: [aStream peek isInteger])
		ifTrue: [^ self on: aStream]
		ifFalse: [^ aStream]
]

{ #category : #testing }
XMLReadStreamAdapter >> atEnd [
	^ stream atEnd
]

{ #category : #private }
XMLReadStreamAdapter >> basicNext [
	stream atEnd
		ifTrue: [^ nil]
		ifFalse: [^ stream next]
]

{ #category : #private }
XMLReadStreamAdapter >> newWriteStream [
	^ (self writeStreamCollectionClass new: 128) writeStream
]

{ #category : #accessing }
XMLReadStreamAdapter >> next [
	stream atEnd
		ifTrue: [^ nil]
		ifFalse: [^ stream next]
]

{ #category : #accessing }
XMLReadStreamAdapter >> next: anInteger [
	| writeStream i |

	writeStream := self newWriteStream.
	i := anInteger.
	[self atEnd
		or: [i <= 0]]
		whileFalse: [
			writeStream nextPut: self next.
			i := i - 1].
	^ writeStream contents.
]

{ #category : #accessing }
XMLReadStreamAdapter >> peek [
	stream atEnd
		ifTrue: [^ nil]
		ifFalse: [^ stream peek]
]

{ #category : #accessing }
XMLReadStreamAdapter >> peekFor: anObject [
	self peek = anObject
		ifTrue: [
			self next.
			^ true]
		ifFalse: [^ false]
]

{ #category : #positioning }
XMLReadStreamAdapter >> skip: anInteger [
	"only supports skipping forwards"
	1 to: anInteger do: [:i |
		self atEnd
			ifTrue: [^ self].
		self next]
]

{ #category : #positioning }
XMLReadStreamAdapter >> skipSeparators [
	"isXMLWhitespace matches the Squeak/Pharo isSeparator range, so
	it is used here instead of isXMLSeparator to give expected behavior
	when reading non-XML files"
	[self atEnd not
		and: [self peek isXMLWhitespace]]
		whileTrue: [self next]
]

{ #category : #positioning }
XMLReadStreamAdapter >> skipTo: anObject [
	[self atEnd]
		whileFalse: [
			self next = anObject
				ifTrue: [^ true]].
	^ false.
]

{ #category : #accessing }
XMLReadStreamAdapter >> upTo: anObject [
	| writeStream next |

	writeStream := self newWriteStream.
	[self atEnd
		or: [(next := self next) = anObject]]
		whileFalse: [writeStream nextPut: next].
	^ writeStream contents.
]

{ #category : #accessing }
XMLReadStreamAdapter >> upToEnd [
	| writeStream |

	writeStream := self newWriteStream.
	[self atEnd]
		whileFalse: [writeStream nextPut: self next].
	^ writeStream contents.
]

{ #category : #private }
XMLReadStreamAdapter >> writeStreamCollectionClass [
	^ String
]
