"
This class stores a highlight TextColor and 1-based start/end highlight positions.
"
Class {
	#name : #XMLHighlight,
	#superclass : #Object,
	#instVars : [
		'color',
		'start',
		'end'
	],
	#category : #'XML-Parser-GTExtensions'
}

{ #category : #highlighting }
XMLHighlight >> applyToText: aText [
	| attributeStart attributeEnd |

	attributeStart := self start ifNil: [1].
	attributeEnd := self end ifNil: [aText size].
	attributeStart < attributeEnd
		ifTrue: [
			aText
				addAttribute: self color
				from: attributeStart
				to: attributeEnd].
]

{ #category : #accessing }
XMLHighlight >> color [
	^ color
]

{ #category : #accessing }
XMLHighlight >> color: aTextColor [
	color := aTextColor
]

{ #category : #accessing }
XMLHighlight >> end [
	^ end
]

{ #category : #accessing }
XMLHighlight >> end: anEndPosition [
	end := anEndPosition
]

{ #category : #accessing }
XMLHighlight >> start [
	^ start
]

{ #category : #accessing }
XMLHighlight >> start: aStartPosition [
	start := aStartPosition
]
