"
This class stores additional settings and components relevant to the DOM parser and DOM nodes.
"
Class {
	#name : #XMLDOMConfiguration,
	#superclass : #XMLConfiguration,
	#instVars : [
		'nodeFactory',
		'preservesCDataNodes',
		'preservesCommentNodes',
		'preservesIgnorableWhitespace'
	],
	#category : #'XML-Parser'
}

{ #category : #accessing }
XMLDOMConfiguration >> defaultParserHandlerClass [
	^ XMLDOMParser
]

{ #category : #initialization }
XMLDOMConfiguration >> initialize [
	super initialize.

	"always used, so explicitly initialized"
	nodeFactory := XMLNodeFactory new.
	preservesCDataNodes := false.
	preservesCommentNodes := false.
	preservesIgnorableWhitespace := false.
]

{ #category : #accessing }
XMLDOMConfiguration >> nodeFactory [
	^ nodeFactory
]

{ #category : #accessing }
XMLDOMConfiguration >> nodeFactory: aFactory [
	nodeFactory := aFactory
]

{ #category : #accessing }
XMLDOMConfiguration >> nodeListClass [
	^ self nodeFactory nodeListClass
]

{ #category : #accessing }
XMLDOMConfiguration >> nodeListClass: aClass [
	self nodeFactory:
		(self nodeFactory asPluggableNodeFactory nodeListClass: aClass)
]

{ #category : #accessing }
XMLDOMConfiguration >> preservesCDataNodes [
	^ preservesCDataNodes
]

{ #category : #accessing }
XMLDOMConfiguration >> preservesCDataNodes: aBoolean [
	preservesCDataNodes := aBoolean
]

{ #category : #accessing }
XMLDOMConfiguration >> preservesCommentNodes [
	^ preservesCommentNodes
]

{ #category : #accessing }
XMLDOMConfiguration >> preservesCommentNodes: aBoolean [
	preservesCommentNodes := aBoolean
]

{ #category : #accessing }
XMLDOMConfiguration >> preservesIgnorableWhitespace [
	^ preservesIgnorableWhitespace
]

{ #category : #accessing }
XMLDOMConfiguration >> preservesIgnorableWhitespace: aBoolean [
	preservesIgnorableWhitespace := aBoolean
]
