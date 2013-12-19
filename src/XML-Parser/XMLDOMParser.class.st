"
This class is an XML parser that produces a tree of nodes representing the parsed document's structure. The root of this tree will typically be a document node, and it will have a single child element node as its root. The root element can have any number of additional elements as its children, as well as non-element child nodes. Those elements can themselves have an arbitrary number of children, and so on. To see what type of node objects a node tree created by this parser will contain and for how to manipulate them browse the XML-Parser-Nodes category.

By default, CDATA sections are treated as regular string nodes and comments are ignored entirely. To suppress this behavior, enable #preservesCDataNodes: or #preservesCommentNodes: before parsing. 

Lastly. you can control what node classes the DOM parser uses to create node objects by injecting a custom node factory with #nodeFactory: prior to parsing. See XMLNodeFactory for more information.
"
Class {
	#name : #XMLDOMParser,
	#superclass : #SAXHandler,
	#instVars : [
		'document',
		'nodeStack',
		'isInCDataSection'
	],
	#category : #'XML-Parser'
}

{ #category : #'instance creation' }
XMLDOMParser class >> on: aStringOrStream withRootNode: aRootNode [
	| parser |

	(parser := self on: aStringOrStream)
		pushNode: aRootNode.
	aRootNode isElement
		ifTrue: [parser elementNester rootElement: aRootNode name].
	^ parser.
]

{ #category : #declaration }
XMLDOMParser >> attributeDeclaration: anElement name: aName type: aType defaultDeclaration: aDefaultDeclaration [
	self topNode addNode:
		(XMLAttributeDeclaration
			elementName: anElement
			attributeName: aName
			type: aType
			defaultDeclaration: aDefaultDeclaration)
]

{ #category : #content }
XMLDOMParser >> characters: aString [
	(self preservesCDataNodes and: [self isInCDataSection])
		ifTrue: [self topNode addNode: (self nodeFactory cdataClass string: aString)]
		ifFalse: [self topNode addContent: (self nodeFactory stringClass string: aString)]

]

{ #category : #lexical }
XMLDOMParser >> comment: aComment [
	self preservesCommentNodes
		ifTrue: [self topNode addNode: (self nodeFactory commentClass string: aComment)]
]

{ #category : #private }
XMLDOMParser >> configurationClass [
	^ XMLDOMConfiguration
]

{ #category : #accessing }
XMLDOMParser >> document [
	^ document
]

{ #category : #accessing }
XMLDOMParser >> document: aDocument [
	(document := aDocument) configuration: self configuration
]

{ #category : #declaration }
XMLDOMParser >> elementDeclaration: aName contentModel: aContentModel [
	self topNode addNode:
		(XMLElementDeclaration
			name: aName
			contentModel: aContentModel)
]

{ #category : #lexical }
XMLDOMParser >> endCData [
	isInCDataSection := false
]

{ #category : #declaration }
XMLDOMParser >> endDTD [
	self popNode
]

{ #category : #content }
XMLDOMParser >> endDocument [
	self popNode
]

{ #category : #content }
XMLDOMParser >> endElement: aQualifiedName prefix: aPrefix uri: aUri localName: aLocalName [
	self popNode
]

{ #category : #declaration }
XMLDOMParser >> generalEntityDeclaration: aName publicID: aPublicId systemID: aSystemId ndata: aNotation [
	self topNode addNode:
		(XMLGeneralEntityDeclaration
			name: aName
			publicID: aPublicId
			systemID: aSystemId
			ndata: aNotation)
]

{ #category : #declaration }
XMLDOMParser >> generalEntityDeclaration: aName replacement: aReplacement [
	self topNode addNode:
		(XMLGeneralEntityDeclaration
			name: aName
			replacement: aReplacement)
]

{ #category : #testing }
XMLDOMParser >> isInCDataSection [
	^ isInCDataSection ifNil: [isInCDataSection := false]
]

{ #category : #accessing }
XMLDOMParser >> nodeFactory [
	^ self configuration nodeFactory
]

{ #category : #accessing }
XMLDOMParser >> nodeFactory: aNodeFactory [
	self configuration nodeFactory: aNodeFactory
]

{ #category : #accessing }
XMLDOMParser >> nodeListClass [
	^ self configuration nodeListClass
]

{ #category : #accessing }
XMLDOMParser >> nodeListClass: aClass [
	self configuration nodeListClass: aClass
]

{ #category : #private }
XMLDOMParser >> nodeStack [
	^ nodeStack ifNil: [nodeStack := OrderedCollection new: 15]
]

{ #category : #declaration }
XMLDOMParser >> notationDeclaration: aName publicID: aPublicId systemID: aSystemId [
	self topNode addNode:
		(XMLNotationDeclaration
			name: aName
			publicID: aPublicId
			systemID: aSystemId)
]

{ #category : #declaration }
XMLDOMParser >> parameterEntityDeclaration: aName publicID: aPublicId systemID: aSystemId [
	self topNode addNode:
		(XMLParameterEntityDeclaration
			name: aName
			publicID: aPublicId
			systemID: aSystemId)
]

{ #category : #declaration }
XMLDOMParser >> parameterEntityDeclaration: aName replacement: aReplacement [
	self topNode addNode:
		(XMLParameterEntityDeclaration
			name: aName
			replacement: aReplacement)
]

{ #category : #parsing }
XMLDOMParser >> parsingResult [
	^ self document
]

{ #category : #private }
XMLDOMParser >> popNode [
	^ self nodeStack removeLast
]

{ #category : #testing }
XMLDOMParser >> preservesCDataNodes [
	^ self configuration preservesCDataNodes
]

{ #category : #accessing }
XMLDOMParser >> preservesCDataNodes: aBoolean [
	self configuration preservesCDataNodes: aBoolean
]

{ #category : #testing }
XMLDOMParser >> preservesCommentNodes [
	^ self configuration preservesCommentNodes
]

{ #category : #accessing }
XMLDOMParser >> preservesCommentNodes: aBoolean [
	self configuration preservesCommentNodes: aBoolean
]

{ #category : #content }
XMLDOMParser >> processingInstruction: aTarget data: aDataString [
	self topNode addNode: (self nodeFactory piClass target: aTarget data: aDataString)
]

{ #category : #private }
XMLDOMParser >> pushElement: anElement [
	self nodeStack ifNotEmpty: [self topNode addNode: anElement].
	self pushNode: anElement.
]

{ #category : #private }
XMLDOMParser >> pushNode: aNode [
	^ self nodeStack addLast: aNode

]

{ #category : #lexical }
XMLDOMParser >> startCData [
	isInCDataSection := true
]

{ #category : #declaration }
XMLDOMParser >> startDTD: aRootElementName publicID: aPublicId systemID: aSystemId [
	| doctypeDeclaration |

	doctypeDeclaration := 
		self nodeFactory doctypeDeclarationClass
			root: aRootElementName
			publicID: aPublicId
			systemID: aSystemId.
	self pushNode: doctypeDeclaration.
	self document doctypeDeclaration: doctypeDeclaration.
]

{ #category : #content }
XMLDOMParser >> startDocument [
	self topNode ifNotNil: [^ self].

	self document: self nodeFactory documentClass new.
	self pushNode: self document 
]

{ #category : #content }
XMLDOMParser >> startElement: aQualifiedName prefix: aPrefix uri: aUri localName: aLocalName attributes: aDictionary [
	self pushElement:
		((self nodeFactory
			classForElement: aQualifiedName
			prefix: aPrefix
			uri: aUri
			localName: aLocalName)
				qualifiedName: aQualifiedName
				prefix: aPrefix
				localName: aLocalName
				attributes: aDictionary
				namespaceScope: self currentScope)
]

{ #category : #private }
XMLDOMParser >> topNode [
	^ self nodeStack isEmpty
		ifTrue: [nil]
		ifFalse: [self nodeStack last]
]

{ #category : #content }
XMLDOMParser >> xmlVersion: aVersionFloat encoding: anEncoding standalone: aBoolean [
	self document ifNotNil: [
		self document
			version: aVersionFloat;
			encoding: anEncoding;
			isStandalone: aBoolean]
]
