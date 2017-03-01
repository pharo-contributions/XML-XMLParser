"
This class is highlighter to highlight XML document Text objects using XMLHighlights.
"
Class {
	#name : #XMLDocumentHighlighter,
	#superclass : #XMLHighlighter,
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
XMLDocumentHighlighter >> cdataColor [
	^ cdataColor
]

{ #category : #accessing }
XMLDocumentHighlighter >> cdataColor: aTextColor [
	cdataColor := aTextColor
]

{ #category : #accessing }
XMLDocumentHighlighter >> commentColor [
	^ commentColor
]

{ #category : #accessing }
XMLDocumentHighlighter >> commentColor: aTextColor [
	commentColor := aTextColor
]

{ #category : #accessing }
XMLDocumentHighlighter >> declarationColor [
	^ declarationColor
]

{ #category : #accessing }
XMLDocumentHighlighter >> declarationColor: aTextColor [
	declarationColor := aTextColor
]

{ #category : #accessing }
XMLDocumentHighlighter >> defaults [
	^ XMLDocumentHighlightDefaults
]

{ #category : #accessing }
XMLDocumentHighlighter >> doctypeDeclarationColor [
	^ doctypeDeclarationColor
]

{ #category : #accessing }
XMLDocumentHighlighter >> doctypeDeclarationColor: aTextColor [
	doctypeDeclarationColor := aTextColor
]

{ #category : #'highlighting - positions' }
XMLDocumentHighlighter >> endCDataHighlightPosition: aPosition [
	self
		endHighlight: cdataHighlight
		position: aPosition
]

{ #category : #'highlighting - positions' }
XMLDocumentHighlighter >> endCommentHighlightPosition: aPosition [
	self
		endHighlight: commentHighlight
		position: aPosition
]

{ #category : #'highlighting - positions' }
XMLDocumentHighlighter >> endDeclarationHighlightPosition: aPosition [
	self
		endHighlight: declarationHighlight
		position: aPosition
]

{ #category : #'highlighting - positions' }
XMLDocumentHighlighter >> endDoctypeDeclarationHighlightPosition: aPosition [
	self
		endHighlight: doctypeDeclarationHighlight
		position: aPosition
]

{ #category : #'highlighting - positions' }
XMLDocumentHighlighter >> endEntityReferenceHighlightPosition: aPosition [
	self
		endHighlight: entityReferenceHighlight
		position: aPosition
]

{ #category : #'highlighting - positions' }
XMLDocumentHighlighter >> endPIHighlightPosition: aPosition [
	self
		endHighlight: piHighlight
		position: aPosition
]

{ #category : #'highlighting - positions' }
XMLDocumentHighlighter >> endQuotedStringValueHighlightPosition: aPosition [
	self
		endHighlight: quotedStringValueHighlight
		position: aPosition
]

{ #category : #'highlighting - positions' }
XMLDocumentHighlighter >> endTagHighlightPosition: aPosition [
	self
		endHighlight: tagHighlight
		position: aPosition
]

{ #category : #'highlighting - positions' }
XMLDocumentHighlighter >> endXMLDeclarationHighlightPosition: aPosition [
	self
		endHighlight: xmlDeclarationHighlight
		position: aPosition
]

{ #category : #accessing }
XMLDocumentHighlighter >> entityReferenceColor [
	^ entityReferenceColor
]

{ #category : #accessing }
XMLDocumentHighlighter >> entityReferenceColor: aTextColor [
	entityReferenceColor := aTextColor
]

{ #category : #initialization }
XMLDocumentHighlighter >> initializeColors [
	super initializeColors.
	self
		xmlDeclarationColor: self defaults defaultSecondaryMarkupColor;
		doctypeDeclarationColor: self defaults defaultSecondaryMarkupColor;
		piColor: self defaults defaultSecondaryMarkupColor;
		declarationColor: self defaults defaultPrimaryMarkupColor;
		tagColor: self defaults defaultPrimaryMarkupColor;
		quotedStringValueColor: self defaults defaultQuotedStringValueColor;
		entityReferenceColor: self defaults defaultEntityReferenceColor;
		commentColor: self defaults defaultCommentColor;
		cdataColor: self defaults defaultCDataColor.
]

{ #category : #accessing }
XMLDocumentHighlighter >> piColor [
	^ piColor
]

{ #category : #accessing }
XMLDocumentHighlighter >> piColor: aTextColor [
	piColor := aTextColor
]

{ #category : #accessing }
XMLDocumentHighlighter >> quotedStringValueColor [
	^ quotedStringValueColor
]

{ #category : #accessing }
XMLDocumentHighlighter >> quotedStringValueColor: aTextColor [
	quotedStringValueColor := aTextColor
]

{ #category : #'highlighting - positions' }
XMLDocumentHighlighter >> startCDataHighlightPosition: aPosition [
	cdataHighlight :=
		self
			newHighlightColor: self cdataColor
			position: aPosition
]

{ #category : #'highlighting - positions' }
XMLDocumentHighlighter >> startCommentHighlightPosition: aPosition [
	commentHighlight :=
		self
			newHighlightColor: self commentColor
			position: aPosition
]

{ #category : #'highlighting - positions' }
XMLDocumentHighlighter >> startDeclarationHighlightPosition: aPosition [
	declarationHighlight :=
		self
			newHighlightColor: self declarationColor
			position: aPosition
]

{ #category : #'highlighting - positions' }
XMLDocumentHighlighter >> startDoctypeDeclarationHighlightPosition: aPosition [
	doctypeDeclarationHighlight :=
		self
			newHighlightColor: self doctypeDeclarationColor
			position: aPosition
]

{ #category : #'highlighting - positions' }
XMLDocumentHighlighter >> startEntityReferenceHighlightPosition: aPosition [
	entityReferenceHighlight :=
		self
			newHighlightColor: self entityReferenceColor
			position: aPosition
]

{ #category : #'highlighting - positions' }
XMLDocumentHighlighter >> startPIHighlightPosition: aPosition [
	piHighlight :=
		self
			newHighlightColor: self piColor
			position: aPosition
]

{ #category : #'highlighting - positions' }
XMLDocumentHighlighter >> startQuotedStringValueHighlightPosition: aPosition [
	quotedStringValueHighlight :=
		self
			newHighlightColor: self quotedStringValueColor
			position: aPosition
]

{ #category : #'highlighting - positions' }
XMLDocumentHighlighter >> startTagHighlightPosition: aPosition [
	tagHighlight :=
		self
			newHighlightColor: self tagColor
			position: aPosition
]

{ #category : #'highlighting - positions' }
XMLDocumentHighlighter >> startXMLDeclarationHighlightPosition: aPosition [
	xmlDeclarationHighlight :=
		self
			newHighlightColor: self xmlDeclarationColor
			position: aPosition
]

{ #category : #accessing }
XMLDocumentHighlighter >> tagColor [
	^ tagColor
]

{ #category : #accessing }
XMLDocumentHighlighter >> tagColor: aTextColor [
	tagColor := aTextColor
]

{ #category : #accessing }
XMLDocumentHighlighter >> xmlDeclarationColor [
	^ xmlDeclarationColor
]

{ #category : #accessing }
XMLDocumentHighlighter >> xmlDeclarationColor: aTextColor [
	xmlDeclarationColor := aTextColor
]
