"
This class can place limits on parser input.
"
Class {
	#name : #XMLParserLimits,
	#superclass : #Object,
	#instVars : [
		'documentReadLimit',
		'externalSubsetReadLimit',
		'maxEntityReplacementDepth'
	],
	#category : #'XML-Parser'
}

{ #category : #accessing }
XMLParserLimits >> documentReadLimit [
	^ documentReadLimit
]

{ #category : #accessing }
XMLParserLimits >> documentReadLimit: aLimit [
	documentReadLimit := aLimit
]

{ #category : #accessing }
XMLParserLimits >> externalSubsetReadLimit [
	^ externalSubsetReadLimit
]

{ #category : #accessing }
XMLParserLimits >> externalSubsetReadLimit: aLimit [
	externalSubsetReadLimit := aLimit
]

{ #category : #initialization }
XMLParserLimits >> initialize [
	super initialize
]

{ #category : #accessing }
XMLParserLimits >> maxEntityReplacementDepth [
	^ maxEntityReplacementDepth
]

{ #category : #accessing }
XMLParserLimits >> maxEntityReplacementDepth: aLimit [
	maxEntityReplacementDepth := aLimit
]

{ #category : #removing }
XMLParserLimits >> removeAll [
	documentReadLimit := nil.
	externalSubsetReadLimit := nil.
	maxEntityReplacementDepth := nil.
]
