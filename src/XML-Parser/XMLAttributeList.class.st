"
This class represents an ordered list of attribute nodes that also keeps a dictionary mapping attribute names to nodes for faster lookup.
"
Class {
	#name : #XMLAttributeList,
	#superclass : #XMLObservableList,
	#instVars : [
		'attributeNodesByName'
	],
	#category : #'XML-Parser-DOM'
}

{ #category : #'instance creation' }
XMLAttributeList class >> new [
	^ self new: 5
]

{ #category : #adding }
XMLAttributeList >> addAttributeAssociation: anAssociation [
	^ self
		addAttributeName: anAssociation key
		value: anAssociation value
]

{ #category : #adding }
XMLAttributeList >> addAttributeName: aName value: aValue [
	^ self addLast:
		(self attributeClass
			name: aName
			value: aValue)
]

{ #category : #private }
XMLAttributeList >> afterAdding: aNode at: anIndex [
	self attributeNodesByName
		at: aNode name ifPresent: [:oldNode |
			self
				replaced: oldNode
				with: aNode 
				at: anIndex];
		at: aNode name put: aNode.
	observer ifNotNil: [observer addedAttribute: aNode].
]

{ #category : #private }
XMLAttributeList >> afterAddingLast: aNode [
	self attributeNodesByName
		at: aNode name ifPresent: [:oldNode |
			self
				replaced: oldNode
				with: aNode 
				at: self size];
		at: aNode name put: aNode.
	observer ifNotNil: [observer addedAttribute: aNode].
]

{ #category : #private }
XMLAttributeList >> afterRemoving: aNode [
	self attributeNodesByName removeKey: aNode name.
	observer ifNotNil: [observer removedAttribute: aNode].
]

{ #category : #converting }
XMLAttributeList >> asDictionary [
	^ self attributes
]

{ #category : #accessing }
XMLAttributeList >> attributeAssociations [
	^ self collect: [:each | each name -> each value]
]

{ #category : #accessing }
XMLAttributeList >> attributeAt: aName [
	^ self attributeValueAt: aName
]

{ #category : #accessing }
XMLAttributeList >> attributeAt: aName ifAbsent: aBlock [
	^ self
		attributeValueAt: aName
		ifAbsent: aBlock
]

{ #category : #accessing }
XMLAttributeList >> attributeAt: aName ifAbsentPut: aBlock [
	^ self
		attributeValueAt: aName
		ifAbsentPut: aBlock
]

{ #category : #accessing }
XMLAttributeList >> attributeAt: aName put: aValue [
	^ self
		attributeValueAt: aName
		put: aValue
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
	self do: [:each |
		aTwoArgumentBlock
			value: each name
			value: each value]
]

{ #category : #enumerating }
XMLAttributeList >> attributeNamesDo: aBlock [
	self do: [:each | aBlock value: each name]
]

{ #category : #accessing }
XMLAttributeList >> attributeNodeAt: aName [
	^ self
		attributeNodeAt: aName
		ifAbsent: [self defaultValue]
]

{ #category : #accessing }
XMLAttributeList >> attributeNodeAt: aName ifAbsent: aBlock [
	self do: [:each |
		(each isNamed: aName)
			ifTrue: [^ each]].
	^ aBlock value.
]

{ #category : #accessing }
XMLAttributeList >> attributeNodeAt: aName namespaceURI: aURI [
	^ self
		attributeNodeAt: aName
		namespaceURI: aURI
		ifAbsent: [self defaultValue]
]

{ #category : #accessing }
XMLAttributeList >> attributeNodeAt: aName namespaceURI: aURI ifAbsent: aBlock [
	self do: [:each |
		((each isNamed: aName)
			and: [each namespaceURI = aURI])
			ifTrue: [^ each]].
	^ aBlock value.
]

{ #category : #private }
XMLAttributeList >> attributeNodesByName [
	^ attributeNodesByName
		ifNil: [attributeNodesByName := Dictionary new: self capacity]
]

{ #category : #private }
XMLAttributeList >> attributeValueAt: aName [
	^ self
		attributeValueAt: aName
		ifAbsent: ['']
]

{ #category : #private }
XMLAttributeList >> attributeValueAt: aName ifAbsent: aBlock [
	^ (self attributeNodesByName
		at: aName
		ifAbsent: [^ aBlock value]) value
]

{ #category : #private }
XMLAttributeList >> attributeValueAt: aName ifAbsentPut: aBlock [
	^ self
		attributeValueAt: aName
		ifAbsent: [
			self
				attributeValueAt: aName
				put: aBlock value]
]

{ #category : #private }
XMLAttributeList >> attributeValueAt: aName put: aValue [
	(self includesAttribute: aName)
		ifTrue: [(self attributeNodeAt: aName) value: aValue]
		ifFalse: [self addAttributeName: aName value: aValue].
	^ aValue.
]

{ #category : #accessing }
XMLAttributeList >> attributes [
	| dictionary |

	dictionary := OrderPreservingStringDictionary new: self size.
	self do: [:each |
		dictionary
			at: each name
			put: each value].
	^ dictionary.
]

{ #category : #private }
XMLAttributeList >> beforeAdding: aNode [
	observer ifNotNil: [observer addingAttribute: aNode]
]

{ #category : #testing }
XMLAttributeList >> includes: aNode [
	^ aNode isAttribute
		and: [
			(self attributeNodesByName
				at: aNode name
				ifAbsent: [^ false]) = aNode]
]

{ #category : #testing }
XMLAttributeList >> includesAttribute: aName [
	^ self attributeNodesByName includesKey: aName
]

{ #category : #testing }
XMLAttributeList >> includesAttributeNode: aName [
	self
		attributeNodeAt: aName
		ifAbsent: [^ false].
	^ true.
]

{ #category : #testing }
XMLAttributeList >> includesAttributeNode: aName namespaceURI: aURI [
	self
		attributeNodeAt: aName
		namespaceURI: aURI
		ifAbsent: [^ false].
	^ true.
]

{ #category : #removing }
XMLAttributeList >> removeAttribute: aName [
	^ (self remove: (self attributeNodesByName at: aName)) value
]

{ #category : #removing }
XMLAttributeList >> removeAttribute: aName ifAbsent: aBlock [
	^ (self remove:
		(self attributeNodesByName
			at: aName
			ifAbsent: [^ aBlock value])) value
]

{ #category : #notifying }
XMLAttributeList >> renamedAttribute: anAttributeNode from: anOldName to: aNewName [
	self attributeNodesByName
		removeKey: anOldName;
		at: aNewName ifPresent: [:attribute | self remove: attribute];
		at: aNewName put: anAttributeNode
]

{ #category : #initialization }
XMLAttributeList >> setAttributes: anAssociationCollection [
	self removeAll.
	anAssociationCollection associationsDo: [:each |
		self addAttributeAssociation: each].
]

{ #category : #private }
XMLAttributeList >> setWithOrderPreservingDictionary: anOrderPreservingDictionary [
	"hack to reuse a dictionary for speed"
	attributeNodesByName := anOrderPreservingDictionary dictionary.

	"add the XMLAttributes in order directly to the collection
	to avoid sending notifications and also replace the value in
	the attributesByName association with the XMLAttribute"
	anOrderPreservingDictionary keysDo: [:each | | association |
		(association := attributeNodesByName associationAt: each ifAbsent: nil)
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
XMLAttributeList >> writeAttributesOn: aWriter [
	"use to:do: for speed"
	1 to: collection size do: [:i | | attribute |
		attribute := collection at: i.
		aWriter
			writeAttributeName: attribute name
			value: attribute value]
]

{ #category : #private }
XMLAttributeList >> writeSortedAttributesOn: aWriter [
	| sortedAttributes |

	sortedAttributes := self sorted.
	"use to:do: for speed"
	1 to: sortedAttributes size do: [:i | | attribute |
		attribute := sortedAttributes at: i.
		aWriter
			writeAttributeName: attribute name
			value: attribute value]
]
