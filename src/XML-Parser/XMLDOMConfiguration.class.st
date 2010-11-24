"
This class stores additional settings and components relevant to the DOM parser and DOM nodes.
"
Class {
	#name : #XMLDOMConfiguration,
	#superclass : #XMLConfiguration,
	#instVars : [
		'preservesCDataNodes',
		'preservesCommentNodes',
		'nodeFactory'
	],
	#category : #'XML-Parser'
}

{ #category : #accessing }
XMLDOMConfiguration >> nodeFactory [
	^ nodeFactory ifNil: [nodeFactory := XMLNodeFactory new]
]

{ #category : #accessing }
XMLDOMConfiguration >> nodeFactory: aFactory [
	nodeFactory := aFactory
]

{ #category : #accessing }
XMLDOMConfiguration >> preservesCDataNodes [
	^ preservesCDataNodes ifNil: [preservesCDataNodes := false]
]

{ #category : #accessing }
XMLDOMConfiguration >> preservesCDataNodes: aBoolean [
	preservesCDataNodes := aBoolean
]

{ #category : #accessing }
XMLDOMConfiguration >> preservesCommentNodes [
	^ preservesCommentNodes ifNil: [preservesCommentNodes := false]
]

{ #category : #accessing }
XMLDOMConfiguration >> preservesCommentNodes: aBoolean [
	preservesCommentNodes := aBoolean
]
