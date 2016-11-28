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
	"must use respondsTo: to support streams only implementing the basic protocol"
	(stream respondsTo: #close)
		ifTrue: [stream close]
]

{ #category : #accessing }
XMLStreamAdapter >> contents [
	self subclassResponsibility
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

{ #category : #positioning }
XMLStreamAdapter >> position [
	self subclassResponsibility
]

{ #category : #positioning }
XMLStreamAdapter >> position: anInteger [
	self subclassResponsibility
]

{ #category : #positioning }
XMLStreamAdapter >> reset [
	self subclassResponsibility
]

{ #category : #accessing }
XMLStreamAdapter >> stream [
	^ stream
]
