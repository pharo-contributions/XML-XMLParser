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

	text := self asString asText.
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

	highlighter := XMLHighlighter new.
]

{ #category : #accessing }
XMLHighlightingWriter >> position [
	^ stream position
]
