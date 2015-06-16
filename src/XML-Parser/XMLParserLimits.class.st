"
This class places security limits on parser input. You can change them using configuration messages in SAXHandler or remove them with removeLimits.
"
Class {
	#name : #XMLParserLimits,
	#superclass : #Object,
	#instVars : [
		'documentReadLimit',
		'maxEntityReplacementDepth'
	],
	#classInstVars : [
		'defaultReadLimit'
	],
	#category : #'XML-Parser'
}

{ #category : #accessing }
XMLParserLimits class >> defaultDocumentReadLimit [
	^ self defaultReadLimit
]

{ #category : #accessing }
XMLParserLimits class >> defaultReadLimit [
	^ defaultReadLimit
]

{ #category : #accessing }
XMLParserLimits class >> defaultReadLimit: aReadLimit [
	defaultReadLimit := aReadLimit
]

{ #category : #'class initialization' }
XMLParserLimits class >> initialize [
	"self initialize"

	defaultReadLimit := 10000000
]

{ #category : #accessing }
XMLParserLimits >> documentReadLimit [
	^ documentReadLimit
]

{ #category : #accessing }
XMLParserLimits >> documentReadLimit: aLimit [
	documentReadLimit := aLimit
]

{ #category : #initialization }
XMLParserLimits >> initialize [
	super initialize.

	documentReadLimit := self class defaultDocumentReadLimit.
	maxEntityReplacementDepth := 10.
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
	maxEntityReplacementDepth := nil.
]
