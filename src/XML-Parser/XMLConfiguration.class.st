"
This class stores the shared settings and components for a parser. The configuration values are stored in separate inst vars instead of using a dictionary for speed.
"
Class {
	#name : #XMLConfiguration,
	#superclass : #Object,
	#instVars : [
		'isValidating',
		'usesNamespaces',
		'requiresDocumentConstraints',
		'parserHandlerClass',
		'parserLimits',
		'entityConfiguration'
	],
	#category : #'XML-Parser'
}

{ #category : #accessing }
XMLConfiguration >> entityConfiguration [
	^ entityConfiguration ifNil: [entityConfiguration := DTDEntityConfiguration new]
]

{ #category : #accessing }
XMLConfiguration >> externalEntityResolver [
	^ self entityConfiguration externalEntityResolver
]

{ #category : #accessing }
XMLConfiguration >> externalEntityResolver: anExternalEntityResolver [
	self entityConfiguration externalEntityResolver: anExternalEntityResolver
]

{ #category : #initialization }
XMLConfiguration >> initialize [
	super initialize.

	"always used, so explicitly initialized"
	isValidating := true.
	usesNamespaces := true.
	requiresDocumentConstraints := false.
	parserLimits := XMLParserLimits new.
]

{ #category : #accessing }
XMLConfiguration >> isValidating [
	^ isValidating
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
	^ parserLimits
]

{ #category : #accessing }
XMLConfiguration >> preservesUndeclaredEntityReferences [
	^ self entityConfiguration preservesUndeclaredEntityReferences
]

{ #category : #accessing }
XMLConfiguration >> preservesUndeclaredEntityReferences: aBoolean [
	self entityConfiguration preservesUndeclaredEntityReferences: aBoolean.
	aBoolean
		ifTrue: [self isValidating: false].
]

{ #category : #accessing }
XMLConfiguration >> replacesContentEntityReferences [
	^ self entityConfiguration replacesContentEntityReferences
]

{ #category : #accessing }
XMLConfiguration >> replacesContentEntityReferences: aBoolean [
	self entityConfiguration replacesContentEntityReferences: aBoolean
]

{ #category : #accessing }
XMLConfiguration >> requiresDocumentConstraints [
	^ requiresDocumentConstraints
]

{ #category : #accessing }
XMLConfiguration >> requiresDocumentConstraints: aBoolean [
	(requiresDocumentConstraints := aBoolean)
		ifTrue: [self isValidating: true]
]

{ #category : #accessing }
XMLConfiguration >> resolvesExternalEntities [
	^ self entityConfiguration resolvesExternalEntities
]

{ #category : #accessing }
XMLConfiguration >> resolvesExternalEntities: aBoolean [
	self entityConfiguration resolvesExternalEntities: aBoolean
]

{ #category : #accessing }
XMLConfiguration >> usesNamespaces [
	^ usesNamespaces
]

{ #category : #accessing }
XMLConfiguration >> usesNamespaces: aBoolean [
	usesNamespaces := aBoolean
]
