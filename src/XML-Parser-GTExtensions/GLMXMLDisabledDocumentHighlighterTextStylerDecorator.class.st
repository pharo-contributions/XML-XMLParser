Class {
	#name : #GLMXMLDisabledDocumentHighlighterTextStylerDecorator,
	#superclass : #GLMXMLDocumentHighlighterTextStylerDecorator,
	#instVars : [
		'disabledText'
	],
	#category : #'XML-Parser-GTExtensions-Highlighting-Parser'
}

{ #category : #'instance creation' }
GLMXMLDisabledDocumentHighlighterTextStylerDecorator class >> disabledText: aStringOrText [
	^ self new disabledText: aStringOrText
]

{ #category : #accessing }
GLMXMLDisabledDocumentHighlighterTextStylerDecorator >> disabledText [
	^ disabledText ifNil: [disabledText := '' asText]
]

{ #category : #accessing }
GLMXMLDisabledDocumentHighlighterTextStylerDecorator >> disabledText: aStringOrText [
	disabledText := aStringOrText asText
]

{ #category : #parsing }
GLMXMLDisabledDocumentHighlighterTextStylerDecorator >> parse: aString onError: anError [
	^ self disabledText
]
