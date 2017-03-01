"
This class stores the default highlight TextColors used by the document highlighter. It gets the initial defaults from Shout text styling.
"
Class {
	#name : #XMLDocumentHighlightDefaults,
	#superclass : #XMLHighlightDefaults,
	#classInstVars : [
		'defaultCDataColor',
		'defaultCommentColor',
		'defaultEntityReferenceColor',
		'defaultPrimaryMarkupColor',
		'defaultQuotedStringValueColor',
		'defaultSecondaryMarkupColor'
	],
	#category : #'XML-Parser-GTExtensions-Highlighting'
}

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultCDataColor [
	^ defaultCDataColor
		ifNil: [defaultCDataColor := self textColorForShoutProperty: #primitive]
]

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultCDataColor: aTextColor [
	defaultCDataColor := aTextColor
]

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultCommentColor [
	^ defaultCommentColor
		ifNil: [defaultCommentColor :=  self textColorForShoutProperty: #comment]
]

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultCommentColor: aTextColor [
	defaultCommentColor := aTextColor
]

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultEntityReferenceColor [
	^ defaultEntityReferenceColor
		ifNil: [defaultEntityReferenceColor := self textColorForShoutProperty: #character]
]

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultEntityReferenceColor: aTextColor [
	defaultEntityReferenceColor := aTextColor
]

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultPrimaryMarkupColor [
	^ defaultPrimaryMarkupColor
		ifNil: [defaultPrimaryMarkupColor := self textColorForShoutProperty: #argument]
]

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultPrimaryMarkupColor: aTextColor [
	defaultPrimaryMarkupColor := aTextColor
]

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultQuotedStringValueColor [
	^ defaultQuotedStringValueColor
		ifNil: [defaultQuotedStringValueColor := self textColorForShoutProperty: #string]
]

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultQuotedStringValueColor: aTextColor [
	defaultQuotedStringValueColor := aTextColor
]

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultSecondaryMarkupColor [
	^ defaultSecondaryMarkupColor
		ifNil: [defaultSecondaryMarkupColor := self textColorForShoutProperty: #self]
]

{ #category : #accessing }
XMLDocumentHighlightDefaults class >> defaultSecondaryMarkupColor: aTextColor [
	defaultSecondaryMarkupColor := aTextColor
]

{ #category : #'class initialization' }
XMLDocumentHighlightDefaults class >> initialize [
	"self initialize"

	defaultDefaultColor := nil.
	defaultPrimaryMarkupColor := nil.
	defaultSecondaryMarkupColor := nil.
	defaultQuotedStringValueColor := nil.
	defaultEntityReferenceColor := nil.
	defaultCommentColor := nil.
	defaultCDataColor := nil.
]
