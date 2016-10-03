"
This class is an XML parser that can convert its input to Text objects styled with highlighting after parsing.
"
Class {
	#name : #XMLHighlightingParser,
	#superclass : #SAXPositionHandler,
	#instVars : [
		'highlighter',
		'encoding'
	],
	#category : #'XML-Parser-GTExtensions-Highlighting-Parser'
}

{ #category : #converting }
XMLHighlightingParser >> asHighlightedText [
	| text |

	text := self inputText.
	highlighter highlightText: text.
	^ text.
]

{ #category : #converting }
XMLHighlightingParser >> asHighlightedTextWithRemainderColored: aTextColor startingAt: aPosition [
	| text |

	text := self asHighlightedText.
	highlighter
		highlightText: text
		withColor: aTextColor
		startingAt: aPosition.
	^ text.
]

{ #category : #accessing }
XMLHighlightingParser >> encoding [
	^ encoding
]

{ #category : #'handling - positions' }
XMLHighlightingParser >> endCDataPosition: aPosition [
	highlighter endCDataHighlightPosition: aPosition
]

{ #category : #'handling - positions' }
XMLHighlightingParser >> endCommentPosition: aPosition [
	highlighter endCommentHighlightPosition: aPosition
]

{ #category : #'handling - positions' }
XMLHighlightingParser >> endDeclarationPosition: aPosition [
	highlighter endDeclarationHighlightPosition: aPosition
]

{ #category : #'handling - positions' }
XMLHighlightingParser >> endDoctypeDeclarationPosition: aPosition [
	highlighter endDoctypeDeclarationHighlightPosition: aPosition
]

{ #category : #'handling - positions' }
XMLHighlightingParser >> endEntityReferencePosition: aPosition [
	highlighter endEntityReferenceHighlightPosition: aPosition
]

{ #category : #'handling - positions' }
XMLHighlightingParser >> endPIPosition: aPosition [
	highlighter endPIHighlightPosition: aPosition
]

{ #category : #'handling - positions' }
XMLHighlightingParser >> endQuotedStringValuePosition: aPosition [
	highlighter endQuotedStringValueHighlightPosition: aPosition
]

{ #category : #'handling - positions' }
XMLHighlightingParser >> endTagPosition: aPosition [
	highlighter endTagHighlightPosition: aPosition
]

{ #category : #'handling - positions' }
XMLHighlightingParser >> endXMLDeclarationPosition: aPosition [
	highlighter endXMLDeclarationHighlightPosition: aPosition
]

{ #category : #accessing }
XMLHighlightingParser >> highlighter [
	^ highlighter
]

{ #category : #private }
XMLHighlightingParser >> inputText [
	^ self input asString asText
]

{ #category : #initialization }
XMLHighlightingParser >> on: aStringOrStream [
	super on: aStringOrStream.

	highlighter := XMLHighlighter new.
	encoding := ''.
]

{ #category : #parsing }
XMLHighlightingParser >> parsingResult [
	^ self asHighlightedText
]

{ #category : #'handling - positions' }
XMLHighlightingParser >> startCDataPosition: aPosition [
	highlighter startCDataHighlightPosition: aPosition
]

{ #category : #'handling - positions' }
XMLHighlightingParser >> startCommentPosition: aPosition [
	highlighter startCommentHighlightPosition: aPosition
]

{ #category : #'handling - positions' }
XMLHighlightingParser >> startDeclarationPosition: aPosition [
	highlighter startDeclarationHighlightPosition: aPosition
]

{ #category : #'handling - positions' }
XMLHighlightingParser >> startDoctypeDeclarationPosition: aPosition [
	highlighter startDoctypeDeclarationHighlightPosition: aPosition
]

{ #category : #'handling - positions' }
XMLHighlightingParser >> startEntityReferencePosition: aPosition [
	highlighter startEntityReferenceHighlightPosition: aPosition
]

{ #category : #'handling - positions' }
XMLHighlightingParser >> startPIPosition: aPosition [
	highlighter startPIHighlightPosition: aPosition
]

{ #category : #'handling - positions' }
XMLHighlightingParser >> startQuotedStringValuePosition: aPosition [
	highlighter startQuotedStringValueHighlightPosition: aPosition
]

{ #category : #'handling - positions' }
XMLHighlightingParser >> startTagPosition: aPosition [
	highlighter startTagHighlightPosition: aPosition
]

{ #category : #'handling - positions' }
XMLHighlightingParser >> startXMLDeclarationPosition: aPosition [
	highlighter startXMLDeclarationHighlightPosition: aPosition
]

{ #category : #'handling - lexical' }
XMLHighlightingParser >> xmlVersion: aVersionFloat encoding: anEncoding standalone: aBoolean [
	encoding := anEncoding
]
