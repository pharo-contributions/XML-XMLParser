"
This class represents an ordered list of attribute nodes that also keeps a dictionary mapping attribute names to nodes for faster lookups. You are unlikely to need to use this class directly.
"
Class {
	#name : #XMLAttributeList,
	#superclass : #XMLObservableList,
	#traits : 'TXMLObserver',
	#classTraits : 'TXMLObserver classTrait',
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
XMLAttributeList >> added: anObject [
	self startObserving: anObject.
	self attributesByName
		at: anObject name ifPresent: [self removeAttributeNamed: anObject name];
		at: anObject name put: anObject..

	self notifyOf: #addedAttribute: with: anObject
]

{ #category : #private }
XMLAttributeList >> adding: anObject [
	anObject hasParent ifFalse: [^ self].

	XMLDOMException signal: 'Cannot add attribute node that already has a parent'.
]

{ #category : #converting }
XMLAttributeList >> asDictionary [
	^ XMLOrderPreservingDictionary newFrom: self asNameValueAssociations
]

{ #category : #converting }
XMLAttributeList >> asNameValueAssociations [
	^ self collect: [:each | each name -> each value]
]

{ #category : #accessing }
XMLAttributeList >> attributeNamed: aName [
	^ self attributeNamed: aName ifAbsent: [self defaultValue]
]

{ #category : #accessing }
XMLAttributeList >> attributeNamed: aName ifAbsent: aBlock [
	^ self attributesByName at: aName ifAbsent: aBlock
]

{ #category : #accessing }
XMLAttributeList >> attributeNamed: aLocalName namespaceURI: aUri [
	^ self attributeNamed: aLocalName namespaceURI: aUri ifAbsent: [self defaultValue]
]

{ #category : #accessing }
XMLAttributeList >> attributeNamed: aLocalName namespaceURI: aUri ifAbsent: aBlock [
	^ self
		detect: [:each | (each isNamed: aLocalName) and: [each namespaceURI = aUri]]
		ifNone: aBlock
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
	(self includesAttributeNamed: aName)
		ifTrue: [(self attributeNamed: aName) value: aValue]
		ifFalse: [self addName: aName value: aValue].
	^ aValue.
]

{ #category : #private }
XMLAttributeList >> attributesByName [
	^ attributesByName ifNil: [attributesByName := Dictionary new]
]

{ #category : #testing }
XMLAttributeList >> includesAttributeNamed: aName [
	^ self attributesByName includesKey: aName
]

{ #category : #accessing }
XMLAttributeList >> removeAttributeNamed: aName [
	^ self remove: (self attributeNamed: aName).
]

{ #category : #private }
XMLAttributeList >> removed: anAttribute [
	self stopObserving: anAttribute.
	self attributesByName removeKey: anAttribute name.
	self notifyOf: #removedAttribute: with: anAttribute.
]

{ #category : #notifications }
XMLAttributeList >> renamedAttribute: anAttribute from: anOldName to: aNewName [
	self attributesByName
		removeKey: anOldName;
		at: aNewName put: anAttribute
]
