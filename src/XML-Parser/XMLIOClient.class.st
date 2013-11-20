"
A base class for IO clients used to retrieve external entities.
"
Class {
	#name : #XMLIOClient,
	#superclass : #Object,
	#category : #'XML-Parser-Clients'
}

{ #category : #accessing }
XMLIOClient class >> defaultImplementation [
	self subclassResponsibility
]

{ #category : #retrieving }
XMLIOClient class >> get: aResource [
	^ self new get: aResource
]

{ #category : #paths }
XMLIOClient >> combineRelative: aRelativeResource withBase: aBaseResource [
	self subclassResponsibility
]

{ #category : #retrieving }
XMLIOClient >> get: aResource [
	self subclassResponsibility
]

{ #category : #retrieving }
XMLIOClient >> get: aRelativeResource relativeTo: aBaseResource [
	^ self get:
		(self
			combineRelative: aRelativeResource
			withBase: aBaseResource)
]

{ #category : #testing }
XMLIOClient >> isNonRelative: aResource [
	^ aResource notEmpty and: [aResource first == self pathSeparator]
]

{ #category : #paths }
XMLIOClient >> pathSeparator [
	^ $/
]

{ #category : #paths }
XMLIOClient >> trimRelativePath: aPath [
	^ (aPath beginsWith: (String with: $. with: self pathSeparator))
		ifTrue: [aPath allButFirst: 2]
		ifFalse: [aPath]
]
