"
This class represents a document node, which is often the root of a node tree. It can contain XML version and encoding information, a DOCTYPE declaration with a possible internal subset and a root element child node.
"
Class {
	#name : #XMLDocument,
	#superclass : #XMLNodeWithElements,
	#instVars : [
		'version',
		'encoding',
		'isStandalone',
		'doctypeDeclaration',
		'doctypeDefinition'
	],
	#category : #'XML-Parser-DOM'
}

{ #category : #'instance creation' }
XMLDocument class >> root: aRoot [
	^ self new root: aRoot
]

{ #category : #accessing }
XMLDocument >> doctypeDeclaration [
	^ doctypeDeclaration
]

{ #category : #accessing }
XMLDocument >> doctypeDeclaration: aDoctypeDeclaration [
	doctypeDeclaration := aDoctypeDeclaration
]

{ #category : #accessing }
XMLDocument >> doctypeDefinition [
	^ doctypeDefinition
]

{ #category : #accessing }
XMLDocument >> doctypeDefinition: aDoctypeDefinition [
	doctypeDefinition := aDoctypeDefinition
]

{ #category : #accessing }
XMLDocument >> document [
	^ self
]

{ #category : #accessing }
XMLDocument >> encoding [	
	^ encoding ifNil: [encoding := '']
]

{ #category : #accessing }
XMLDocument >> encoding: aString [	
	encoding := aString
]

{ #category : #private }
XMLDocument >> innerXMLContext [
	^ XMLXMLDeclarationContext new
]

{ #category : #testing }
XMLDocument >> isDocument [
	^ true
]

{ #category : #testing }
XMLDocument >> isStandalone [
	^ isStandalone ifNil: [isStandalone := false]
]

{ #category : #accessing }
XMLDocument >> isStandalone: aBoolean [
	isStandalone := aBoolean
]

{ #category : #copying }
XMLDocument >> postCopy [
	super postCopy.

	doctypeDeclaration
		ifNotNil: [doctypeDeclaration := doctypeDeclaration copy].
]

{ #category : #accessing }
XMLDocument >> root [
	"returns root element or nil"
	^ self firstElement
]

{ #category : #accessing }
XMLDocument >> root: anElement [
	"replaces root element with new element"
	self hasChildren
		ifTrue: [self removeNodes: self elements].
	self addNode: anElement.
]

{ #category : #validating }
XMLDocument >> validate [
	"revalidate against the DTD it was parsed with (if any)"

	| dtd |

	((dtd := self doctypeDefinition) notNil
		and: [dtd hasValidators])
		ifTrue: [
			dtd clearIDsAndIDReferences.
			self validateWith: (DTDDocumentValidator doctypeDefinition: dtd)]
]

{ #category : #validating }
XMLDocument >> validateWith: aValidator [
	self root
		ifNotNil: [:rootElement | aValidator validateRootElement: rootElement name].
	super validateWith: aValidator.
	aValidator validateEndDocument.
]

{ #category : #accessing }
XMLDocument >> version [	
	^ version
]

{ #category : #accessing }
XMLDocument >> version: aVersionNumber [
	version := aVersionNumber
]

{ #category : #printing }
XMLDocument >> writeXMLOn: aWriter [
	self version
		ifNotNil: [
			aWriter xml
				version: self version;
				encoding: self encoding;
				standalone: self isStandalone].
	self doctypeDeclaration
		ifNotNil: [self doctypeDeclaration writeXMLOn: aWriter].
	
	self writeInnerXMLOn: aWriter.
]
