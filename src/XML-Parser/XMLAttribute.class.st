"
The class represents an attribute node, to be stored in an attribute node list. You generally won't need to interact with these objects directly; the various #attribute- messages element nodes respond to will normally suffice. The name of an attribute node can be namespaced using prefixes; however, the prefix must be mapped to a namespace URI in the containing element node. Unprefixed attributes have no namespace, not even a default namespace URI if one is in scope, per the XML namespace standard.
"
Class {
	#name : #XMLAttribute,
	#superclass : #XMLNode,
	#instVars : [
		'name',
		'value'
	],
	#category : #'XML-Parser-DOM'
}

{ #category : #'instance creation' }
XMLAttribute class >> name: aName value: aValue [
	^ self new	
		setName: aName
		value: aValue
		element: nil
]

{ #category : #accessing }
XMLAttribute >> element [
	"reuse instance variable to save memory"
	^ parent
]

{ #category : #accessing }
XMLAttribute >> element: anElement [
	"reuse instance variable to save memory"
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
	self renameWith: [self nodeName qualified: aName]
]

{ #category : #accessing }
XMLAttribute >> namespaceURI [
	(self element notNil and: [self hasPrefix])
		ifFalse: [^ ''].
	
	^ self element resolvePrefix: self prefix.
]

{ #category : #private }
XMLAttribute >> nodeName [
	^ name ifNil: [name := XMLNodeName new]
]

{ #category : #accessing }
XMLAttribute >> parent [
	"attributes have no parents and aren't part of the DOM tree"
	self shouldNotImplement
]

{ #category : #accessing }
XMLAttribute >> parent: anObject [
	"attributes have no parents and aren't part of the DOM tree"
	self shouldNotImplement
]

{ #category : #copying }
XMLAttribute >> postCopy [
	super postCopy.

	name := name copy.
]

{ #category : #accessing }
XMLAttribute >> prefix [
	^ self nodeName prefix
]

{ #category : #accessing }
XMLAttribute >> prefix: aPrefix [
	self renameWith: [self nodeName prefix: aPrefix]
]

{ #category : #private }
XMLAttribute >> renameWith: aBlock [
	| oldName |

	oldName := self name.
	aBlock value.
	(self name ~= oldName
		and: [self element notNil])
			ifTrue: [
				self element
					renamedAttribute: self
					from: oldName
					to: self name].
]

{ #category : #initialization }
XMLAttribute >> setName: aName value: aValue element: anElement [
	name := XMLNodeName qualified: aName.
	value := aValue.
	parent := anElement.
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
