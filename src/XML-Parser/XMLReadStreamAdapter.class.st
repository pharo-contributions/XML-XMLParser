"
An abstract class for read stream adapters for basic streams that support next, peek, and atEnd.
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

{ #category : #'instance creation' }
XMLReadStreamAdapter class >> onStreamIfBinary: aStream [
	self subclassResponsibility
]

{ #category : #testing }
XMLReadStreamAdapter >> atEnd [
	self subclassResponsibility
]

{ #category : #accessing }
XMLReadStreamAdapter >> basicNext [
	self subclassResponsibility
]

{ #category : #closing }
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

{ #category : #initialization }
XMLReadStreamAdapter >> on: aStream [
	stream := aStream
]

{ #category : #accessing }
XMLReadStreamAdapter >> peek [
	self subclassResponsibility
]

{ #category : #accessing }
XMLReadStreamAdapter >> stream [
	^ stream
]
