"
A stream for writing node content with whitespace insertion if needed between writes.
"
Class {
	#name : #XMLNodeContentWriteStream,
	#superclass : #Object,
	#instVars : [
		'stream',
		'lastChar'
	],
	#category : #'XML-Parser-Streams'
}

{ #category : #'instance creation' }
XMLNodeContentWriteStream class >> on: aStringOrStream [
	^ self new on:
		(aStringOrStream isStream
			ifTrue: [aStringOrStream]
			ifFalse: [WriteStream on: aStringOrStream])
]

{ #category : #private }
XMLNodeContentWriteStream >> addSpaceFor: aCharacter [
	(lastChar == nil
		or: [lastChar isSeparator
			or: [aCharacter isSeparator]])
		ifFalse: [stream space]
]

{ #category : #accessing }
XMLNodeContentWriteStream >> contents [
	^ stream contents
]

{ #category : #testing }
XMLNodeContentWriteStream >> isStream [
	^ true
]

{ #category : #accessing }
XMLNodeContentWriteStream >> nextPut: aCharacter [
	self addSpaceFor: aCharacter.
	stream nextPut: aCharacter.
	lastChar := aCharacter.
]

{ #category : #accessing }
XMLNodeContentWriteStream >> nextPutAll: aString [
	aString size > 0
		ifTrue: [
			self addSpaceFor: aString first.
			stream nextPutAll: aString.
			lastChar := aString last]
]

{ #category : #initialization }
XMLNodeContentWriteStream >> on: aStream [
	stream := aStream
]
