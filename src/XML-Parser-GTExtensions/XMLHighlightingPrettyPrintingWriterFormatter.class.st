"
This formatter adds highlights to XMLHighlightingWriter output.
"
Class {
	#name : #XMLHighlightingPrettyPrintingWriterFormatter,
	#superclass : #XMLPrettyPrintingWriterFormatter,
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
	#classInstVars : [
		'defaultDefaultColor',
		'defaultCDataColor',
		'defaultCommentColor',
		'defaultEntityReferenceColor',
		'defaultPrimaryMarkupColor',
		'defaultQuotedStringValueColor',
		'defaultSecondaryMarkupColor'
	],
	#category : #'XML-Parser-GTExtensions'
}

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter class >> defaultCDataColor [
	^ defaultCDataColor
		ifNil: [defaultCDataColor := self textColorForShoutProperty: #primitive]
]

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter class >> defaultCDataColor: aTextColor [
	defaultCDataColor := aTextColor
]

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter class >> defaultCommentColor [
	^ defaultCommentColor
		ifNil: [defaultCommentColor :=  self textColorForShoutProperty: #comment]
]

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter class >> defaultCommentColor: aTextColor [
	defaultCommentColor := aTextColor
]

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter class >> defaultDefaultColor [
	^ defaultDefaultColor
		ifNil: [defaultDefaultColor := self textColorForShoutProperty: #default]
]

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter class >> defaultDefaultColor: aTextColor [
	defaultDefaultColor := aTextColor
]

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter class >> defaultEntityReferenceColor [
	^ defaultEntityReferenceColor
		ifNil: [defaultEntityReferenceColor := self textColorForShoutProperty: #character]
]

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter class >> defaultEntityReferenceColor: aTextColor [
	defaultEntityReferenceColor := aTextColor
]

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter class >> defaultPrimaryMarkupColor [
	^ defaultPrimaryMarkupColor
		ifNil: [defaultPrimaryMarkupColor := self textColorForShoutProperty: #argument]
]

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter class >> defaultPrimaryMarkupColor: aTextColor [
	defaultPrimaryMarkupColor := aTextColor
]

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter class >> defaultQuotedStringValueColor [
	^ defaultQuotedStringValueColor
		ifNil: [defaultQuotedStringValueColor := self textColorForShoutProperty: #string]
]

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter class >> defaultQuotedStringValueColor: aTextColor [
	defaultQuotedStringValueColor := aTextColor
]

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter class >> defaultSecondaryMarkupColor [
	^ defaultSecondaryMarkupColor
		ifNil: [defaultSecondaryMarkupColor := self textColorForShoutProperty: #self]
]

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter class >> defaultSecondaryMarkupColor: aTextColor [
	defaultSecondaryMarkupColor := aTextColor
]

{ #category : #'class initialization' }
XMLHighlightingPrettyPrintingWriterFormatter class >> initialize [
	"self initialize"

	self
		defaultDefaultColor: nil;
		defaultPrimaryMarkupColor: nil;
		defaultSecondaryMarkupColor: nil;
		defaultQuotedStringValueColor: nil;
		defaultEntityReferenceColor: nil;
		defaultCommentColor: nil;
		defaultCDataColor: nil
]

{ #category : #private }
XMLHighlightingPrettyPrintingWriterFormatter class >> textColorForShoutProperty: aShoutProperty [
	^ TextColor color:
		(((SHTextStylerST80 new attributesFor: aShoutProperty)
			detect: [:each | each respondsTo: #color]
			ifNone: [^ nil]) color)
]

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter >> cdataColor [
	^ cdataColor
]

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter >> cdataColor: aTextColor [
	cdataColor := aTextColor
]

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter >> commentColor [
	^ commentColor
]

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter >> commentColor: aTextColor [
	commentColor := aTextColor
]

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter >> declarationColor [
	^ declarationColor
]

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter >> declarationColor: aTextColor [
	declarationColor := aTextColor
]

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter >> defaultColor [
	^ defaultHighlight color
]

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter >> defaultColor: aTextColor [
	defaultHighlight color: aTextColor
]

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter >> doctypeDeclarationColor [
	^ doctypeDeclarationColor
]

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter >> doctypeDeclarationColor: aTextColor [
	doctypeDeclarationColor := aTextColor
]

{ #category : #'private ' }
XMLHighlightingPrettyPrintingWriterFormatter >> endHighlight: aHighlight [
	aHighlight
		ifNotNil: [aHighlight end: self writer position]
]

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter >> entityReferenceColor [
	^ entityReferenceColor
]

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter >> entityReferenceColor: aTextColor [
	entityReferenceColor := aTextColor
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatAfterCData: aCDataWriter [
	self endHighlight: cdataHighlight.

	super formatAfterCData: aCDataWriter.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatAfterCharacterEscape: aCharacterEscape [
	self endHighlight: entityReferenceHighlight.

	super formatAfterCharacterEscape: aCharacterEscape.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatAfterComment: aCommentWriter [
	self endHighlight: commentHighlight.

	super formatAfterComment: aCommentWriter.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatAfterDeclaration: aDeclarationWriter [
	self endHighlight: declarationHighlight.

	super formatAfterDeclaration: aDeclarationWriter.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatAfterDoctypeDeclaration: aDoctypeDeclarationWriter [
	self endHighlight: doctypeDeclarationHighlight.

	super formatAfterDoctypeDeclaration: aDoctypeDeclarationWriter.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatAfterEndTag: aTagWriter [
	self endHighlight: tagHighlight.

	super formatAfterEndTag: aTagWriter.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatAfterEntityReference: anEntityReferenceWriter [
	self endHighlight: entityReferenceHighlight.

	super formatAfterEntityReference: anEntityReferenceWriter.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatAfterPI: aPIWriter [
	self endHighlight: piHighlight.

	super formatAfterPI: aPIWriter.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatAfterQuotedStringValue: aString [
	self endHighlight: quotedStringValueHighlight.

	super formatAfterQuotedStringValue: aString.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatAfterStartTag: aTagWriter [
	self endHighlight: tagHighlight.

	super formatAfterStartTag: aTagWriter.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatAfterXMLDeclaration: anXMLDeclarationWriter [
	self endHighlight: xmlDeclarationHighlight.

	super formatAfterXMLDeclaration: anXMLDeclarationWriter.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatBeforeCData: aCDataWriter [
	super formatBeforeCData: aCDataWriter.

	cdataHighlight := self newHighlightColored: self cdataColor.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatBeforeCharacterEscape: aCharacterEscape [
	super formatBeforeCharacterEscape: aCharacterEscape.

	entityReferenceHighlight := self newHighlightColored: self entityReferenceColor.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatBeforeComment: aCommentWriter [
	super formatBeforeComment: aCommentWriter.

	commentHighlight := self newHighlightColored: self commentColor.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatBeforeDeclaration: aDeclarationWriter [
	super formatBeforeDeclaration: aDeclarationWriter.

	declarationHighlight := self newHighlightColored: self declarationColor.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatBeforeDoctypeDeclaration: aDoctypeDeclarationWriter [
	super formatBeforeDoctypeDeclaration: aDoctypeDeclarationWriter.

	doctypeDeclarationHighlight := self newHighlightColored: self doctypeDeclarationColor.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatBeforeEndTag: aTagWriter [
	super formatBeforeEndTag: aTagWriter.

	self startNewTagHighlight.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatBeforeEntityReference: anEntityReferenceWriter [
	super formatBeforeEntityReference: anEntityReferenceWriter.

	entityReferenceHighlight := self newHighlightColored: self entityReferenceColor.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatBeforePI: aPIWriter [
	super formatBeforePI: aPIWriter.

	piHighlight := self newHighlightColored: self piColor.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatBeforeQuotedStringValue: aString [
	super formatBeforeQuotedStringValue: aString.

	quotedStringValueHighlight := self newHighlightColored: self quotedStringValueColor.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatBeforeStartTag: aTagWriter [
	super formatBeforeStartTag: aTagWriter.

	self startNewTagHighlight.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatBeforeXMLDeclaration: anXMLDeclarationWriter [
	super formatBeforeXMLDeclaration: anXMLDeclarationWriter.

	xmlDeclarationHighlight := self newHighlightColored: self xmlDeclarationColor.
]

{ #category : #initialization }
XMLHighlightingPrettyPrintingWriterFormatter >> initialize [
	super initialize.

	self
		initializeDefaultHighlight;
		initializeColors.
]

{ #category : #initialization }
XMLHighlightingPrettyPrintingWriterFormatter >> initializeColors [
	self
		defaultColor: self class defaultDefaultColor;
		xmlDeclarationColor: self class defaultSecondaryMarkupColor;
		doctypeDeclarationColor: self class defaultSecondaryMarkupColor;
		piColor: self class defaultSecondaryMarkupColor;
		declarationColor: self class defaultPrimaryMarkupColor;
		tagColor: self class defaultPrimaryMarkupColor;
		quotedStringValueColor: self class defaultQuotedStringValueColor;
		entityReferenceColor: self class defaultEntityReferenceColor;
		commentColor: self class defaultCommentColor;
		cdataColor: self class defaultCDataColor
]

{ #category : #initialization }
XMLHighlightingPrettyPrintingWriterFormatter >> initializeDefaultHighlight [
	defaultHighlight := XMLHighlight new
]

{ #category : #'private ' }
XMLHighlightingPrettyPrintingWriterFormatter >> newHighlightColored: aTextColor [
	^ aTextColor
		ifNotNil: [
			self writer addHighlight: 
				(XMLHighlight new
					color: aTextColor;
					start: self writer position + 1)]
]

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter >> piColor [
	^ piColor
]

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter >> piColor: aTextColor [
	piColor := aTextColor
]

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter >> quotedStringValueColor [
	^ quotedStringValueColor
]

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter >> quotedStringValueColor: aTextColor [
	quotedStringValueColor := aTextColor
]

{ #category : #'private ' }
XMLHighlightingPrettyPrintingWriterFormatter >> startNewTagHighlight [
	tagHighlight := self newHighlightColored: self tagColor
]

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter >> tagColor [
	^ tagColor
]

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter >> tagColor: aTextColor [
	tagColor := aTextColor
]

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter >> writer: aWriter [
	super writer: aWriter.

	aWriter addHighlight: defaultHighlight.
]

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter >> xmlDeclarationColor [
	^ xmlDeclarationColor
]

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter >> xmlDeclarationColor: aTextColor [
	xmlDeclarationColor := aTextColor
]
