"
This class represents a document node, which is often the root of a node tree. It can contain XML version and encoding information, a DOCTYPE declaration with a possible internal subset and a root element child node.
"
Class {
	#name : #XMLDocument,
	#superclass : #XMLNodeWithElements,
	#instVars : [
		'version',
		'encoding',
		'doctypeDeclaration',
		'isStandalone'
	],
	#category : #'XML-Parser-DOM'
}

{ #category : #accessing }
XMLDocument >> doctypeDeclaration [
	^ doctypeDeclaration
]

{ #category : #accessing }
XMLDocument >> doctypeDeclaration: aDoctypeDeclaration [
	doctypeDeclaration := aDoctypeDeclaration
]

{ #category : #accessing }
XMLDocument >> document [
	^ self
]

{ #category : #accessing }
XMLDocument >> encoding [	
	^ encoding ifNil: [encoding := 'UTF-8']
]

{ #category : #accessing }
XMLDocument >> encoding: aString [	
	encoding := aString
]

{ #category : #private }
XMLDocument >> innerXMLContext [
	^ XMLPrologContext new
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
	^ self firstElement
]

{ #category : #accessing }
XMLDocument >> root: anElement [
	self
		removeNodes: self elements;
		addNode: anElement
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
	self version ifNotNil: [
		aWriter xml
			version: self version;
			encoding: self encoding;
			standalone: self isStandalone].
	self doctypeDeclaration
		ifNotNil: [self doctypeDeclaration writeXMLOn: aWriter].
	
	self writeInnerXMLOn: aWriter.
]
