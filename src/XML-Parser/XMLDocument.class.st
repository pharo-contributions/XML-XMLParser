Class {
	#name : #XMLDocument,
	#superclass : #XMLNodeWithElements,
	#instVars : [
		'dtd',
		'version',
		'encoding',
		'requiredMarkup'
	],
	#category : #'XML-Parser'
}

{ #category : #accessing }
XMLDocument >> dtd [
	^dtd
]

{ #category : #accessing }
XMLDocument >> dtd: aDTD [
	dtd := aDTD
]

{ #category : #accessing }
XMLDocument >> encoding [	
	^encoding ifNil: ['UTF-8']
]

{ #category : #accessing }
XMLDocument >> encoding: aString [	
	encoding := aString
]

{ #category : #printing }
XMLDocument >> printCanonicalOn: aStream [

	| writer |
	writer := XMLWriter on: aStream.
	writer canonical: true.
	self printXMLOn: writer
]

{ #category : #printing }
XMLDocument >> printXMLOn: writer [
	version ifNotNil: [writer xmlDeclaration: self version encoding: self encoding].
	super printXMLOn: writer
]

{ #category : #accessing }
XMLDocument >> requiredMarkup [	
	^requiredMarkup
]

{ #category : #accessing }
XMLDocument >> requiredMarkup: aString [	
	requiredMarkup := aString
]

{ #category : #accessing }
XMLDocument >> root [
	"return my root element"
	^ self topElement 
]

{ #category : #accessing }
XMLDocument >> version [	
	^version
]

{ #category : #accessing }
XMLDocument >> version: aString [	
	version := aString
]
