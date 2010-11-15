"
The class represents an attribute node, to be stored in an XMLAttributeList. You generally won't need to interact with these objects directly; XMLElement's various #attribute- messages will normally suffice. The name of an attribute node can be namespaced using prefixes; however, the prefix must be mapped to a namespace URI in the containing element node. Unprefixed attributes have no namespace, not even the default one, per the XML namespaces standard.

Note that attribute nodes are not children of the elements that contain them; rather, they are considered to be ""part"" of the element, and this relationship is modeled using a separate instance variable (""element"") with different accessor messages.
"
Class {
	#name : #XMLAttribute,
	#superclass : #XMLNode,
	#instVars : [
		'element',
		'name',
		'value'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #'instance creation' }
XMLAttribute class >> name: aName value: aValue [
	^ self new
		name: aName;
		value: aValue
]

{ #category : #accessing }
XMLAttribute >> element [
	^ element
]

{ #category : #accessing }
XMLAttribute >> element: anElement [
	element := anElement
]

{ #category : #accessing }
XMLAttribute >> expandedName [
	^ self nodeName expandWith: self namespaceURI
]

{ #category : #testing }
XMLAttribute >> hasPrefix [
	^ self nodeName isPrefixed
]

{ #category : #testing }
XMLAttribute >> isAttribute [
	^ true
]

{ #category : #testing }
XMLAttribute >> isNamed: aName [
	^ self nodeName isSameAs: aName
]

{ #category : #accessing }
XMLAttribute >> localName [
	^ self nodeName localPart
]

{ #category : #accessing }
XMLAttribute >> name [
	^ self nodeName qualified
]

{ #category : #accessing }
XMLAttribute >> name: aName [
	self nodeName qualified: aName
]

{ #category : #accessing }
XMLAttribute >> namespaceURI [
	(self element notNil and: [self hasPrefix])
		ifFalse: [^ ''].
	
	^ self element resolvePrefix: self prefix.
]

{ #category : #private }
XMLAttribute >> nodeName [
	^ name ifNil: [
		(name := XMLNodeName new)
			addObserver: self;
			yourself]
]

{ #category : #notifications }
XMLAttribute >> nodeNameChangedFrom: anOldName to: aNewName [
	self
		notifyOf: #renamedAttribute:from:to:
		with: self
		with: anOldName
		with: aNewName
]

{ #category : #accessing }
XMLAttribute >> prefix [
	^ self nodeName prefix
]

{ #category : #accessing }
XMLAttribute >> prefix: aPrefix [
	self nodeName prefix: aPrefix
]

{ #category : #printing }
XMLAttribute >> printXMLOn: aWriter [
	aWriter writeName: self name value: self value
]

{ #category : #accessing }
XMLAttribute >> value [
	^ value ifNil: [value := '']
]

{ #category : #accessing }
XMLAttribute >> value: aString [
	value := aString
]
