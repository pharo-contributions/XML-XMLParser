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
		'parserHandlerClass',
		'parserLimits',
		'requiresDocumentConstraints'
	],
	#category : #'XML-Parser'
}

{ #category : #accessing }
XMLConfiguration >> externalEntityResolver [
	^ externalEntityResolver ifNil: [externalEntityResolver := DTDCachingEntityResolver new]
]

{ #category : #accessing }
XMLConfiguration >> externalEntityResolver: anExternalEntityResolver [
	externalEntityResolver := anExternalEntityResolver
]

{ #category : #accessing }
XMLConfiguration >> isValidating [
	^ isValidating ifNil: [isValidating := true]
]

{ #category : #accessing }
XMLConfiguration >> isValidating: aBoolean [
	(isValidating := aBoolean)
		ifTrue: [self preservesUndeclaredEntityReferences: false]
		ifFalse: [self requiresDocumentConstraints: false]
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
XMLConfiguration >> parserLimits [
	^ parserLimits ifNil: [parserLimits := XMLParserLimits new]
]

{ #category : #accessing }
XMLConfiguration >> preservesUndeclaredEntityReferences [
	^ preservesUndeclaredEntityReferences ifNil: [preservesUndeclaredEntityReferences := false]
]

{ #category : #accessing }
XMLConfiguration >> preservesUndeclaredEntityReferences: aBoolean [
	(preservesUndeclaredEntityReferences := aBoolean)
		ifTrue: [self isValidating: false]
]

{ #category : #accessing }
XMLConfiguration >> requiresDocumentConstraints [
	^ requiresDocumentConstraints ifNil: [requiresDocumentConstraints := false]
]

{ #category : #accessing }
XMLConfiguration >> requiresDocumentConstraints: aBoolean [
	(requiresDocumentConstraints := aBoolean)
		ifTrue: [self isValidating: true]
]

{ #category : #accessing }
XMLConfiguration >> resolvesExternalEntities [
	^ resolvesExternalEntities ifNil: [resolvesExternalEntities := false]
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
