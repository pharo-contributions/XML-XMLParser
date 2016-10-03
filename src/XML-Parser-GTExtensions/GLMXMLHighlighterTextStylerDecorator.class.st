"
A highlighter text styler decorator for XML source code.
"
Class {
	#name : #GLMXMLHighlighterTextStylerDecorator,
	#superclass : #GLMHighlighterTextStylerDecorator,
	#instVars : [
		'highlightableLengthLimit',
		'errorColor',
		'encoding'
	],
	#category : #'XML-Parser-GTExtensions-Highlighting-Parser'
}

{ #category : #accessing }
GLMXMLHighlighterTextStylerDecorator >> defaultStyler [
	^ GLMHighlighterTextParserStyler new
		view: self;
		parser: self
]

{ #category : #accessing }
GLMXMLHighlighterTextStylerDecorator >> encoding [
	^ encoding
]

{ #category : #accessing }
GLMXMLHighlighterTextStylerDecorator >> errorColor [
	^ errorColor
]

{ #category : #accessing }
GLMXMLHighlighterTextStylerDecorator >> errorColor: aTextColor [
	errorColor := aTextColor
]

{ #category : #testing }
GLMXMLHighlighterTextStylerDecorator >> hasEncoding [
	^ self encoding notEmpty
]

{ #category : #accessing }
GLMXMLHighlighterTextStylerDecorator >> highlightableLengthLimit [
	^ highlightableLengthLimit
]

{ #category : #accessing }
GLMXMLHighlighterTextStylerDecorator >> highlightableLengthLimit: aLimit [
	highlightableLengthLimit := aLimit
]

{ #category : #initialization }
GLMXMLHighlighterTextStylerDecorator >> initialize [
	super initialize.

	highlightableLengthLimit := 100000.
	errorColor := TextColor red.
	encoding := ''.
]

{ #category : #parsing }
GLMXMLHighlighterTextStylerDecorator >> parse: aString onError: anError [
	| highlightingParser parser highlightedText |

	aString size > self highlightableLengthLimit
		ifTrue: [^ aString asText].

	highlightingParser := XMLHighlightingParser on: aString.
	parser := highlightingParser parser. "used to get position on error"
	[parser parseDocument.
		highlightedText := highlightingParser asHighlightedText]
		on: XMLParserException
		do: [:error |
			highlightedText :=
				highlightingParser
					asHighlightedTextWithRemainderColored: self errorColor
					startingAt:
						(parser currentPosition >= aString size
							ifTrue: [1]
							ifFalse: [parser currentPosition])].
	encoding := highlightingParser encoding.

	^ highlightedText.
]

{ #category : #parsing }
GLMXMLHighlighterTextStylerDecorator >> parser [
	^ self
]
