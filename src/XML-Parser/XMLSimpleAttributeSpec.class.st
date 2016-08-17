"
A simple attribute spec that checks for attributes being present and optionally having a specific value.
"
Class {
	#name : #XMLSimpleAttributeSpec,
	#superclass : #XMLAttributeSpec,
	#instVars : [
		'attributes'
	],
	#category : #'XML-Parser-Utils'
}

{ #category : #'instance creation' }
XMLSimpleAttributeSpec class >> attributes: aDictionaryOrCollectionOfAssociationsAndStrings [
	^ self new setAttributes: aDictionaryOrCollectionOfAssociationsAndStrings
]

{ #category : #adding }
XMLSimpleAttributeSpec >> addAttribute: anAttribute [
	^ attributes
		at: anAttribute
		ifAbsentPut: [nil]
]

{ #category : #adding }
XMLSimpleAttributeSpec >> addAttributeAssociation: anAssociation [
	^ self
		addAttributeName: anAssociation key
		value: anAssociation value
]

{ #category : #adding }
XMLSimpleAttributeSpec >> addAttributeName: aName value: aValue [
	^ attributes
		at: aName
		put: aValue
]

{ #category : #initialization }
XMLSimpleAttributeSpec >> initialize [
	attributes := Dictionary new
]

{ #category : #matching }
XMLSimpleAttributeSpec >> matchesAttributes: aDictionary [
	attributes keysAndValuesDo: [:key :value |
		"nil values only mean that the attribute has to present and
		can have any value"
		value
			ifNil: [
				(aDictionary includesKey: key)
					ifFalse: [^ false]]
			ifNotNil: [
				(aDictionary at: key ifAbsent: [nil]) = value
					ifFalse: [^ false]]].
	^ true.
]

{ #category : #initialization }
XMLSimpleAttributeSpec >> setAttributes: aDictionaryOrCollectionOfAssociationsAndStrings [
	attributes removeAll.

	"associationsDo: works for dictionaries and non-dictionaries, including
	arrays, to support specs like {'one'. 'two'->'three'}"
	aDictionaryOrCollectionOfAssociationsAndStrings associationsDo: [:each |
		each isString
			ifTrue: [self addAttribute: each]
			ifFalse: [self addAttributeAssociation: each]].
]
