"
This class represents an ordered list of attribute nodes that also keeps a dictionary mapping attribute names to nodes for faster lookup.
"
Class {
	#name : #XMLAttributeList,
	#superclass : #XMLObservableList,
	#instVars : [
		'attributesByName'
	],
	#category : #'XML-Parser-DOM'
}

{ #category : #'instance creation' }
XMLAttributeList class >> new [
	^ self new: 5
]

{ #category : #adding }
XMLAttributeList >> addName: aName value: aValue [
	^ self addLast:
		(self attributeClass
			name: aName
			value: aValue)
]

{ #category : #private }
XMLAttributeList >> afterAdding: anAttribute at: anIndex [
	self attributesByName
		at: anAttribute name
		ifPresent: [:oldAttribute |
			self
				replacedAttribute: oldAttribute
				withAttributeAt: anIndex];
		at: anAttribute name
		put: anAttribute.
	observer ifNotNil: [observer addedAttribute: anAttribute].
]

{ #category : #private }
XMLAttributeList >> afterAddingLast: anAttribute [
	self attributesByName
		at: anAttribute name
		ifPresent: [:oldAttribute |
			self
				replacedAttribute: oldAttribute
				withAttributeAt: self size];
		at: anAttribute name
		put: anAttribute.
	observer ifNotNil: [observer addedAttribute: anAttribute].
]

{ #category : #private }
XMLAttributeList >> afterRemoving: anAttribute [
	self attributesByName removeKey: anAttribute name.
	observer ifNotNil: [observer removedAttribute: anAttribute].
]

{ #category : #converting }
XMLAttributeList >> asDictionary [
	| dictionary |

	dictionary := OrderPreservingStringDictionary new: self size.
	self do: [:each | dictionary at: each name put: each value].
	^ dictionary.
]

{ #category : #accessing }
XMLAttributeList >> attributeAssociations [
	^ self collect: [:each | each name -> each value]
]

{ #category : #private }
XMLAttributeList >> attributeClass [
	^ XMLAttribute

]

{ #category : #accessing }
XMLAttributeList >> attributeNames [
	^ self collect: [:each | each name]
]

{ #category : #enumerating }
XMLAttributeList >> attributeNamesAndValuesDo: aTwoArgumentBlock [
	self do: [:each | aTwoArgumentBlock value: each name value: each value]
]

{ #category : #enumerating }
XMLAttributeList >> attributeNamesDo: aBlock [
	self do: [:each | aBlock value: each name]
]

{ #category : #accessing }
XMLAttributeList >> attributeNodeAt: aName [
	^ self attributeNodeAt: aName ifAbsent: [self defaultValue]
]

{ #category : #accessing }
XMLAttributeList >> attributeNodeAt: aName ifAbsent: aBlock [
	^ self attributesByName at: aName ifAbsent: aBlock
]

{ #category : #accessing }
XMLAttributeList >> attributeNodeAt: aLocalName namespaceURI: aURI [
	^ self
		attributeNodeAt: aLocalName
		namespaceURI: aURI
		ifAbsent: [self defaultValue]
]

{ #category : #accessing }
XMLAttributeList >> attributeNodeAt: aLocalName namespaceURI: aURI ifAbsent: aBlock [
	^ self
		detect: [:each |
			each name = aLocalName
				and: [each namespaceURI = aURI]]
		ifNone: aBlock
]

{ #category : #accessing }
XMLAttributeList >> attributeValueAt: aName [
	^ self attributeValueAt: aName ifAbsent: ['']
]

{ #category : #accessing }
XMLAttributeList >> attributeValueAt: aName ifAbsent: aBlock [
	^ (self attributesByName
		at: aName
		ifAbsent: [^ aBlock value]) value
]

{ #category : #accessing }
XMLAttributeList >> attributeValueAt: aName ifAbsentPut: aBlock [
	^ self
		attributeValueAt: aName
		ifAbsent: [self attributeValueAt: aName put: aBlock value]
]

{ #category : #accessing }
XMLAttributeList >> attributeValueAt: aName put: aValue [
	(self includesAttribute: aName)
		ifTrue: [(self attributeNodeAt: aName) value: aValue]
		ifFalse: [self addName: aName value: aValue].
	^ aValue.
]

{ #category : #private }
XMLAttributeList >> attributesByName [
	^ attributesByName ifNil: [attributesByName := Dictionary new: self capacity]
]

{ #category : #private }
XMLAttributeList >> beforeAdding: anAttribute [
	observer ifNotNil: [observer addingAttribute: anAttribute]
]

{ #category : #testing }
XMLAttributeList >> includes: aNode [
	^ aNode isAttribute
		and: [
			(self attributesByName
				at: aNode name
				ifAbsent: [^ false]) = aNode]
]

{ #category : #testing }
XMLAttributeList >> includesAttribute: aName [
	^ self attributesByName includesKey: aName
]

{ #category : #removing }
XMLAttributeList >> removeAttributeNodeAt: aName [
	^ self remove: (self attributeNodeAt: aName).
]

{ #category : #removing }
XMLAttributeList >> removeAttributeNodeAt: aName ifAbsent: aBlock [
	^ self remove:
		(self
			attributeNodeAt: aName
			ifAbsent: [^ aBlock value]).
]

{ #category : #notifying }
XMLAttributeList >> renamedAttribute: anAttribute from: anOldName to: aNewName [
	self attributesByName
		removeKey: anOldName;
		at: aNewName ifPresent: [:attribute | self remove: attribute];
		at: aNewName put: anAttribute
]

{ #category : #private }
XMLAttributeList >> replacedAttribute: anAttribute withAttributeAt: anIndex [
	| i |

	(i :=
		self
			indexOf: anAttribute
			otherThan: anIndex) > 0
		ifTrue: [self removeAt: i]
]

{ #category : #private }
XMLAttributeList >> setFromDictionary: anOrderPreservingDictionary [
	| association |

	"hack to reuse a dictionary for speed"
	attributesByName := anOrderPreservingDictionary dictionary.

	"add the XMLAttributes in order directly to the collection
	to avoid sending notifications and also replace the value in
	the attributesByName association with the XMLAttribute"
	anOrderPreservingDictionary keysDo: [:each |
		(association := attributesByName associationAt: each ifAbsent: nil)
			value:
				(collection addLast: 
					(self attributeClass new
						setName: each
						value: association value
						element: observer))].
]

{ #category : #sorting }
XMLAttributeList >> sort [
	self sort: [:a :b | a sortKey <= b sortKey]
]

{ #category : #private }
XMLAttributeList >> writeAttributesOn: aTagWriter [
	"use to:do: for speed"
	1 to: self size do: [:i | | attribute |
		attribute := self at: i.
		aTagWriter
			writeAttributeName: attribute name
			value: attribute value]
]

{ #category : #private }
XMLAttributeList >> writeSortedAttributesOn: aTagWriter [
	| sortedAttributes |

	sortedAttributes := self sorted.
	"use to:do: for speed"
	1 to: self size do: [:i | | attribute |
		attribute := sortedAttributes at: i.
		aTagWriter
			writeAttributeName: attribute name
			value: attribute value]
]
