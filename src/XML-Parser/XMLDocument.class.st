"
This class represents a document node, which is often the root of an XMLNode tree.
"
Class {
	#name : #XMLDocument,
	#superclass : #XMLNodeWithElements,
	#instVars : [
		'version',
		'encoding',
		'doctypeDeclaration'
	],
	#category : #'XML-Parser-Nodes'
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
	self
]

{ #category : #accessing }
XMLDocument >> encoding [	
	^ encoding ifNil: [encoding := 'UTF-8']
]

{ #category : #accessing }
XMLDocument >> encoding: aString [	
	encoding := aString
]

{ #category : #testing }
XMLDocument >> isDocument [
	^ true
]

{ #category : #printing }
XMLDocument >> printXMLOn: aWriter [
	self version ifNotNil: [
		aWriter xml
			version: self version;
			encoding: self encoding].
	self doctypeDeclaration
		ifNotNil: [self doctypeDeclaration printXMLOn: aWriter].
	
	super printXMLOn: aWriter
]

{ #category : #accessing }
XMLDocument >> root [
	^ self firstElement 
]

{ #category : #accessing }
XMLDocument >> version [	
	^ version
]

{ #category : #accessing }
XMLDocument >> version: aVersionNumber [
	version := aVersionNumber
]
