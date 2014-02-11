"
The class represents an attribute node, to be stored in an attribute node list. You generally won't need to interact with these objects directly; the various #attribute- messages element nodes respond to will normally suffice. The name of an attribute node can be namespaced using prefixes; however, the prefix must be mapped to a namespace URI in the containing element node. Unprefixed attributes have no namespace, not even a default namespace URI if one is in scope, per the XML namespace standard.
"
Class {
	#name : #XMLAttribute,
	#superclass : #XMLNode,
	#instVars : [
		'name',
		'value',
		'notifier'
	],
	#category : #'XML-Parser-DOM'
}

{ #category : #'instance creation' }
XMLAttribute class >> name: aName value: aValue [
	^ self new setName: aName value: aValue
]

{ #category : #accessing }
XMLAttribute >> element [
	^ parent
]

{ #category : #accessing }
XMLAttribute >> element: anElement [
	parent := anElement
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
	^ name
		ifNil: [ 
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

{ #category : #private }
XMLAttribute >> notifier [
	^ notifier ifNil: [notifier := XMLNotifier new]
]

{ #category : #accessing }
XMLAttribute >> prefix [
	^ self nodeName prefix
]

{ #category : #accessing }
XMLAttribute >> prefix: aPrefix [
	self nodeName prefix: aPrefix
]

{ #category : #initialization }
XMLAttribute >> setName: aName value: aValue [
	"This is used over 'self nodeName qualified:' to avoid sending a name-changed notification"
	(name := XMLNodeName new)
		setQualified: aName;
		addObserver: self.
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

{ #category : #printing }
XMLAttribute >> writeXMLOn: aWriter [
	aWriter
		writeName: self name
		escapedContentValue: self value
]
