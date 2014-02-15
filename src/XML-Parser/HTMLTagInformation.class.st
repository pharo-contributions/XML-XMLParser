"
This class is used by the HTMLElementNester to store information about specific tags and make it faster to lookup.
"
Class {
	#name : #HTMLTagInformation,
	#superclass : #Object,
	#instVars : [
		'name',
		'isBodySectionTag',
		'isHeadSectionTag',
		'isNonNestable',
		'isSelfClosing',
		'mutuallyExcludingTag',
		'nestableTagGroup'
	],
	#category : #'XML-Parser-HTML'
}

{ #category : #'instance creation' }
HTMLTagInformation class >> named: aName [
	^ self new name: aName
]

{ #category : #testing }
HTMLTagInformation >> isBodySectionOnlyTag [
	^ self isBodySectionTag and: [self isHeadSectionTag not]
]

{ #category : #testing }
HTMLTagInformation >> isBodySectionTag [
	^ isBodySectionTag ifNil: [isBodySectionTag := false]
]

{ #category : #accessing }
HTMLTagInformation >> isBodySectionTag: aBoolean [
	isBodySectionTag := aBoolean
]

{ #category : #testing }
HTMLTagInformation >> isHeadOrBodyTag [
	^ name = 'body' or: [name = 'head']
]

{ #category : #testing }
HTMLTagInformation >> isHeadSectionOnlyTag [
	^ self isHeadSectionTag and: [self isBodySectionTag not]
]

{ #category : #testing }
HTMLTagInformation >> isHeadSectionTag [
	^ isHeadSectionTag ifNil: [isHeadSectionTag := false]
]

{ #category : #accessing }
HTMLTagInformation >> isHeadSectionTag: aBoolean [
	isHeadSectionTag := aBoolean
]

{ #category : #testing }
HTMLTagInformation >> isNonNestable [
	^ isNonNestable ifNil: [isNonNestable := false]
]

{ #category : #accessing }
HTMLTagInformation >> isNonNestable: aBoolean [
	isNonNestable := aBoolean
]

{ #category : #testing }
HTMLTagInformation >> isSelfClosing [
	^ isSelfClosing ifNil: [isSelfClosing := false]
]

{ #category : #accessing }
HTMLTagInformation >> isSelfClosing: aBoolean [
	isSelfClosing := aBoolean
]

{ #category : #accessing }
HTMLTagInformation >> mutuallyExcludingTag [
	^ mutuallyExcludingTag
]

{ #category : #accessing }
HTMLTagInformation >> mutuallyExcludingTag: aName [
	mutuallyExcludingTag := aName
]

{ #category : #accessing }
HTMLTagInformation >> name [
	^ name
]

{ #category : #accessing }
HTMLTagInformation >> name: aName [
	name := aName
]

{ #category : #accessing }
HTMLTagInformation >> nestableTagGroup [
	^ nestableTagGroup ifNil: [nestableTagGroup := #()]
]

{ #category : #accessing }
HTMLTagInformation >> nestableTagGroup: aNameCollection [
	nestableTagGroup := aNameCollection
]
