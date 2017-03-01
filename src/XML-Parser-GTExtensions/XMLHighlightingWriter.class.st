"
This class is an XMLWriter that can make highlighted text output with XMLHighlightingPrettyPrintingWriterFormatter and XMLHighlighter.
"
Class {
	#name : #XMLHighlightingWriter,
	#superclass : #XMLWriter,
	#instVars : [
		'highlighter'
	],
	#category : #'XML-Parser-GTExtensions-Highlighting-Writer'
}

{ #category : #'instance creation' }
XMLHighlightingWriter class >> on: aStream [
	^ (super on: aStream) formatter: XMLHighlightingPrettyPrintingWriterFormatter new
]

{ #category : #converting }
XMLHighlightingWriter >> asHighlightedText [
	| text |

	"printString/asString forward to printStringLimitedTo: which truncates,
	so contents is used instead to get the complete text"
	text := self contents asText.
	self highlighter highlightText: text.
	^ text.
]

{ #category : #accessing }
XMLHighlightingWriter >> highlighter [
	^ highlighter
]

{ #category : #initialization }
XMLHighlightingWriter >> initialize [
	super initialize.

	highlighter := XMLDocumentHighlighter new.
]

{ #category : #accessing }
XMLHighlightingWriter >> position [
	^ stream position
]
