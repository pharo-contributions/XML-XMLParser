"
This class adds HTML-specific contexts.
"
Class {
	#name : #HTMLTokenContext,
	#superclass : #XMLTokenContext,
	#category : #'XML-Parser-HTML'
}

{ #category : #'changing context' }
HTMLTokenContext >> enterNonHTMLComment [
	context := #inNonHTMLComment
]

{ #category : #'changing context' }
HTMLTokenContext >> enterNonHTMLSection [
	context := #inNonHTMLSection
]

{ #category : #testing }
HTMLTokenContext >> isInContent [
	^ super isInContent or: [self isInNonHTMLSection]
]

{ #category : #testing }
HTMLTokenContext >> isInNonHTMLComment [
	^ context == #inNonHTMLComment
]

{ #category : #testing }
HTMLTokenContext >> isInNonHTMLSection [
	^ context == #inNonHTMLSection or: [self isInNonHTMLComment]
]
