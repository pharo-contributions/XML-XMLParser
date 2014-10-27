"
This class is an XML parser that produces a tree of nodes representing the parsed document's structure. The root of this tree will typically be a document node, and it will have a single child element node as its root. The root element can have any number of additional elements as its children, as well as non-element child nodes. Those elements can themselves have an arbitrary number of children, and so on. To see what type of node objects a node tree created by this parser will contain and for how to manipulate them browse the XML-Parser-DOM category.

By default, CDATA sections are treated as regular string nodes and comments are ignored entirely. To suppress this behavior, enable #preservesCDataNodes: or #preservesCommentNodes: before parsing. 

Lastly. you can control what node classes the DOM parser uses to create node objects by injecting a custom node factory with #nodeFactory: prior to parsing. See XMLNodeFactory for more information.
"
Class {
	#name : #XMLDOMParser,
	#superclass : #SAXHandler,
	#instVars : [
		'document',
		'nodeStack'
	],
	#category : #'XML-Parser'
}

{ #category : #'instance creation' }
XMLDOMParser class >> on: aStringOrStream withRootNode: aRootNode [
	^ (self on: aStringOrStream)
		pushNode: aRootNode;
		yourself
]

{ #category : #declaration }
XMLDOMParser >> attributeDeclaration: anElement name: aName type: aType defaultPragma: aDefaultPragma defaultValue: aDefaultValue [
	self topNode addNode:
		(self nodeFactory attributeDeclarationClass
			element: anElement
			attribute: aName
			type: aType
			defaultPragma: aDefaultPragma
			defaultValue: aDefaultValue)
]

{ #category : #content }
XMLDOMParser >> characters: aString [
	(self isInCDataSection and: [self preservesCDataNodes])
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

{ #category : #private }
XMLDOMParser >> currentScope: aNamespaceScope [
	self topNode setNamespaceScope: aNamespaceScope
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
		(self nodeFactory elementDeclarationClass
			element: aName
			contentModel: aContentModel)
]

{ #category : #declaration }
XMLDOMParser >> endDTD [
	self popNode
]

{ #category : #content }
XMLDOMParser >> endElement: aQualifiedName prefix: aPrefix uri: aUri localName: aLocalName [
	self popNode
]

{ #category : #declaration }
XMLDOMParser >> generalEntityDeclaration: aName publicID: aPublicId systemID: aSystemId ndata: aNotation [
	self topNode addNode:
		(self nodeFactory generalEntityDeclarationClass
			name: aName
			publicID: aPublicId
			systemID: aSystemId
			ndata: aNotation)
]

{ #category : #declaration }
XMLDOMParser >> generalEntityDeclaration: aName replacement: aReplacement [
	self topNode addNode:
		(self nodeFactory generalEntityDeclarationClass
			name: aName
			replacement: aReplacement)
]

{ #category : #configuring }
XMLDOMParser >> nodeFactory [
	^ self configuration nodeFactory
]

{ #category : #configuring }
XMLDOMParser >> nodeFactory: aNodeFactory [
	self configuration nodeFactory: aNodeFactory
]

{ #category : #configuring }
XMLDOMParser >> nodeListClass [
	^ self configuration nodeListClass
]

{ #category : #configuring }
XMLDOMParser >> nodeListClass: aClass [
	self configuration nodeListClass: aClass
]

{ #category : #private }
XMLDOMParser >> nodeStack [
	^ nodeStack
]

{ #category : #declaration }
XMLDOMParser >> notationDeclaration: aName publicID: aPublicId systemID: aSystemId [
	self topNode addNode:
		(self nodeFactory notationDeclarationClass
			name: aName
			publicID: aPublicId
			systemID: aSystemId)
]

{ #category : #declaration }
XMLDOMParser >> parameterEntityDeclaration: aName publicID: aPublicId systemID: aSystemId [
	self topNode addNode:
		(self nodeFactory parameterEntityDeclarationClass
			name: aName
			publicID: aPublicId
			systemID: aSystemId)
]

{ #category : #declaration }
XMLDOMParser >> parameterEntityDeclaration: aName replacement: aReplacement [
	self topNode addNode:
		(self nodeFactory parameterEntityDeclarationClass
			name: aName
			replacement: aReplacement)
]

{ #category : #parsing }
XMLDOMParser >> parser [
	| parser |

	parser := super parser.
	(self nodeStack notEmpty and: [self topNode isElement])
		ifTrue: [
			self
				configuration: self topNode configuration;
				document: self topNode document.
			parser driver
				setRootElement: self topNode name
				currentScope: self topNode namespaceScope].

	^ parser.
]

{ #category : #parsing }
XMLDOMParser >> parsingResult [
	^ self document
]

{ #category : #private }
XMLDOMParser >> popNode [
	^ self nodeStack removeLast
]

{ #category : #configuring }
XMLDOMParser >> preservesCDataNodes [
	^ self configuration preservesCDataNodes
]

{ #category : #configuring }
XMLDOMParser >> preservesCDataNodes: aBoolean [
	self configuration preservesCDataNodes: aBoolean
]

{ #category : #configuring }
XMLDOMParser >> preservesCommentNodes [
	^ self configuration preservesCommentNodes
]

{ #category : #configuring }
XMLDOMParser >> preservesCommentNodes: aBoolean [
	self configuration preservesCommentNodes: aBoolean
]

{ #category : #content }
XMLDOMParser >> processingInstruction: aTarget data: aDataString [
	self topNode addNode: (self nodeFactory piClass target: aTarget data: aDataString)
]

{ #category : #private }
XMLDOMParser >> pushElement: anElement [
	self topNode addNode: anElement.
	^ self pushNode: anElement.
]

{ #category : #private }
XMLDOMParser >> pushNode: aNode [
	^ self nodeStack addLast: aNode

]

{ #category : #initialization }
XMLDOMParser >> setInput: aStringOrStream documentURI: aUri [
	super
		setInput: aStringOrStream
		documentURI: aUri.

	nodeStack := OrderedCollection new: 10.
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
			localName: aLocalName) new
				setQualifiedName: aQualifiedName
				prefix: aPrefix
				localName: aLocalName
				attributes: aDictionary)
]

{ #category : #private }
XMLDOMParser >> topNode [
	^ self nodeStack lastOrNil
]

{ #category : #content }
XMLDOMParser >> xmlVersion: aVersionFloat encoding: anEncoding standalone: aBoolean [
	self document ifNotNil: [
		self document
			version: aVersionFloat;
			encoding: anEncoding;
			isStandalone: aBoolean]
]
