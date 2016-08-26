"
This is a pluggable factory that can be used to change which classes the DOM parser uses to build the DOM tree. Here is an example:

	(XMLDOMParser on: someXML)
		nodeFactory:
			(XMLPluggableFactory new
				documentClass: MyDocumentClass;
				elementClass: MyElementClass;
				stringNodeClass: MyStringNodeClass)
		parseDocument.

Instances can be saved and resused for performance and safely modified after copying.
"
Class {
	#name : #XMLPluggableNodeFactory,
	#superclass : #XMLNodeFactory,
	#instVars : [
		'documentClass',
		'elementClass',
		'stringNodeClass',
		'cdataClass',
		'commentClass',
		'piClass',
		'nodeListClass'
	],
	#category : #'XML-Parser-DOM'
}

{ #category : #converting }
XMLPluggableNodeFactory >> asPluggableNodeFactory [
	^ self
]

{ #category : #accessing }
XMLPluggableNodeFactory >> cdataClass [
	^ cdataClass
]

{ #category : #accessing }
XMLPluggableNodeFactory >> cdataClass: aClass [
	cdataClass := aClass
]

{ #category : #accessing }
XMLPluggableNodeFactory >> commentClass [
	^ commentClass
]

{ #category : #accessing }
XMLPluggableNodeFactory >> commentClass: aClass [
	commentClass := aClass
]

{ #category : #accessing }
XMLPluggableNodeFactory >> documentClass [
	^ documentClass
]

{ #category : #accessing }
XMLPluggableNodeFactory >> documentClass: aClass [
	documentClass := aClass
]

{ #category : #accessing }
XMLPluggableNodeFactory >> elementClass [
	^ elementClass
]

{ #category : #accessing }
XMLPluggableNodeFactory >> elementClass: aClass [
	elementClass := aClass
]

{ #category : #initialization }
XMLPluggableNodeFactory >> initialize [
	super initialize.

	documentClass := XMLDocument.
	elementClass := XMLElement.
	stringNodeClass := XMLString.
	cdataClass := XMLCData.
	commentClass := XMLComment.
	piClass := XMLPI.
	nodeListClass := XMLNodeList.
]

{ #category : #accessing }
XMLPluggableNodeFactory >> nodeListClass [
	^ nodeListClass
]

{ #category : #accessing }
XMLPluggableNodeFactory >> nodeListClass: aClass [
	nodeListClass := aClass
]

{ #category : #accessing }
XMLPluggableNodeFactory >> piClass [
	^ piClass
]

{ #category : #accessing }
XMLPluggableNodeFactory >> piClass: aClass [
	piClass := aClass
]

{ #category : #deprecated }
XMLPluggableNodeFactory >> stringClass [
	"will be deprecated; use #stringNodeClass instead"

	^ stringNodeClass
]

{ #category : #deprecated }
XMLPluggableNodeFactory >> stringClass: aClass [
	"will be deprecated; use #stringNodeClass: instead"

	stringNodeClass := aClass
]

{ #category : #accessing }
XMLPluggableNodeFactory >> stringNodeClass [
	^ stringNodeClass
]

{ #category : #accessing }
XMLPluggableNodeFactory >> stringNodeClass: aClass [
	stringNodeClass := aClass
]
