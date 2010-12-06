"
This class represents an ordered list of attribute nodes that also keeps a dictionary mapping attribute names to nodes for faster lookups. You usually shouldn't have to use this class directly.
"
Class {
	#name : #XMLAttributeList,
	#superclass : #XMLObservableList,
	#instVars : [
		'attributesByName'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #adding }
XMLAttributeList >> addName: aName value: aValue [
	^ self addLast:
		(XMLAttribute
			name: aName
			value: aValue)
]

{ #category : #private }
XMLAttributeList >> afterAdding: anObject [
	anObject addObserver: self.
	self attributesByName
		at: anObject name ifPresent: [self removeAttributeNodeAt: anObject name];
		at: anObject name put: anObject.

	self notifyOf: #addedAttribute: with: anObject.
]

{ #category : #private }
XMLAttributeList >> afterRemoving: anAttribute [
	anAttribute removeObserver: self.
	self attributesByName removeKey: anAttribute name.
	self notifyOf: #removedAttribute: with: anAttribute.
]

{ #category : #converting }
XMLAttributeList >> asDictionary [
	^ (OrderPreservingDictionary newFrom: self asNameValueAssociations) defaultValue: ''
]

{ #category : #converting }
XMLAttributeList >> asNameValueAssociations [
	^ self collect: [:each | each name -> each value]
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
XMLAttributeList >> attributeNodeAt: aLocalName namespaceURI: aUri [
	^ self attributeNodeAt: aLocalName namespaceURI: aUri ifAbsent: [self defaultValue]
]

{ #category : #accessing }
XMLAttributeList >> attributeNodeAt: aLocalName namespaceURI: aUri ifAbsent: aBlock [
	^ self
		detect: [:each | (each isNamed: aLocalName) and: [each namespaceURI = aUri]]
		ifNone: aBlock
]

{ #category : #accessing }
XMLAttributeList >> attributeValueAt: aName [
	^ self attributeValueAt: aName ifAbsent: [self defaultValue]
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
	^ attributesByName ifNil: [attributesByName := Dictionary new]
]

{ #category : #private }
XMLAttributeList >> beforeAdding: anObject [
	anObject element
		ifNotNil: [XMLDOMException signal: 'Cannot add attribute node from other element']
]

{ #category : #testing }
XMLAttributeList >> includesAttribute: aName [
	^ self attributesByName includesKey: aName
]

{ #category : #accessing }
XMLAttributeList >> removeAttributeNodeAt: aName [
	^ self remove: (self attributeNodeAt: aName).
]

{ #category : #notifications }
XMLAttributeList >> renamedAttribute: anAttribute from: anOldName to: aNewName [
	self attributesByName
		removeKey: anOldName;
		at: aNewName put: anAttribute
]
