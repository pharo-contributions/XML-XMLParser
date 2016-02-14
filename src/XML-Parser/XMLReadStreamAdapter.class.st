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
	self subclassResponsibility
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
	| writeStream |

	writeStream := self newWriteStream.
	1 to: anInteger do: [:i |
		self atEnd
			ifTrue: [^ writeStream contents].
		writeStream nextPut: self next].
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
	"xmlParserIsWhitespace matches the Squeak/Pharo isSeparator range, so
	it is used here instead of xmlParserIsSeparator to give expected behavior
	when reading non-XML files"
	[self atEnd not
		and: [self peek xmlParserIsWhitespace]]
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
	| writeStream |

	writeStream := self newWriteStream.
	[self atEnd
		or: [self peek = anObject]]
		whileFalse: [writeStream nextPut: self next].
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
