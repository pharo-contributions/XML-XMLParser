"
A stream for writing node content with whitespace insertion if needed between writes.
"
Class {
	#name : #XMLNodeContentWriteStreamAdapter,
	#superclass : #Object,
	#instVars : [
		'stream',
		'lastChar'
	],
	#category : #'XML-Parser-Streams'
}

{ #category : #'instance creation' }
XMLNodeContentWriteStreamAdapter class >> on: aStream [
	^ self new on: aStream
]

{ #category : #accessing }
XMLNodeContentWriteStreamAdapter >> contents [
	^ stream contents
]

{ #category : #private }
XMLNodeContentWriteStreamAdapter >> insertSpaceBefore: aCharacter [
	(lastChar == nil
		or: [lastChar isSeparator
			or: [aCharacter isSeparator]])
		ifFalse: [stream space]
]

{ #category : #accessing }
XMLNodeContentWriteStreamAdapter >> nextPut: aCharacter [
	self insertSpaceBefore: aCharacter.
	stream nextPut: aCharacter.
	^ lastChar := aCharacter.
]

{ #category : #accessing }
XMLNodeContentWriteStreamAdapter >> nextPutAll: aString [
	aString size > 0
		ifTrue: [
			self insertSpaceBefore: aString first.
			stream nextPutAll: aString.
			lastChar := aString last].
	^ aString.
]

{ #category : #initialization }
XMLNodeContentWriteStreamAdapter >> on: aStream [
	stream := aStream
]
