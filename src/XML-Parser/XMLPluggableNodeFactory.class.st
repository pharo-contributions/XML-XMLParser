"
This is a pluggable factory that can be used to change which classes the DOM parser uses to build the DOM tree. Here is an example:

	(XMLDOMParser on: someXML)
		nodeFactory:
			(XMLPluggableFactory new
				documentClass: MyDocumentClass;
				elementClass: MyElementClass;
				stringClass: MyStringClass)
		parseDocument.
"
Class {
	#name : #XMLPluggableNodeFactory,
	#superclass : #XMLNodeFactory,
	#instVars : [
		'documentClass',
		'elementClass',
		'stringClass',
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
	^ cdataClass ifNil: [cdataClass := super cdataClass]
]

{ #category : #accessing }
XMLPluggableNodeFactory >> cdataClass: aClass [
	cdataClass := aClass
]

{ #category : #accessing }
XMLPluggableNodeFactory >> commentClass [
	^ commentClass ifNil: [commentClass := super commentClass]
]

{ #category : #accessing }
XMLPluggableNodeFactory >> commentClass: aClass [
	commentClass := aClass
]

{ #category : #accessing }
XMLPluggableNodeFactory >> documentClass [
	^ documentClass ifNil: [documentClass := super documentClass]
]

{ #category : #accessing }
XMLPluggableNodeFactory >> documentClass: aClass [
	documentClass := aClass
]

{ #category : #accessing }
XMLPluggableNodeFactory >> elementClass [
	^ elementClass ifNil: [elementClass := super elementClass]
]

{ #category : #accessing }
XMLPluggableNodeFactory >> elementClass: aClass [
	elementClass := aClass
]

{ #category : #accessing }
XMLPluggableNodeFactory >> nodeListClass [
	^ nodeListClass ifNil: [nodeListClass := super nodeListClass]
]

{ #category : #accessing }
XMLPluggableNodeFactory >> nodeListClass: aClass [
	nodeListClass := aClass
]

{ #category : #accessing }
XMLPluggableNodeFactory >> piClass [
	^ piClass ifNil: [piClass := super piClass]
]

{ #category : #accessing }
XMLPluggableNodeFactory >> piClass: aClass [
	piClass := aClass
]

{ #category : #accessing }
XMLPluggableNodeFactory >> stringClass [
	^ stringClass ifNil: [stringClass := super stringClass]
]

{ #category : #accessing }
XMLPluggableNodeFactory >> stringClass: aClass [
	stringClass := aClass
]
