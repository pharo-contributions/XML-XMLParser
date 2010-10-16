"
The class represents an attribute node, to be stored in an XMLAttributeList. You generally won't need to interact with these objects directly; XMLElement's various #attribute- messages will normally suffice. The name of an XMLAttribute can be namespaced using prefixes; however, the prefix must be mapped to a namespace URI in the parent XMLElement. Unprefixed attributes have no namespace, not even the default one, per the XML namespaces standard.
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
	self hasParent ifFalse: [^ ''].

	^ self parent resolvePrefix: self prefix.
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
XMLAttribute >> qualifiedName [
	^ self nodeName qualified
]

{ #category : #initialization }
XMLAttribute >> setName: aName value: aValue [
	self nodeName qualified: aName.
	value := aValue.
]

{ #category : #accessing }
XMLAttribute >> value [
	^ value ifNil: [value := '']
]

{ #category : #accessing }
XMLAttribute >> value: aString [
	value := aString
]
