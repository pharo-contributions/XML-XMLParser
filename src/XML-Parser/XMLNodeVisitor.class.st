"
This is a base class for DOM node tree visitors. Subclasses can implement any of the ""visiting"" messages, and instances can be used by sending a node #acceptNodeVisitor: with it as the argument.
"
Class {
	#name : #XMLNodeVisitor,
	#superclass : #Object,
	#category : #'XML-Parser-DOM'
}

{ #category : #visiting }
XMLNodeVisitor >> visitCData: aCData [
	self visitStringNode: aCData
]

{ #category : #visiting }
XMLNodeVisitor >> visitComment: aComment [
]

{ #category : #visiting }
XMLNodeVisitor >> visitDocument: aDocument [
	self visitNodeWithElements: aDocument
]

{ #category : #visiting }
XMLNodeVisitor >> visitElement: anElement [
	self visitNodeWithElements: anElement
]

{ #category : #visiting }
XMLNodeVisitor >> visitNode: aNode [
	aNode acceptNodeVisitor: self
]

{ #category : #visiting }
XMLNodeVisitor >> visitNodeWithElements: aNode [
	aNode hasChildren
		ifTrue: [aNode nodesDo: [:each | each acceptNodeVisitor: self]]
]

{ #category : #visiting }
XMLNodeVisitor >> visitPI: aPI [
]

{ #category : #visiting }
XMLNodeVisitor >> visitStringNode: aStringNode [
]
