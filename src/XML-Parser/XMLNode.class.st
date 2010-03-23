"
This is a base class for XML nodes. It contains testing messages and methods to set and access the parent node.
"
Class {
	#name : #XMLNode,
	#superclass : #Object,
	#instVars : [
		'parent'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #errors }
XMLNode >> domError: aMessage [
	^ XMLDOMException signal: aMessage
]

{ #category : #testing }
XMLNode >> hasParent [
	^ self parent notNil
]

{ #category : #testing }
XMLNode >> isAttribute [
	^ false
]

{ #category : #testing }
XMLNode >> isDocument [
	^ false
]

{ #category : #testing }
XMLNode >> isElement [
	^ self isTag
]

{ #category : #testing }
XMLNode >> isEmpty [
	^ true
]

{ #category : #testing }
XMLNode >> isPI [
	^ self isProcessingInstruction
]

{ #category : #testing }
XMLNode >> isProcessingInstruction [
	^ false
]

{ #category : #testing }
XMLNode >> isTag [
	^ false
]

{ #category : #testing }
XMLNode >> isTagOrText [
	^ self isTag or: [self isText]
]

{ #category : #testing }
XMLNode >> isText [
	^ false
]

{ #category : #accessing }
XMLNode >> nextNode [
	^ self hasParent ifTrue: [self parent nodeAfter: self]
]

{ #category : #testing }
XMLNode >> notEmpty [
	^ self isEmpty not
]

{ #category : #private }
XMLNode >> notifyParentAfterRenamingWith: aBlock [
	| oldName newName |

	oldName := self name.
	aBlock value.
	newName := self name.
	self hasParent
		ifTrue: [self parent nodeRenamed: self from: oldName to: newName]
]

{ #category : #accessing }
XMLNode >> parent [
	^ parent
]

{ #category : #accessing }
XMLNode >> parent: aParentNode [
	parent := aParentNode
]

{ #category : #accessing }
XMLNode >> previousNode [
	^ self hasParent ifTrue: [self parent nodeBefore: self]
]

{ #category : #printing }
XMLNode >> printOn: stream [
	self printXMLOn: (XMLWriter on: stream)
]

{ #category : #printing }
XMLNode >> printXMLOn: writer [
	self subclassResponsibility
]
