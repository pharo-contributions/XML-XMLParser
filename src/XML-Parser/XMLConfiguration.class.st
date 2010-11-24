"
This class stores the shared settings and components of a parser.
"
Class {
	#name : #XMLConfiguration,
	#superclass : #Object,
	#instVars : [
		'isValidating',
		'usesNamespaces'
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
XMLConfiguration >> usesNamespaces [
	^ usesNamespaces ifNil: [usesNamespaces := true]
]

{ #category : #accessing }
XMLConfiguration >> usesNamespaces: aBoolean [
	usesNamespaces := aBoolean
]
