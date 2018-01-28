"
A disabled version of the superclass.
"
Class {
	#name : #GLMXMLDisabledRubricHighlightedTextPresentation,
	#superclass : #GLMRubricHighlightedTextPresentation,
	#category : #'XML-ParserGTExtensions-Highlighting-Parser'
}

{ #category : #rendering }
GLMXMLDisabledRubricHighlightedTextPresentation >> renderGlamorouslyOn: aRenderer [
	^ (super renderGlamorouslyOn: aRenderer)
		beReadOnly;
		yourself
]
