"
This class stores the default highlight TextColors used by the highlighter. It gets the initial defaults from Shout text styling.
"
Class {
	#name : #XMLHighlightDefaults,
	#superclass : #Object,
	#classInstVars : [
		'defaultDefaultColor',
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
XMLHighlightDefaults class >> defaultCDataColor [
	^ defaultCDataColor
		ifNil: [defaultCDataColor := self textColorForShoutProperty: #primitive]
]

{ #category : #accessing }
XMLHighlightDefaults class >> defaultCDataColor: aTextColor [
	defaultCDataColor := aTextColor
]

{ #category : #accessing }
XMLHighlightDefaults class >> defaultCommentColor [
	^ defaultCommentColor
		ifNil: [defaultCommentColor :=  self textColorForShoutProperty: #comment]
]

{ #category : #accessing }
XMLHighlightDefaults class >> defaultCommentColor: aTextColor [
	defaultCommentColor := aTextColor
]

{ #category : #accessing }
XMLHighlightDefaults class >> defaultDefaultColor [
	^ defaultDefaultColor
		ifNil: [defaultDefaultColor := self textColorForShoutProperty: #default]
]

{ #category : #accessing }
XMLHighlightDefaults class >> defaultDefaultColor: aTextColor [
	defaultDefaultColor := aTextColor
]

{ #category : #accessing }
XMLHighlightDefaults class >> defaultEntityReferenceColor [
	^ defaultEntityReferenceColor
		ifNil: [defaultEntityReferenceColor := self textColorForShoutProperty: #character]
]

{ #category : #accessing }
XMLHighlightDefaults class >> defaultEntityReferenceColor: aTextColor [
	defaultEntityReferenceColor := aTextColor
]

{ #category : #accessing }
XMLHighlightDefaults class >> defaultPrimaryMarkupColor [
	^ defaultPrimaryMarkupColor
		ifNil: [defaultPrimaryMarkupColor := self textColorForShoutProperty: #argument]
]

{ #category : #accessing }
XMLHighlightDefaults class >> defaultPrimaryMarkupColor: aTextColor [
	defaultPrimaryMarkupColor := aTextColor
]

{ #category : #accessing }
XMLHighlightDefaults class >> defaultQuotedStringValueColor [
	^ defaultQuotedStringValueColor
		ifNil: [defaultQuotedStringValueColor := self textColorForShoutProperty: #string]
]

{ #category : #accessing }
XMLHighlightDefaults class >> defaultQuotedStringValueColor: aTextColor [
	defaultQuotedStringValueColor := aTextColor
]

{ #category : #accessing }
XMLHighlightDefaults class >> defaultSecondaryMarkupColor [
	^ defaultSecondaryMarkupColor
		ifNil: [defaultSecondaryMarkupColor := self textColorForShoutProperty: #self]
]

{ #category : #accessing }
XMLHighlightDefaults class >> defaultSecondaryMarkupColor: aTextColor [
	defaultSecondaryMarkupColor := aTextColor
]

{ #category : #'class initialization' }
XMLHighlightDefaults class >> initialize [
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
XMLHighlightDefaults class >> textColorForShoutProperty: aShoutProperty [
	^ TextColor color:
		(((SHTextStylerST80 new attributesFor: aShoutProperty)
			detect: [:each | each respondsTo: #color]
			ifNone: [^ nil]) color)
]
