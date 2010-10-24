"
This is a base class for XML nodes. It contains testing messages and methods to set and access the parent node.
"
Class {
	#name : #XMLNode,
	#superclass : #Object,
	#traits : 'TXMLObservable',
	#classTraits : 'TXMLObservable classTrait',
	#instVars : [
		'parent',
		'notifier'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #accessing }
XMLNode >> addContent: aStringOrStringNode [
	XMLDOMException signal: 'Node cannot contain content'
]

{ #category : #accessing }
XMLNode >> characterData [
	self deprecated: 'use #contentString instead'.

	^ self contentString.
]

{ #category : #accessing }
XMLNode >> contentString [
	| stream |

	stream := WriteStream on: (String new: 128).
	self printContentOn: stream.
	^ stream contents.
]

{ #category : #testing }
XMLNode >> hasChildren [
	^ false
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
XMLNode >> isCData [
	^ false
]

{ #category : #testing }
XMLNode >> isComment [
	^ false
]

{ #category : #testing }
XMLNode >> isContentNode [
	^ false
]

{ #category : #testing }
XMLNode >> isDocument [
	^ false
]

{ #category : #testing }
XMLNode >> isElement [
	^ false
]

{ #category : #testing }
XMLNode >> isEmpty [
	self deprecated: 'use "hasChildren not" instead'.

	^ self hasChildren not
]

{ #category : #testing }
XMLNode >> isPI [
	^ false
]

{ #category : #testing }
XMLNode >> isProcessingInstruction [
	self deprecated: 'use #isPI instead'.

	^ self isPI.
]

{ #category : #testing }
XMLNode >> isStringNode [
	^ false
]

{ #category : #testing }
XMLNode >> isTag [
	self deprecated: 'use #isElement instead'.

	^ self isElement.
]

{ #category : #testing }
XMLNode >> isTagOrText [
	self deprecated: 'use #isContentNode instead'.

	^ self isContentNode.
]

{ #category : #testing }
XMLNode >> isText [
	self deprecated: 'use #isStringNode instead'.

	^ self isStringNode.
]

{ #category : #accessing }
XMLNode >> nextNode [
	^ self hasParent ifTrue: [self parent nodeAfter: self]
]

{ #category : #testing }
XMLNode >> notEmpty [
	self deprecated: 'use #hasChildren instead'.

	^ self hasChildren.
]

{ #category : #accessing }
XMLNode >> notifier [
	^ notifier ifNil: [notifier := XMLNotifier new]
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
XMLNode >> printContentOn: aStream [
]

{ #category : #printing }
XMLNode >> printOn: aStream [
	| writer |

	writer := XMLWriter on: aStream.
	self printXMLOn: writer.
	writer flushMarkup.
]

{ #category : #printing }
XMLNode >> printXMLOn: aWriter [
	self subclassResponsibility
]
