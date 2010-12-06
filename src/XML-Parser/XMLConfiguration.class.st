"
This class stores the shared settings and components for a parser.
"
Class {
	#name : #XMLConfiguration,
	#superclass : #Object,
	#instVars : [
		'isValidating',
		'usesNamespaces',
		'parserClass'
	],
	#category : #'XML-Parser'
}

{ #category : #accessing }
XMLConfiguration >> isValidating [
	^ isValidating ifNil: [isValidating := true]
]

{ #category : #accessing }
XMLConfiguration >> isValidating: aBoolean [
	isValidating := aBoolean
]

{ #category : #accessing }
XMLConfiguration >> parserClass [
	^ parserClass ifNil: [parserClass := SAXHandler]
]

{ #category : #accessing }
XMLConfiguration >> parserClass: aClass [
	parserClass := aClass
]

{ #category : #accessing }
XMLConfiguration >> usesNamespaces [
	^ usesNamespaces ifNil: [usesNamespaces := true]
]

{ #category : #accessing }
XMLConfiguration >> usesNamespaces: aBoolean [
	usesNamespaces := aBoolean
]
