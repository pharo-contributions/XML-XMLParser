"
This class is an XMLWriter that can make highlighted text output with XMLHighlightingPrettyPrintingWriterFormatter.
"
Class {
	#name : #XMLHighlightingWriter,
	#superclass : #XMLWriter,
	#instVars : [
		'highlights'
	],
	#category : #'XML-Parser-GTExtensions'
}

{ #category : #'instance creation' }
XMLHighlightingWriter class >> on: aStream [
	^ (super on: aStream) formatter: XMLHighlightingPrettyPrintingWriterFormatter new
]

{ #category : #'private ' }
XMLHighlightingWriter >> addHighlight: aHighlight [
	^ highlights addLast: aHighlight
]

{ #category : #converting }
XMLHighlightingWriter >> asHighlightedText [
	| text |

	text := self asString asText.
	highlights do: [:each | each applyToText: text].
	^ text.
]

{ #category : #'private ' }
XMLHighlightingWriter >> highlights [
	^ highlights
]

{ #category : #initialization }
XMLHighlightingWriter >> initialize [
	super initialize.

	highlights := OrderedCollection new.
]

{ #category : #accessing }
XMLHighlightingWriter >> position [
	^ stream position
]
