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

{ #category : #'handling - declarations' }
XMLDOMParser >> attributeDeclaration: anElement name: aName type: aType defaultPragma: aDefaultPragma defaultValue: aDefaultValue [
	self topNode addNode:
		(self nodeFactory attributeDeclarationClass
			element: anElement
			attribute: aName
			type: aType
			defaultPragma: aDefaultPragma
			defaultValue: aDefaultValue)
]

{ #category : #'handling - content' }
XMLDOMParser >> characters: aString [
	(self isInCDataSection and: [self preservesCDataNodes])
		ifTrue: [self topNode addNode: (self nodeFactory newCData: aString)]
		ifFalse: [self topNode addContent: (self nodeFactory newString: aString)]

]

{ #category : #'handling - lexical' }
XMLDOMParser >> comment: aComment [
	self preservesCommentNodes
		ifTrue: [self topNode addNode: (self nodeFactory newComment: aComment)]
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
	document := aDocument
]

{ #category : #'handling - declarations' }
XMLDOMParser >> elementDeclaration: aName contentModel: aContentModel [
	self topNode addNode:
		(self nodeFactory elementDeclarationClass
			element: aName
			contentModel: aContentModel)
]

{ #category : #'handling - declarations' }
XMLDOMParser >> endDTD [
	self popNode
]

{ #category : #'handling - content' }
XMLDOMParser >> endElement: aQualifiedName prefix: aPrefix uri: aUri localName: aLocalName [
	self popNode
]

{ #category : #'handling - declarations' }
XMLDOMParser >> generalEntityDeclaration: aName publicID: aPublicId systemID: aSystemId ndata: aNotation [
	self topNode addNode:
		(self nodeFactory generalEntityDeclarationClass
			name: aName
			publicID: aPublicId
			systemID: aSystemId
			ndata: aNotation)
]

{ #category : #'handling - declarations' }
XMLDOMParser >> generalEntityDeclaration: aName replacement: aReplacement [
	self topNode addNode:
		(self nodeFactory generalEntityDeclarationClass
			name: aName
			replacement: aReplacement)
]

{ #category : #'handling - content' }
XMLDOMParser >> ignorableWhitespace: aString [
	self preservesIgnorableWhitespace
		ifTrue: [self characters: aString]
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

{ #category : #'handling - declarations' }
XMLDOMParser >> notationDeclaration: aName publicID: aPublicId systemID: aSystemId [
	self topNode addNode:
		(self nodeFactory notationDeclarationClass
			name: aName
			publicID: aPublicId
			systemID: aSystemId)
]

{ #category : #initialization }
XMLDOMParser >> on: aStringOrStream documentURI: aUri [
	super
		on: aStringOrStream
		documentURI: aUri.

	nodeStack := OrderedCollection new: 10.
]

{ #category : #'handling - declarations' }
XMLDOMParser >> parameterEntityDeclaration: aName publicID: aPublicId systemID: aSystemId [
	self topNode addNode:
		(self nodeFactory parameterEntityDeclarationClass
			name: aName
			publicID: aPublicId
			systemID: aSystemId)
]

{ #category : #'handling - declarations' }
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
	self topNode
		ifNotNil: [:root |
			parser initialContext: root innerXMLContext.

			self nodeStack do: [:each |
				each isElement
					ifTrue: [
						self
							startInnerXMLElement: each
							forParser: parser]]].

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

{ #category : #configuring }
XMLDOMParser >> preservesIgnorableWhitespace [
	^ self configuration preservesIgnorableWhitespace
]

{ #category : #configuring }
XMLDOMParser >> preservesIgnorableWhitespace: aBoolean [
	self configuration preservesIgnorableWhitespace: aBoolean
]

{ #category : #'handling - content' }
XMLDOMParser >> processingInstruction: aTarget data: aDataString [
	self topNode addNode:
		(self nodeFactory newPI
			target: aTarget;
			data: aDataString)
]

{ #category : #private }
XMLDOMParser >> pushElement: anElement [
	self topNode addNode: anElement.
	^ self pushNode: anElement.
]

{ #category : #private }
XMLDOMParser >> pushInnerXMLRootNode: aRootNode [
	self
		configuration: aRootNode configuration;
		document: aRootNode document;
		pushNode: aRootNode.
]

{ #category : #private }
XMLDOMParser >> pushNode: aNode [
	^ self nodeStack addLast: aNode

]

{ #category : #'handling - declarations' }
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

{ #category : #'handling - content' }
XMLDOMParser >> startDocument [
	self topNode ifNotNil: [^ self].

	self
		document: self nodeFactory newDocument;
		pushNode: self document.

	self document configuration: self configuration.
]

{ #category : #'handling - content' }
XMLDOMParser >> startElement: aQualifiedName prefix: aPrefix uri: aUri localName: aLocalName attributes: aDictionary [
	self pushElement:
		((self nodeFactory
			classForElement: aQualifiedName
			prefix: aPrefix
			uri: aUri
			localName: aLocalName) new
				setQualifiedName: aQualifiedName
				localName: aLocalName
				attributes: aDictionary)
]

{ #category : #private }
XMLDOMParser >> startInnerXMLElement: anElement forParser: aParser [
	aParser driver
		setRootElement: anElement name
		currentScope: anElement namespaceScope
]

{ #category : #private }
XMLDOMParser >> topNode [
	^ self nodeStack lastOrNil
]

{ #category : #'handling - content' }
XMLDOMParser >> xmlVersion: aVersionFloat encoding: anEncoding standalone: aBoolean [
	self document ifNotNil: [
		self document
			version: aVersionFloat;
			encoding: anEncoding;
			isStandalone: aBoolean]
]
