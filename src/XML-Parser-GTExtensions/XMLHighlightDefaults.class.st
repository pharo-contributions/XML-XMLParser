"
This is a base class for storing the default highlight TextColors used by a highlighter. It gets the initial defaults from Shout text styling.
"
Class {
	#name : #XMLHighlightDefaults,
	#superclass : #Object,
	#classInstVars : [
		'defaultDefaultColor'
	],
	#category : #'XML-Parser-GTExtensions-Highlighting'
}

{ #category : #accessing }
XMLHighlightDefaults class >> defaultDefaultColor [
	^ defaultDefaultColor
		ifNil: [defaultDefaultColor := self textColorForShoutProperty: #default]
]

{ #category : #accessing }
XMLHighlightDefaults class >> defaultDefaultColor: aTextColor [
	defaultDefaultColor := aTextColor
]

{ #category : #private }
XMLHighlightDefaults class >> textColorForShoutProperty: aShoutProperty [
	^ TextColor color:
		(((SHTextStylerST80 new attributesFor: aShoutProperty)
			detect: [:each | each respondsTo: #color]
			ifNone: [^ nil]) color)
]
