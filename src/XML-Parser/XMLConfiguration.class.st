"
This class stores the shared settings and components for a parser.
"
Class {
	#name : #XMLConfiguration,
	#superclass : #Object,
	#instVars : [
		'isValidating',
		'usesNamespaces',
		'resolvesExternalEntities',
		'preservesUndeclaredEntityReferences',
		'externalEntityResolver',
		'parserHandlerClass'
	],
	#category : #'XML-Parser'
}

{ #category : #accessing }
XMLConfiguration >> externalEntityResolver [
	^ externalEntityResolver ifNil: [externalEntityResolver := DTDExternalEntityResolver new]
]

{ #category : #accessing }
XMLConfiguration >> externalEntityResolver: anExternalEntityResolver [
	externalEntityResolver := anExternalEntityResolver
]

{ #category : #accessing }
XMLConfiguration >> fileClient [
	^ self externalEntityResolver fileClient
]

{ #category : #accessing }
XMLConfiguration >> fileClient: aClient [
	self externalEntityResolver fileClient: aClient
]

{ #category : #accessing }
XMLConfiguration >> httpClient [
	^ self externalEntityResolver httpClient
]

{ #category : #accessing }
XMLConfiguration >> httpClient: aClient [
	self externalEntityResolver httpClient: aClient
]

{ #category : #accessing }
XMLConfiguration >> isValidating [
	^ isValidating ifNil: [isValidating := true]
]

{ #category : #accessing }
XMLConfiguration >> isValidating: aBoolean [
	isValidating := aBoolean
]

{ #category : #accessing }
XMLConfiguration >> parserHandlerClass [
	^ parserHandlerClass ifNil: [parserHandlerClass := SAXHandler]
]

{ #category : #accessing }
XMLConfiguration >> parserHandlerClass: aClass [
	parserHandlerClass := aClass
]

{ #category : #accessing }
XMLConfiguration >> preservesUndeclaredEntityReferences [
	^ preservesUndeclaredEntityReferences ifNil: [preservesUndeclaredEntityReferences := false]
]

{ #category : #accessing }
XMLConfiguration >> preservesUndeclaredEntityReferences: aBoolean [
	preservesUndeclaredEntityReferences := aBoolean
]

{ #category : #accessing }
XMLConfiguration >> resolvesExternalEntities [
	^ resolvesExternalEntities ifNil: [resolvesExternalEntities := true]
]

{ #category : #accessing }
XMLConfiguration >> resolvesExternalEntities: aBoolean [
	resolvesExternalEntities := aBoolean
]

{ #category : #accessing }
XMLConfiguration >> usesNamespaces [
	^ usesNamespaces ifNil: [usesNamespaces := true]
]

{ #category : #accessing }
XMLConfiguration >> usesNamespaces: aBoolean [
	usesNamespaces := aBoolean
]
