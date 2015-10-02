"
This class is used to highlight Text objects containing XML source.
"
Class {
	#name : #XMLHighlighter,
	#superclass : #Object,
	#instVars : [
		'xmlDeclarationColor',
		'doctypeDeclarationColor',
		'declarationColor',
		'piColor',
		'entityReferenceColor',
		'commentColor',
		'tagColor',
		'cdataColor',
		'quotedStringValueColor',
		'highlights',
		'defaultHighlight',
		'xmlDeclarationHighlight',
		'doctypeDeclarationHighlight',
		'declarationHighlight',
		'piHighlight',
		'entityReferenceHighlight',
		'commentHighlight',
		'tagHighlight',
		'cdataHighlight',
		'quotedStringValueHighlight'
	],
	#category : #'XML-Parser-GTExtensions-Highlighting'
}

{ #category : #accessing }
XMLHighlighter >> cdataColor [
	^ cdataColor
]

{ #category : #accessing }
XMLHighlighter >> cdataColor: aTextColor [
	cdataColor := aTextColor
]

{ #category : #accessing }
XMLHighlighter >> commentColor [
	^ commentColor
]

{ #category : #accessing }
XMLHighlighter >> commentColor: aTextColor [
	commentColor := aTextColor
]

{ #category : #accessing }
XMLHighlighter >> declarationColor [
	^ declarationColor
]

{ #category : #accessing }
XMLHighlighter >> declarationColor: aTextColor [
	declarationColor := aTextColor
]

{ #category : #accessing }
XMLHighlighter >> defaultColor [
	^ defaultHighlight color
]

{ #category : #accessing }
XMLHighlighter >> defaultColor: aTextColor [
	defaultHighlight color: aTextColor
]

{ #category : #accessing }
XMLHighlighter >> defaults [
	^ XMLHighlightDefaults
]

{ #category : #accessing }
XMLHighlighter >> doctypeDeclarationColor [
	^ doctypeDeclarationColor
]

{ #category : #accessing }
XMLHighlighter >> doctypeDeclarationColor: aTextColor [
	doctypeDeclarationColor := aTextColor
]

{ #category : #'highlighting - positions' }
XMLHighlighter >> endCDataHighlightPosition: aPosition [
	self
		endHighlight: cdataHighlight
		position: aPosition
]

{ #category : #'highlighting - positions' }
XMLHighlighter >> endCommentHighlightPosition: aPosition [
	self
		endHighlight: commentHighlight
		position: aPosition
]

{ #category : #'highlighting - positions' }
XMLHighlighter >> endDeclarationHighlightPosition: aPosition [
	self
		endHighlight: declarationHighlight
		position: aPosition
]

{ #category : #'highlighting - positions' }
XMLHighlighter >> endDoctypeDeclarationHighlightPosition: aPosition [
	self
		endHighlight: doctypeDeclarationHighlight
		position: aPosition
]

{ #category : #'highlighting - positions' }
XMLHighlighter >> endEntityReferenceHighlightPosition: aPosition [
	self
		endHighlight: entityReferenceHighlight
		position: aPosition
]

{ #category : #private }
XMLHighlighter >> endHighlight: aHighlightOrNil position: aPosition [
	aHighlightOrNil
		ifNotNil: [aHighlightOrNil end: aPosition]
]

{ #category : #'highlighting - positions' }
XMLHighlighter >> endPIHighlightPosition: aPosition [
	self
		endHighlight: piHighlight
		position: aPosition
]

{ #category : #'highlighting - positions' }
XMLHighlighter >> endQuotedStringValueHighlightPosition: aPosition [
	self
		endHighlight: quotedStringValueHighlight
		position: aPosition
]

{ #category : #'highlighting - positions' }
XMLHighlighter >> endTagHighlightPosition: aPosition [
	self
		endHighlight: tagHighlight
		position: aPosition
]

{ #category : #'highlighting - positions' }
XMLHighlighter >> endXMLDeclarationHighlightPosition: aPosition [
	self
		endHighlight: xmlDeclarationHighlight
		position: aPosition
]

{ #category : #accessing }
XMLHighlighter >> entityReferenceColor [
	^ entityReferenceColor
]

{ #category : #accessing }
XMLHighlighter >> entityReferenceColor: aTextColor [
	entityReferenceColor := aTextColor
]

{ #category : #highlighting }
XMLHighlighter >> highlightText: aText [
	highlights do: [:each | each applyToText: aText]
]

{ #category : #highlighting }
XMLHighlighter >> highlightText: aText withColor: aTextColor startingAt: aPosition [
	XMLHighlight new
		color: aTextColor;
		start: aPosition;
		applyToText: aText
]

{ #category : #initialization }
XMLHighlighter >> initialize [
	super initialize.

	self
		initializeHighlights;
		initializeColors.
]

{ #category : #initialization }
XMLHighlighter >> initializeColors [
	self
		defaultColor: self defaults defaultDefaultColor;
		xmlDeclarationColor: self defaults defaultSecondaryMarkupColor;
		doctypeDeclarationColor: self defaults defaultSecondaryMarkupColor;
		piColor: self defaults defaultSecondaryMarkupColor;
		declarationColor: self defaults defaultPrimaryMarkupColor;
		tagColor: self defaults defaultPrimaryMarkupColor;
		quotedStringValueColor: self defaults defaultQuotedStringValueColor;
		entityReferenceColor: self defaults defaultEntityReferenceColor;
		commentColor: self defaults defaultCommentColor;
		cdataColor: self defaults defaultCDataColor
]

{ #category : #initialization }
XMLHighlighter >> initializeHighlights [
	defaultHighlight := XMLHighlight new.
	highlights := OrderedCollection with: defaultHighlight.
]

{ #category : #private }
XMLHighlighter >> newHighlightColor: aTextColor position: aPosition [
	^ aTextColor
		ifNotNil: [
			highlights addLast:
				(XMLHighlight new
					color: aTextColor;
					start: aPosition)]
]

{ #category : #accessing }
XMLHighlighter >> piColor [
	^ piColor
]

{ #category : #accessing }
XMLHighlighter >> piColor: aTextColor [
	piColor := aTextColor
]

{ #category : #accessing }
XMLHighlighter >> quotedStringValueColor [
	^ quotedStringValueColor
]

{ #category : #accessing }
XMLHighlighter >> quotedStringValueColor: aTextColor [
	quotedStringValueColor := aTextColor
]

{ #category : #'highlighting - positions' }
XMLHighlighter >> startCDataHighlightPosition: aPosition [
	cdataHighlight :=
		self
			newHighlightColor: self cdataColor
			position: aPosition
]

{ #category : #'highlighting - positions' }
XMLHighlighter >> startCommentHighlightPosition: aPosition [
	commentHighlight :=
		self
			newHighlightColor: self commentColor
			position: aPosition
]

{ #category : #'highlighting - positions' }
XMLHighlighter >> startDeclarationHighlightPosition: aPosition [
	declarationHighlight :=
		self
			newHighlightColor: self declarationColor
			position: aPosition
]

{ #category : #'highlighting - positions' }
XMLHighlighter >> startDoctypeDeclarationHighlightPosition: aPosition [
	doctypeDeclarationHighlight :=
		self
			newHighlightColor: self doctypeDeclarationColor
			position: aPosition
]

{ #category : #'highlighting - positions' }
XMLHighlighter >> startEntityReferenceHighlightPosition: aPosition [
	entityReferenceHighlight :=
		self
			newHighlightColor: self entityReferenceColor
			position: aPosition
]

{ #category : #'highlighting - positions' }
XMLHighlighter >> startPIHighlightPosition: aPosition [
	piHighlight :=
		self
			newHighlightColor: self piColor
			position: aPosition
]

{ #category : #'highlighting - positions' }
XMLHighlighter >> startQuotedStringValueHighlightPosition: aPosition [
	quotedStringValueHighlight :=
		self
			newHighlightColor: self quotedStringValueColor
			position: aPosition
]

{ #category : #'highlighting - positions' }
XMLHighlighter >> startTagHighlightPosition: aPosition [
	tagHighlight :=
		self
			newHighlightColor: self tagColor
			position: aPosition
]

{ #category : #'highlighting - positions' }
XMLHighlighter >> startXMLDeclarationHighlightPosition: aPosition [
	xmlDeclarationHighlight :=
		self
			newHighlightColor: self xmlDeclarationColor
			position: aPosition
]

{ #category : #accessing }
XMLHighlighter >> tagColor [
	^ tagColor
]

{ #category : #accessing }
XMLHighlighter >> tagColor: aTextColor [
	tagColor := aTextColor
]

{ #category : #accessing }
XMLHighlighter >> xmlDeclarationColor [
	^ xmlDeclarationColor
]

{ #category : #accessing }
XMLHighlighter >> xmlDeclarationColor: aTextColor [
	xmlDeclarationColor := aTextColor
]
