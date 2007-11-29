Class {
	#name : #XMLNodeWithElements,
	#superclass : #XMLNode,
	#instVars : [
		'elementsAndContents',
		'uri',
		'namespace',
		'parent'
	],
	#category : #'XML-Parser'
}

{ #category : #accessing }
XMLNodeWithElements >> addElement: element [
	self elementsAndContents add: element
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
	elementsAndContents
		ifNil: [^aBlock value].
	^self elements detect: [:each | each isProcessingInstruction not and: [each name = entityName or: [each localName = entityName]]] ifNone: [^aBlock value]
]

{ #category : #accessing }
XMLNodeWithElements >> elementUnqualifiedAt: entityName [
	^self elementUnqualifiedAt: entityName ifAbsent: [nil]
]

{ #category : #accessing }
XMLNodeWithElements >> elementUnqualifiedAt: entityName ifAbsent: aBlock [
	elementsAndContents
		ifNil: [^aBlock value].
	^self elements detect: [:each | each localName = entityName] ifNone: [^aBlock value]
]

{ #category : #accessing }
XMLNodeWithElements >> elements [
	^self elementsAndContents
]

{ #category : #accessing }
XMLNodeWithElements >> elementsAndContents [
	elementsAndContents ifNil: [elementsAndContents := OrderedCollection new].
	^elementsAndContents
]

{ #category : #enumerating }
XMLNodeWithElements >> elementsDo: aBlock [
	self elements do: [:each | aBlock value: each]
]

{ #category : #'name space' }
XMLNodeWithElements >> namespace [
	^ namespace
]

{ #category : #'name space' }
XMLNodeWithElements >> namespace: ns uri: u [
	namespace := ns.
	uri := u
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
