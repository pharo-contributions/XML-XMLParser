"
A highlighter text styler decorator for XML source code.
"
Class {
	#name : #GLMXMLHighlighterTextStylerDecorator,
	#superclass : #GLMHighlighterTextStylerDecorator,
	#category : #'XML-Parser-GTExtensions-Highlighting-Parser'
}

{ #category : #accessing }
GLMXMLHighlighterTextStylerDecorator >> defaultStyler [
	^ GLMHighlighterTextParserStyler new
		view: self;
		parser: self
]

{ #category : #accessing }
GLMXMLHighlighterTextStylerDecorator >> errorColor [
	^ TextColor red
]

{ #category : #accessing }
GLMXMLHighlighterTextStylerDecorator >> highlightableLengthLimit [
	^ 100000
]

{ #category : #parsing }
GLMXMLHighlighterTextStylerDecorator >> parse: aString onError: anError [
	| highlightingParser parser |

	aString size > self highlightableLengthLimit
		ifTrue: [^ aString asText].

	highlightingParser := XMLHighlightingParser on: aString.
	parser := highlightingParser parser.
	^ [parser parseDocument.
		highlightingParser asHighlightedText]
		on: XMLParserException
		do: [:error | | errorPosition |
			(errorPosition := parser currentPosition) >= aString size
				ifTrue: [
					highlightingParser
						asHighlightedTextWithRemainderColored: self errorColor
						startingAt: 1]
				ifFalse: [
					highlightingParser
						asHighlightedTextWithRemainderColored: self errorColor
						startingAt: errorPosition - 1]].
]

{ #category : #parsing }
GLMXMLHighlighterTextStylerDecorator >> parser [
	^ self
]
