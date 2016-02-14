"
An abstract class for read and write stream adapters.
"
Class {
	#name : #XMLStreamAdapter,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #'XML-Parser-Streams'
}

{ #category : #'instance creation' }
XMLStreamAdapter class >> on: aStream [
	^ self new on: aStream
]

{ #category : #closing }
XMLStreamAdapter >> close [
	(stream respondsTo: #close)
		ifTrue: [stream close]
]

{ #category : #testing }
XMLStreamAdapter >> isBinary [
	^ false
]

{ #category : #testing }
XMLStreamAdapter >> isStream [
	^ true
]

{ #category : #initialization }
XMLStreamAdapter >> on: aStream [
	stream := aStream
]

{ #category : #accessing }
XMLStreamAdapter >> stream [
	^ stream
]
