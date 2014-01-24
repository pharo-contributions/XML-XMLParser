"
This class adds HTML-specific contexts.
"
Class {
	#name : #HTMLTokenContext,
	#superclass : #XMLTokenContext,
	#instVars : [
		'nonHtmlElement'
	],
	#category : #'XML-Parser-HTML'
}

{ #category : #'changing context' }
HTMLTokenContext >> enterNonHTMLSection: aTagName [
	context := #inNonHTMLSection.
	nonHtmlElement := aTagName.
]

{ #category : #testing }
HTMLTokenContext >> isInContent [
	^ super isInContent or: [self isInNonHTMLSection]
]

{ #category : #testing }
HTMLTokenContext >> isInNonHTMLSection [
	^ context == #inNonHTMLSection
]

{ #category : #accessing }
HTMLTokenContext >> nonHtmlElement [
	^ nonHtmlElement
]
