"
The class represents an attribute node, to be stored in an XMLAttributeList. You should seldom need to interact with these objects directly; XMLElement's various #attribute- messages will usually suffice.

The name of an XMLAttribute can be namespaced using prefixes; however, the prefix must be mapped to a namespace in the parent XMLElement.
"
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
	^ self new setName: aName value: aValue
]

{ #category : #accessing }
XMLAttribute >> expandedName [
	^ self nodeName expandedWith: self namespaceURI
]

{ #category : #testing }
XMLAttribute >> hasPrefix [
	^ self nodeName hasPrefix
]

{ #category : #testing }
XMLAttribute >> isAttribute [
	^ true
]

{ #category : #accessing }
XMLAttribute >> localName [
	^ self nodeName localName
]

{ #category : #accessing }
XMLAttribute >> name [
	^ self nodeName asString
]

{ #category : #accessing }
XMLAttribute >> name: aName [
	self notifyParentAfterRenamingWith: [self nodeName name: aName]
]

{ #category : #accessing }
XMLAttribute >> namespaceURI [
	^ self hasParent ifTrue: [self parent resolvePrefix: self prefix]
]

{ #category : #private }
XMLAttribute >> nodeName [
	^ name ifNil: [name := XMLNodeName new]
]

{ #category : #accessing }
XMLAttribute >> prefix [
	^ self nodeName prefix
]

{ #category : #accessing }
XMLAttribute >> prefix: aPrefix [
	self notifyParentAfterRenamingWith: [self nodeName prefix: aPrefix]
]

{ #category : #printing }
XMLAttribute >> printXMLOn: aWriter [
	aWriter attribute: self name value: self value
	
]

{ #category : #accessing }
XMLAttribute >> qualifiedName [
	^ self nodeName qualifiedName
]

{ #category : #initialization }
XMLAttribute >> setName: aName value: aValue [
	self nodeName name: aName.
	value := aValue.
]

{ #category : #accessing }
XMLAttribute >> value [
	^ value
]

{ #category : #accessing }
XMLAttribute >> value: aString [
	value := aString
]
