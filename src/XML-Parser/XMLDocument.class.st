"
This class represents a document node, which is often the root of a DOM tree. Nodes can access their document ancestor with #document.
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
	aDoctypeDeclaration
		ifNotNil: [
			aDoctypeDeclaration hasParent
				ifTrue: [self errorAddingDoctypeDeclarationWithParent].
			aDoctypeDeclaration parent: self].
	doctypeDeclaration
		ifNotNil: [doctypeDeclaration parent: nil].

	doctypeDeclaration := aDoctypeDeclaration.
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
XMLDocument >> errorAddingDoctypeDeclarationWithParent [
	XMLDOMException signal: 'Cannot add doctype declaration node with parent'
]

{ #category : #testing }
XMLDocument >> hasDoctypeDeclaration [
	^ self doctypeDeclaration notNil
]

{ #category : #testing }
XMLDocument >> hasDoctypeDefinition [
	^ self doctypeDefinition notNil
]

{ #category : #private }
XMLDocument >> innerXMLContext [
	^ XMLPostDoctypeDeclarationContext new
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
	self doctypeDefinition
		ifNotNil: [:dtd |
			dtd hasValidators
				ifTrue: [dtd clearIDsAndIDReferences].
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
XMLDocument >> version: aVersionFloat [
	version := aVersionFloat
]

{ #category : #printing }
XMLDocument >> writeDoctypeDeclarationOn: aWriter [
	self hasDoctypeDeclaration
		ifTrue: [self doctypeDeclaration writeXMLOn: aWriter]
]

{ #category : #printing }
XMLDocument >> writeXMLDeclarationOn: aWriter [
	self version
		ifNotNil: [
			aWriter xml
				version: self version;
				encoding: self encoding;
				standalone: self isStandalone;
				write]
]

{ #category : #printing }
XMLDocument >> writeXMLOn: aWriter [
	self
		writeXMLDeclarationOn: aWriter;
		writeDoctypeDeclarationOn: aWriter;
		writeInnerXMLOn: aWriter
]
