"
An abstract class to wrap pushed-back entities to keep track of the nesting of markup within entity replacements.
"
Class {
	#name : #XMLPushedBackEntity,
	#superclass : #Object,
	#instVars : [
		'entity'
	],
	#category : #'XML-Parser-Drivers'
}

{ #category : #'instance creation' }
XMLPushedBackEntity class >> entity: anEntity [
	^ self new entity: anEntity
]

{ #category : #converting }
XMLPushedBackEntity >> asPushedBackEntity [
	^ self
]

{ #category : #converting }
XMLPushedBackEntity >> asReference [
	^ entity asReference
]

{ #category : #accessing }
XMLPushedBackEntity >> entity [
	^ entity
]

{ #category : #accessing }
XMLPushedBackEntity >> entity: anEntity [
	entity := anEntity
]

{ #category : #testing }
XMLPushedBackEntity >> hasReplacement [
	^ entity hasReplacement
]

{ #category : #testing }
XMLPushedBackEntity >> isExternal [
	^ entity isExternal
]

{ #category : #testing }
XMLPushedBackEntity >> isInternalTo: aURI [
	^ entity isInternalTo: aURI
]

{ #category : #testing }
XMLPushedBackEntity >> isParameter [
	^ false
]

{ #category : #testing }
XMLPushedBackEntity >> isUnparsed [
	^ entity isUnparsed
]

{ #category : #accessing }
XMLPushedBackEntity >> name [
	^ entity name
]

{ #category : #nesting }
XMLPushedBackEntity >> poppedByTokenizer: aTokenizer [
	self subclassResponsibility
]

{ #category : #printing }
XMLPushedBackEntity >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(.
	entity printOn: aStream.
	aStream nextPut: $).
]

{ #category : #accessing }
XMLPushedBackEntity >> replacement [
	^ entity replacement
]

{ #category : #accessing }
XMLPushedBackEntity >> replacementStream [
	^ entity replacementStream
]

{ #category : #accessing }
XMLPushedBackEntity >> uri [
	^ entity uri
]
