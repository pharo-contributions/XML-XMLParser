Class {
	#name : #XMLNodeWithElements,
	#superclass : #XMLNode,
	#instVars : [
		'elements',
		'uri',
		'namespace'
	],
	#category : #'XML-Parser'
}

{ #category : #accessing }
XMLNodeWithElements >> addElement: element [
	self elements add: element
]

{ #category : #accessing }
XMLNodeWithElements >> addEntity: entityName value: entityValue [
	self entities add: entityName->entityValue
]

{ #category : #accessing }
XMLNodeWithElements >> elementAt: entityName [
	^self elementAt: entityName ifAbsent: [nil]
]

{ #category : #accessing }
XMLNodeWithElements >> elementAt: entityName ifAbsent: aBlock [
	elements
		ifNil: [^aBlock value].
	^self elements detect: [:each | each name = entityName or: [each localName = entityName]] ifNone: [^aBlock value]
]

{ #category : #accessing }
XMLNodeWithElements >> elementUnqualifiedAt: entityName [
	^self elementUnqualifiedAt: entityName ifAbsent: [nil]
]

{ #category : #accessing }
XMLNodeWithElements >> elementUnqualifiedAt: entityName ifAbsent: aBlock [
	elements
		ifNil: [^aBlock value].
	^self elements detect: [:each | each localName = entityName] ifNone: [^aBlock value]
]

{ #category : #accessing }
XMLNodeWithElements >> elements [
	elements ifNil: [elements _ OrderedCollection new].
	^elements
]

{ #category : #enumerating }
XMLNodeWithElements >> elementsDo: aBlock [
	elements
		ifNotNil: [
			self elements do: [:each | aBlock value: each]]
]

{ #category : #'name space' }
XMLNodeWithElements >> namespace [
	^ namespace
]

{ #category : #'name space' }
XMLNodeWithElements >> namespace: ns uri: u [
	namespace _ ns.
	uri _ u
]

{ #category : #'name space' }
XMLNodeWithElements >> namespaceURI [
	^ uri
]

{ #category : #printing }
XMLNodeWithElements >> printXMLOn: writer [
	self elementsDo: [:element | element printXMLOn: writer]
]

{ #category : #accessing }
XMLNodeWithElements >> topElement [
	^self elements first
]
