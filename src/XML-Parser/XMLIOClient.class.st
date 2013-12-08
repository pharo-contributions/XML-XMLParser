"
A base class for IO clients used to retrieve external entities. The get: methods return readable streams.
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

{ #category : #testing }
XMLIOClient >> isNonRelative: aResource [
	^ aResource notEmpty and: [aResource first == self pathSeparator]
]

{ #category : #paths }
XMLIOClient >> pathSeparator [
	^ $/
]
