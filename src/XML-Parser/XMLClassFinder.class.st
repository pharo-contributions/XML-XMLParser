"
A simple cross-platform interface for finding classes that may not be in the image.
"
Class {
	#name : #XMLClassFinder,
	#superclass : #Object,
	#category : #'XML-Parser-Utils'
}

{ #category : #accessing }
XMLClassFinder class >> classNamed: aClassName [
	^ self
		classNamed: aClassName
		ifAbsent: [nil]
]

{ #category : #accessing }
XMLClassFinder class >> classNamed: aClassName ifAbsent: aBlock [
	^ Smalltalk globals
		at: aClassName asSymbol
		ifAbsent: aBlock
]

{ #category : #testing }
XMLClassFinder class >> hasClassNamed: aClassName [
	self
		classNamed: aClassName
		ifAbsent: [^ false].
	^ true.
]
