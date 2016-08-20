"
A simple attribute spec that checks for attributes being present and optionally having a specific value.
"
Class {
	#name : #XMLSimpleAttributeSpec,
	#superclass : #XMLAttributeSpec,
	#instVars : [
		'attributeSpec'
	],
	#category : #'XML-Parser-Utils'
}

{ #category : #'instance creation' }
XMLSimpleAttributeSpec class >> attributes: aDictionaryOrCollectionOfAssociationsAndStrings [
	^ self new setAttributes: aDictionaryOrCollectionOfAssociationsAndStrings
]

{ #category : #adding }
XMLSimpleAttributeSpec >> addAttribute: anAttribute [
	^ attributeSpec
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
	^ attributeSpec
		at: aName
		put: aValue
]

{ #category : #initialization }
XMLSimpleAttributeSpec >> initialize [
	attributeSpec := Dictionary new
]

{ #category : #matching }
XMLSimpleAttributeSpec >> matchesAttributes: aDictionary [
	attributeSpec keysAndValuesDo: [:specName :specValue |
		specValue
			ifNil: [
				"nil values only mean that the attribute has to present and
				can have any value"
				(aDictionary includesKey: specName)
					ifFalse: [^ false]]
			ifNotNil: [
				(specValue isBlock
					ifTrue: [specValue value: (aDictionary at: specName ifAbsent: [^ false])]
					ifFalse: [specValue = (aDictionary at: specName ifAbsent: [^ false])])
							ifFalse: [^ false]]].
	^ true.
]

{ #category : #initialization }
XMLSimpleAttributeSpec >> setAttributes: aDictionaryOrCollectionOfAssociationsAndStrings [
	attributeSpec removeAll.

	"associationsDo: works for dictionaries and non-dictionaries, including
	arrays, to support specs like {'one'. 'two'->'three'}"
	aDictionaryOrCollectionOfAssociationsAndStrings associationsDo: [:each |
		each isString
			ifTrue: [self addAttribute: each]
			ifFalse: [self addAttributeAssociation: each]].
]
