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

{ #category : #adding }
XMLNode >> addContent: aStringOrStringNode [
	XMLDOMException signal: 'Node cannot contain content'
]

{ #category : #enumerating }
XMLNode >> allNodesDo: aBlock [
	aBlock value: self
]

{ #category : #accessing }
XMLNode >> ancestorElements [
	| ancestorElements |

	ancestorElements := self newNodeListForSelect.
	self ancestorElementsDo: [:each | ancestorElements addLast: each].
	^ ancestorElements.
]

{ #category : #enumerating }
XMLNode >> ancestorElementsDo: aBlock [
	self parent
		ifNotNil: [:node |
			node isElement
				ifTrue: [aBlock value: node].
			node ancestorElementsDo: aBlock]
]

{ #category : #accessing }
XMLNode >> ancestorNodes [
	| ancestors |

	ancestors := self newNodeListForSelect.
	self ancestorNodesDo: [:each | ancestors addLast: each].
	^ ancestors.
]

{ #category : #enumerating }
XMLNode >> ancestorNodesDo: aBlock [
	self parent
		ifNotNil: [:node |
			aBlock value: node.
			node ancestorNodesDo: aBlock]
]

{ #category : #converting }
XMLNode >> asString [
	"for compatibility if Object>>asString isn't defined"
	^ self printString
]

{ #category : #testing }
XMLNode >> canHaveChildren [
	^ false
]

{ #category : #testing }
XMLNode >> canonicallyEquals: aNode [
	^ self canonicallyPrinted = aNode canonicallyPrinted
]

{ #category : #printing }
XMLNode >> canonicallyPrintOn: aStream [
 	"Prints on aStream as canonical XML"
	self
		withNewXMLWriterOn: aStream
		do: [:writer |
			writer
				isCanonical: true;
				writeWith: [self writeXMLOn: writer]]
		whenAbsent: [self printOn: aStream]
]

{ #category : #printing }
XMLNode >> canonicallyPrinted [
 	"Prints as canonical XML"
	^ String streamContents: [:stream | self canonicallyPrintOn: stream]
]

{ #category : #accessing }
XMLNode >> configuration [
	^ self document ifNotNil: [:node | node configuration]
]

{ #category : #accessing }
XMLNode >> contentString [
 	"This returns the combined content string of all descendants with spaces inserted where necessary."
	^ String streamContents: [:stream | self printContentOn: stream]
]

{ #category : #enumerating }
XMLNode >> descendentNodesDo: aBlock [
]

{ #category : #accessing }
XMLNode >> document [
	^ self parent ifNotNil: [:node | node document]
]

{ #category : #private }
XMLNode >> errorXMLWritingUnsupported [
	XMLDOMException signal: 'The XMLWriter package is required for writng DOM objects'
]

{ #category : #private }
XMLNode >> escapesContentEntitiesWhenWriting [
	self hasParent
		ifTrue: [^ self parent escapesContentEntitiesWhenWriting]
		ifFalse: [^ true] "default to escaping"
]

{ #category : #testing }
XMLNode >> hasChildren [
	^ false
]

{ #category : #testing }
XMLNode >> hasParent [
	^ parent notNil
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
XMLNode >> isElementNamed: aName [
	^ false
]

{ #category : #testing }
XMLNode >> isElementNamedAny: aNameCollection [
	^ false
]

{ #category : #testing }
XMLNode >> isInLanguage: aLanguage [
	^ self hasParent
		and: [self parent isInLanguage: aLanguage]
]

{ #category : #testing }
XMLNode >> isPI [
	^ false
]

{ #category : #testing }
XMLNode >> isStringNode [
	^ false
]

{ #category : #testing }
XMLNode >> isStringNode: aStringOrStringNode [
	^ false
]

{ #category : #private }
XMLNode >> newListForCollect [
	^ XMLOrderedList new: 10
]

{ #category : #private }
XMLNode >> newNodeListForSelect [
	^ XMLNodeList new: 10
]

{ #category : #accessing }
XMLNode >> nextNode [
	^ self parent ifNotNil: [:node | node nodeAfter: self]
]

{ #category : #accessing }
XMLNode >> parent [
	^ parent
]

{ #category : #accessing }
XMLNode >> parent: aParentNode [
	parent := aParentNode
]

{ #category : #copying }
XMLNode >> postCopy [
	parent := nil
]

{ #category : #printing }
XMLNode >> prettyPrintOn: aStream [
	self
		withNewXMLWriterOn: aStream
		do: [:writer |
			writer
				enablePrettyPrinting;
				writeWith: [self writeXMLOn: writer]]
		whenAbsent: [self printOn: aStream]
]

{ #category : #printing }
XMLNode >> prettyPrinted [
	^ String streamContents: [:stream | self prettyPrintOn: stream]
]

{ #category : #accessing }
XMLNode >> previousNode [
	^ self parent ifNotNil: [:node | node nodeBefore: self]
]

{ #category : #printing }
XMLNode >> printContentOn: aStream [
 	"Prints on aStream the content strings of all descendants with spaces inserted where necessary."
	self printRawContentOn: (XMLNodeContentWriteStreamAdapter on: aStream)
]

{ #category : #printing }
XMLNode >> printOn: aStream [
	self
		withNewXMLWriterOn: aStream
		do: [:writer | writer writeWith: [self writeXMLOn: writer]]
		whenAbsent: [super printOn: aStream]
]

{ #category : #printing }
XMLNode >> printRawContentOn: aStream [ 
 	"Prints on aStream the content strings of all descendants without spaces inserted."
]

{ #category : #printing }
XMLNode >> printWithoutSelfClosingTagsOn: aStream [
	self
		withNewXMLWriterOn: aStream
		do: [:writer |
			writer
				outputsSelfClosingTags: false;
				writeWith: [self writeXMLOn: writer]]
		whenAbsent: [self printOn: aStream]
]

{ #category : #printing }
XMLNode >> printedWithoutSelfClosingTags [
	^ String streamContents: [:stream | self printWithoutSelfClosingTagsOn: stream]
]

{ #category : #accessing }
XMLNode >> rawContentString [
 	"This returns the combined content string of all descendants without spaces inserted."
	^ String streamContents: [:stream | self printRawContentOn: stream].
]

{ #category : #private }
XMLNode >> sortKey [
	"used to compare nodes when sorting"

	^ self class name asString
]

{ #category : #private }
XMLNode >> withNewXMLWriterOn: aStream do: aOneArgBlock [
	^ self
		withNewXMLWriterOn: aStream
		do: aOneArgBlock
		whenAbsent: [self errorXMLWritingUnsupported]
]

{ #category : #private }
XMLNode >> withNewXMLWriterOn: aStream do: aOneArgBlock whenAbsent: aZeroArgBlock [
	| writer |

	writer :=
		(Smalltalk
			at: #XMLWriter
			ifAbsent: [^ aZeroArgBlock value]) on: aStream.
	self escapesContentEntitiesWhenWriting
		ifFalse: [writer escapesContentEntityReferences: false].
	^ aOneArgBlock value: writer.
]

{ #category : #printing }
XMLNode >> writeXMLOn: aWriter [
]
