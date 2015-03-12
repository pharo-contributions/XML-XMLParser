"
This class stores additional settings and components relevant to the DOM parser and DOM nodes.
"
Class {
	#name : #XMLDOMConfiguration,
	#superclass : #XMLConfiguration,
	#instVars : [
		'preservesCDataNodes',
		'preservesCommentNodes',
		'preservesIgnorableWhitespace',
		'nodeFactory',
		'nodeListClass'
	],
	#category : #'XML-Parser'
}

{ #category : #initialization }
XMLDOMConfiguration >> initialize [
	super initialize.

	"always used, so explicitly initialized"
	preservesCDataNodes := false.
	preservesCommentNodes := false.
	preservesIgnorableWhitespace := false.
	nodeFactory := XMLNodeFactory new.
	nodeListClass := XMLNodeList.
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
	^ nodeListClass
]

{ #category : #accessing }
XMLDOMConfiguration >> nodeListClass: aClass [
	nodeListClass := aClass
]

{ #category : #accessing }
XMLDOMConfiguration >> parserHandlerClass [
	^ parserHandlerClass ifNil: [parserHandlerClass := XMLDOMParser]
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
