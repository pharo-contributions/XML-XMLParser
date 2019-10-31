"
This class stores the default highlight TextColors used by the document highlighter. It gets the initial defaults from Shout text styling.
"
Class {
	#name : #XMLDocumentHighlightDefaults,
	#superclass : #XMLHighlightDefaults,
	#classInstVars : [
		'defaultXMLDeclarationColor',
		'defaultDoctypeDeclarationColor',
		'defaultPIColor',
		'defaultDeclarationColor',
		'defaultTagColor',
		'defaultNameColor',
		'defaultQuotedStringNameColor',
		'defaultQuotedStringColor',
		'defaultEntityReferenceColor',
		'defaultCommentColor',
		'defaultCDataColor'
	],
	#category : #'XML-Parser-GTExtensions-Highlighting'
}

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultCDataColor [
	^ defaultCDataColor
		ifNil: [defaultCDataColor := TextColor color: Color gray darker ]
]

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultCDataColor: aTextColor [
	defaultCDataColor := aTextColor
]

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultCommentColor [
	^ defaultCommentColor
		ifNil: [defaultCommentColor := TextColor color: (Color r: 0.0 g: 0.519 b: 0.0 alpha: 1.0) ]
]

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultCommentColor: aTextColor [
	defaultCommentColor := aTextColor
]

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultDeclarationColor [
	^ defaultDeclarationColor
		ifNil: [defaultDeclarationColor := TextColor color: Color blue ]
]

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultDeclarationColor: aTextColor [
	defaultDeclarationColor := aTextColor
]

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultDoctypeDeclarationColor [
	^ defaultDoctypeDeclarationColor
		ifNil: [
			defaultDoctypeDeclarationColor := TextColor color: Color red ]
]

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultDoctypeDeclarationColor: aTextColor [
	defaultDoctypeDeclarationColor := aTextColor
]

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultEntityReferenceColor [
	^ defaultEntityReferenceColor
		ifNil: [
			defaultEntityReferenceColor := TextColor color: Color red ]
]

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultEntityReferenceColor: aTextColor [
	defaultEntityReferenceColor := aTextColor
]

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultNameColor [
	^ defaultNameColor
		ifNil: [defaultNameColor := TextColor color: Color blue darker ]
]

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultNameColor: aTextColor [
	defaultNameColor := aTextColor
]

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultPIColor [
	^ defaultPIColor
		ifNil: [defaultPIColor := TextColor color: Color brown ]
]

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultPIColor: aTextColor [
	defaultPIColor := aTextColor
]

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultPrimaryMarkupColor: aTextColor [
	self
		defaultDeclarationColor: aTextColor;
		defaultTagColor: aTextColor
]

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultQuotedStringColor [
	^ defaultQuotedStringColor
		ifNil: [defaultQuotedStringColor := TextColor color: Color purple ]
]

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultQuotedStringColor: aTextColor [
	defaultQuotedStringColor := aTextColor
]

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultQuotedStringNameColor [
	^ defaultQuotedStringNameColor
		ifNil: [
			defaultQuotedStringNameColor := TextColor color:
				Color red ]
]

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultQuotedStringNameColor: aTextColor [
	defaultQuotedStringNameColor := aTextColor
]

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultSecondaryMarkupColor: aTextColor [
	self
		defaultXMLDeclarationColor: aTextColor;
		defaultDoctypeDeclarationColor: aTextColor;
		defaultPIColor: aTextColor
]

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultTagColor [
	^ defaultTagColor
		ifNil: [defaultTagColor := TextColor color: Color blue ]
]

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultTagColor: aTextColor [
	defaultTagColor := aTextColor
]

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultXMLDeclarationColor [
	^ defaultXMLDeclarationColor
		ifNil: [defaultXMLDeclarationColor := TextColor color: Color red darker ]
]

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultXMLDeclarationColor: aTextColor [
	defaultXMLDeclarationColor := aTextColor
]

{ #category : #'class initialization' }
XMLDocumentHighlightDefaults class >> resetDefaults [
	super resetDefaults.

	defaultXMLDeclarationColor := nil.
	defaultDoctypeDeclarationColor := nil.
	defaultPIColor := nil.
	defaultDeclarationColor := nil.
	defaultTagColor := nil.
	defaultNameColor := nil.
	defaultQuotedStringNameColor := nil.
	defaultQuotedStringColor := nil.
	defaultEntityReferenceColor := nil.
	defaultCommentColor := nil.
	defaultCDataColor := nil.
]

{ #category : #defaults }
XMLDocumentHighlightDefaults >> cdataColor [
	^ self class defaultCDataColor
]

{ #category : #defaults }
XMLDocumentHighlightDefaults >> commentColor [
	^ self class defaultCommentColor
]

{ #category : #defaults }
XMLDocumentHighlightDefaults >> declarationColor [
	^ self class defaultDeclarationColor
]

{ #category : #defaults }
XMLDocumentHighlightDefaults >> doctypeDeclarationColor [
	^ self class defaultDoctypeDeclarationColor
]

{ #category : #defaults }
XMLDocumentHighlightDefaults >> entityReferenceColor [
	^ self class defaultEntityReferenceColor
]

{ #category : #defaults }
XMLDocumentHighlightDefaults >> nameColor [
	^ self class defaultNameColor
]

{ #category : #defaults }
XMLDocumentHighlightDefaults >> piColor [
	^ self class defaultPIColor
]

{ #category : #defaults }
XMLDocumentHighlightDefaults >> quotedStringColor [
	^ self class defaultQuotedStringColor
]

{ #category : #defaults }
XMLDocumentHighlightDefaults >> quotedStringNameColor [
	^ self class defaultQuotedStringNameColor
]

{ #category : #defaults }
XMLDocumentHighlightDefaults >> tagColor [
	^ self class defaultTagColor
]

{ #category : #defaults }
XMLDocumentHighlightDefaults >> xmlDeclarationColor [
	^ self class defaultXMLDeclarationColor
]
