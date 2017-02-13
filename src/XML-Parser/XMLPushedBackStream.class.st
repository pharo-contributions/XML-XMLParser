"
A class to wrap a nested stream and callback for XMLNestedStreamReader and record the line number, position, and line start position of the current external stream.
"
Class {
	#name : #XMLPushedBackStream,
	#superclass : #Object,
	#instVars : [
		'stream',
		'whenPoppedDo',
		'currentPosition',
		'currentLineNumber',
		'currentLineStartPosition'
	],
	#category : #'XML-Parser-Streams'
}

{ #category : #'instance creation' }
XMLPushedBackStream class >> stream: aStream whenPoppedDo: aBlock currentPosition: aPosition currentLineNumber: aLineNumber currentLineStartPosition: aStartPosition [
	^ self new
		setStream: aStream
		whenPoppedDo: aBlock
		currentPosition: aPosition
		currentLineNumber: aLineNumber
		currentLineStartPosition: aStartPosition
]

{ #category : #accessing }
XMLPushedBackStream >> currentLineNumber [
	^ currentLineNumber
]

{ #category : #accessing }
XMLPushedBackStream >> currentLineStartPosition [
	^ currentLineStartPosition
]

{ #category : #accessing }
XMLPushedBackStream >> currentPosition [
	^ currentPosition
]

{ #category : #testing }
XMLPushedBackStream >> isExternal [
	^ false
]

{ #category : #initialization }
XMLPushedBackStream >> setStream: aStream whenPoppedDo: aBlock currentPosition: aPosition currentLineNumber: aLineNumber currentLineStartPosition: aStartPosition [
	stream := aStream.
	whenPoppedDo := aBlock.
	currentPosition := aPosition.
	currentLineNumber := aLineNumber.
	currentLineStartPosition := aStartPosition.
]

{ #category : #accessing }
XMLPushedBackStream >> stream [
	^ stream
]

{ #category : #accessing }
XMLPushedBackStream >> whenPoppedDo [
	^ whenPoppedDo
]
