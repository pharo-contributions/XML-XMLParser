Class {
	#name : #XMLAttribute,
	#superclass : #XMLNode,
	#instVars : [
		'name',
		'value'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #'instance creation' }
XMLAttribute class >> name: aName value: aValue [
	^ self name: aName value: aValue scope: nil.
]

{ #category : #'instance creation' }
XMLAttribute class >> name: aName value: aValue scope: aScope [
	^ self new
		setScope: aScope;
		name: aName value: aValue
]

{ #category : #testing }
XMLAttribute >> isAttribute [
	^ true
]

{ #category : #accessing }
XMLAttribute >> localName [
	^ self namespacedName localName
]

{ #category : #accessing }
XMLAttribute >> localName: aLocalName [
	self namespacedName localName: aLocalName
]

{ #category : #accessing }
XMLAttribute >> name [
	^ self qualifiedName
]

{ #category : #accessing }
XMLAttribute >> name: aQualifiedName [
	self qualifiedName: aQualifiedName
]

{ #category : #accessing }
XMLAttribute >> name: aName value: aValue [
	self qualifiedName: aName.
	value := aValue.
]

{ #category : #accessing }
XMLAttribute >> namespace [
	^ self namespacedName namespace
]

{ #category : #accessing }
XMLAttribute >> namespaceURI [
	^ self namespacedName namespaceURI
]

{ #category : #private }
XMLAttribute >> namespacedName [
	^ name ifNil: [name := XMLNamespacedName new]
]

{ #category : #accessing }
XMLAttribute >> prefix [
	^ self namespacedName prefix
]

{ #category : #accessing }
XMLAttribute >> prefix: aPrefix [
	self namespacedName prefix: aPrefix
]

{ #category : #printing }
XMLAttribute >> printXMLOn: aWriter [
	aWriter attribute: self name value: self value
	
]

{ #category : #accessing }
XMLAttribute >> qualifiedName [
	^ self namespacedName qualifiedName
]

{ #category : #accessing }
XMLAttribute >> qualifiedName: aQualifiedName [
	self namespacedName qualifiedName: aQualifiedName
]

{ #category : #private }
XMLAttribute >> setScope: aScope [
	self namespacedName setScope: aScope
]

{ #category : #accessing }
XMLAttribute >> value [
	^ value
]

{ #category : #accessing }
XMLAttribute >> value: aString [
	value := aString
]
