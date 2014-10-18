"
This is a base class for XML nodes. It contains testing messages and methods to set and access the parent node and sibling nodes. It also provides a number messages to control printing.
"
Class {
	#name : #XMLNode,
	#superclass : #Object,
	#instVars : [
		'parent'
	],
	#category : #'XML-Parser-DOM'
}

{ #category : #private }
XMLNode >> acceptsContent [
	^ false
]

{ #category : #accessing }
XMLNode >> addContent: aStringOrStringNode [
	XMLDOMException signal: 'Node cannot contain content'
]

{ #category : #enumerating }
XMLNode >> allNodesDo: aBlock [
	aBlock value: self
]

{ #category : #converting }
XMLNode >> asString [
	"for compatibility if Object>>asString isn't defined"
	^ self printString
]

{ #category : #printing }
XMLNode >> canonicallyPrintOn: aStream [
	self
		withNewXMLWriterOn: aStream
		do: [ :writer | writer
										isCanonical: true;
										writeWith: [ :wr | self writeXMLOn: wr ] ]
		whenAbsent: [self printOn: aStream]
]

{ #category : #printing }
XMLNode >> canonicallyPrinted [
	^ String streamContents: [:stream | self canonicallyPrintOn: stream]
]

{ #category : #accessing }
XMLNode >> contentString [
 	"This returns the combined content string of all descendants with spaces inserted wher necessary."
	^ String streamContents: [:stream | self printContentOn: stream]
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
XMLNode >> isDeclaration [
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
XMLNode >> isPI [
	^ false
]

{ #category : #testing }
XMLNode >> isStringNode [
	^ false
]

{ #category : #accessing }
XMLNode >> nextNode [
	^ self parent ifNotNil: [self parent nodeAfter: self]
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
XMLNode >> prettyPrintOn: aStream [
	self
		withNewXMLWriterOn: aStream
		do: [ :writer | writer
									enablePrettyPrinting;
									writeWith: [ :wr | self writeXMLOn: wr ] ]
		whenAbsent: [ self printOn: aStream ]
]

{ #category : #printing }
XMLNode >> prettyPrinted [
	^ String streamContents: [:stream | self prettyPrintOn: stream]
]

{ #category : #accessing }
XMLNode >> previousNode [
	^ self parent ifNotNil: [self parent nodeBefore: self]
]

{ #category : #printing }
XMLNode >> printContentOn: aStream [
]

{ #category : #printing }
XMLNode >> printOn: aStream [
	self
		withNewXMLWriterOn: aStream
		do: [ :writer | writer writeWith: [ :wr | self writeXMLOn: wr] ]
		whenAbsent: [ super printOn: aStream ]
]

{ #category : #printing }
XMLNode >> printWithoutSelfClosingTagsOn: aStream [
	self
		withNewXMLWriterOn: aStream
		do: [ :writer |
			writer
				outputsSelfClosingTags: false;
				writeWith: [ :wr | self writeXMLOn: wr ]]
		whenAbsent: [ self printOn: aStream ]
]

{ #category : #printing }
XMLNode >> printedWithoutSelfClosingTags [
	^ String streamContents: [:stream | self printWithoutSelfClosingTagsOn: stream]
]

{ #category : #printing }
XMLNode >> withNewXMLWriterOn: aStream do: aOneArgBlock [
	^ self
		withNewXMLWriterOn: aStream
		do: aOneArgBlock
		whenAbsent: [ Error signal: 'The XMLWriter package is required for that' ]
]

{ #category : #printing }
XMLNode >> withNewXMLWriterOn: aStream do: aOneArgBlock whenAbsent: aZeroArgBlock [
	^ (self class environment hasClassNamed: #XMLWriter)
		ifTrue: [ aOneArgBlock value: ((self class environment classNamed: #XMLWriter) on: aStream)]
		ifFalse: [ aZeroArgBlock value ]
]

{ #category : #printing }
XMLNode >> writeXMLOn: aWriter [
	self subclassResponsibility
]
