"
This class places security limits on parser input. You can set these using the configuration messages in SAXHandler or remove them using removeLimits.
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
	super initialize.

	documentReadLimit := 1000000.
	externalSubsetReadLimit := (documentReadLimit / 4) asInteger.
	maxEntityReplacementDepth := 3.
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
