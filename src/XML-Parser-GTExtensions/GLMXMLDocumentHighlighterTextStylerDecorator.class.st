"
A highlighting XML document text style decorator.
"
Class {
	#name : #GLMXMLDocumentHighlighterTextStylerDecorator,
	#superclass : #GLMXMLHighlighterTextStylerDecorator,
	#category : #'XML-Parser-GTExtensions-Highlighting-Parser'
}

{ #category : #private }
GLMXMLDocumentHighlighterTextStylerDecorator >> highlightingParse: aString onSuccess: aOneArgumentBlock onError: aTwoArgumentBlock [
	| highlightingParserHandler highlightingParser |

	highlightingParserHandler := self newHighlightingParserHandlerOn: aString.
	highlightingParser := self newHighlightingParserFromHandler: highlightingParserHandler.
	[highlightingParser parseDocument]
		on: XMLParserException
		do: [:error |
			^ aTwoArgumentBlock
				value: highlightingParserHandler
				value: highlightingParser currentPosition].
	^ aOneArgumentBlock value: highlightingParserHandler.
]

{ #category : #private }
GLMXMLDocumentHighlighterTextStylerDecorator >> newHighlightingParserFromHandler: aHighlightingParserHandler [
	^ aHighlightingParserHandler parser
]

{ #category : #private }
GLMXMLDocumentHighlighterTextStylerDecorator >> newHighlightingParserHandlerOn: aString [
	^ XMLHighlightingParser on: aString
]
