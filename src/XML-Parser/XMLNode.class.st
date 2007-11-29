Class {
	#name : #XMLNode,
	#superclass : #Object,
	#classVars : [
		'CanonicalTable'
	],
	#category : #'XML-Parser'
}

{ #category : #accessing }
XMLNode >> addContent: contentString [
	SAXParseException signal: 'Illegal string data.'
]

{ #category : #enumerating }
XMLNode >> contentsDo: aBlock [
]

{ #category : #enumerating }
XMLNode >> elementsAndContentsDo: aBlock [
	self elementsDo: aBlock
]

{ #category : #enumerating }
XMLNode >> elementsDo: aBlock [
]

{ #category : #searching }
XMLNode >> firstTagNamed: aSymbol [ 
	"Return the first encountered node with the specified tag. Pass the message on"

	| answer |

	self elementsDo: [:node | (answer := node firstTagNamed: aSymbol) ifNotNil: [^answer]].
	^nil
]

{ #category : #searching }
XMLNode >> firstTagNamed: aSymbol with: aBlock [
	"Return the first encountered node with the specified tag that
	allows the block to evaluate to true. Pass the message on"

	| answer |

	self elementsDo: [:node |
		(answer := node firstTagNamed: aSymbol with: aBlock) ifNotNil: [^answer]].
	^nil
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
XMLNode >> isText [
	^false
]

{ #category : #printing }
XMLNode >> printOn: stream [
	self printXMLOn: (XMLWriter on: stream)
]

{ #category : #printing }
XMLNode >> printXMLOn: writer [
	self subclassResponsibility
]

{ #category : #searching }
XMLNode >> tagsNamed: aSymbol childrenDo: aOneArgumentBlock [
	"Evaluate aOneArgumentBlock for all children who match"

	self elementsDo: [:each | 
		each tagsNamed: aSymbol ifReceiverDo: aOneArgumentBlock]
]

{ #category : #searching }
XMLNode >> tagsNamed: aSymbol childrenDoAndRecurse: aOneArgumentBlock [
	"Evaluate aOneArgumentBlock for all children who match and recurse"

	self elementsDo: [:each | 
		each tagsNamed: aSymbol ifReceiverDoAndRecurse: aOneArgumentBlock]
]

{ #category : #searching }
XMLNode >> tagsNamed: aSymbol contentsDo: aBlock [
	"Evaluate aBlock for all of the contents of the receiver.
	The receiver has no tag, so pass the message on"

	self elementsDo: [:each | each tagsNamed: aSymbol contentsDo: aBlock]
]

{ #category : #searching }
XMLNode >> tagsNamed: aSymbol do: aOneArgumentBlock [
	"Search for nodes with tag aSymbol. When encountered evaluate aOneArgumentBlock"

	self elementsDo: [:each | each tagsNamed: aSymbol do: aOneArgumentBlock]
]

{ #category : #searching }
XMLNode >> tagsNamed: aSymbol ifReceiverDo: aOneArgumentBlock [
	"Handled only by XMLTagNode subclass"


]

{ #category : #searching }
XMLNode >> tagsNamed: aSymbol ifReceiverDoAndRecurse: aOneArgumentBlock [
	"Recurse all children"

	self elementsDo: [:each | each tagsNamed: aSymbol ifReceiverDoAndRecurse: aOneArgumentBlock]
]

{ #category : #searching }
XMLNode >> tagsNamed: aSymbol ifReceiverOrChildDo: aOneArgumentBlock [
	"Recurse all children"

	self elementsDo: [:each | each tagsNamed: aSymbol ifReceiverDo: aOneArgumentBlock]
]
