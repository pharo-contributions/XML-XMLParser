"
An abstract class for read stream adapters for basic read streams that support peek, next, and atEnd.
"
Class {
	#name : #XMLReadStreamAdapter,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #'XML-Parser-Streams'
}

{ #category : #'instance creation' }
XMLReadStreamAdapter class >> on: aStream [
	^ self new on: aStream
]

{ #category : #testing }
XMLReadStreamAdapter >> atEnd [
	self subclassResponsibility
]

{ #category : #accessing }
XMLReadStreamAdapter >> basicNext [
	self subclassResponsibility
]

{ #category : #'file open/close' }
XMLReadStreamAdapter >> close [
	(stream respondsTo: #close)
		ifTrue: [stream close]
]

{ #category : #testing }
XMLReadStreamAdapter >> isBinary [
	^ false
]

{ #category : #testing }
XMLReadStreamAdapter >> isStream [
	^ true
]

{ #category : #accessing }
XMLReadStreamAdapter >> next [
	self subclassResponsibility
]

{ #category : #'instance creation' }
XMLReadStreamAdapter >> on: aStream [
	stream := aStream
]

{ #category : #accessing }
XMLReadStreamAdapter >> peek [
	self subclassResponsibility
]
