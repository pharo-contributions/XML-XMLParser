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

{ #category : #converting }
XMLHighlightingWriter >> asHighlightedText [
	| text |

	"printString/asString forward to printStringLimitedTo: which truncates,
	so contents is used instead to get the complete text"
	text := self contents asText.
	self highlighter highlightText: text.
	^ text.
]

{ #category : #private }
XMLHighlightingWriter >> canonicalWriterFormatterClass [
	^ XMLHighlightingCanonicalWriterFormatter
]

{ #category : #accessing }
XMLHighlightingWriter >> highlighter [
	^ highlighter
]

{ #category : #initialization }
XMLHighlightingWriter >> initialize [
	super initialize.

	highlighter := XMLDocumentHighlighter new.
	self formatter: XMLHighlightingWriterFormatter new.
]

{ #category : #private }
XMLHighlightingWriter >> prettyPrintingWriterFormatterClass [
	^ XMLHighlightingPrettyPrintingWriterFormatter
]

{ #category : #private }
XMLHighlightingWriter >> prologPrettyPrintingWriterFormatterClass [
	^ XMLHighlightingPrologPrettyPrintingWriterFormatter
]
