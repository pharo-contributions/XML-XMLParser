"
A highlighting XML document text style decorator.
"
Class {
	#name : #GLMXMLDocumentHighlighterTextStylerDecorator,
	#superclass : #GLMXMLHighlighterTextStylerDecorator,
	#category : #'XML-Parser-GTExtensions-Highlighting-Parser'
}

{ #category : #private }
GLMXMLDocumentHighlighterTextStylerDecorator >> defaultEncoding [
	^ ''
]

{ #category : #accessing }
GLMXMLDocumentHighlighterTextStylerDecorator >> encoding [
	^ encoding
]

{ #category : #accessing }
GLMXMLDocumentHighlighterTextStylerDecorator >> encoding: anEncodingName [
	encoding := anEncodingName
]

{ #category : #parsing }
GLMXMLDocumentHighlighterTextStylerDecorator >> highlightingParse: aString onError: aBlock [
	| highlightingParserHandler highlightingParser |

	highlightingParserHandler :=
		self newHighlightingParserHandlerOn: aString.
	highlightingParser :=
		self newHighlightingParserFromHandler: highlightingParserHandler.
	[highlightingParser parseDocument]
		on: XMLParserException
		do: [:error |
			aBlock cull: error.
			self encoding: highlightingParserHandler encoding.
			^ highlightingParserHandler
				asHighlightedTextColored: self errorColor
				startingAt:
					(self
						highlightStartPositionForErrorAt:
							highlightingParser currentPosition
						in: aString)].
	self encoding: highlightingParserHandler encoding.
	^ highlightingParserHandler asHighlightedText.
]

{ #category : #initialization }
GLMXMLDocumentHighlighterTextStylerDecorator >> initialize [
	super initialize.

	encoding := self defaultEncoding.
]

{ #category : #private }
GLMXMLDocumentHighlighterTextStylerDecorator >> newHighlightingParserFromHandler: aHighlightingParserHandler [
	^ aHighlightingParserHandler parser
]

{ #category : #private }
GLMXMLDocumentHighlighterTextStylerDecorator >> newHighlightingParserHandlerOn: aString [
	^ XMLHighlightingParser on: aString
]
