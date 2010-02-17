Class {
	#name : #XMLNode,
	#superclass : #Object,
	#instVars : [
		'parent'
	],
	#classVars : [
		'CanonicalTable'
	],
	#category : #'XML-Parser'
}

{ #category : #accessing }
XMLNode >> addContent: contentString [
	SAXParseException signal: 'Illegal string data.'
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
XMLNode >> isPi [
	^ self isProcessingInstruction
]

{ #category : #testing }
XMLNode >> isProcessingInstruction [
	^false
]

{ #category : #testing }
XMLNode >> isTag [
	^false
]

{ #category : #testing }
XMLNode >> isTagOrText [

	^ self isTag or: [self isText]
]

{ #category : #testing }
XMLNode >> isText [
	^false
]

{ #category : #accessing }
XMLNode >> parent [

	^ parent
]

{ #category : #accessing }
XMLNode >> parent: aParentNode [

	parent := aParentNode
]

{ #category : #printing }
XMLNode >> printOn: stream [
	self printXMLOn: (XMLWriter on: stream)
]

{ #category : #printing }
XMLNode >> printXMLOn: writer [
	self subclassResponsibility
]
