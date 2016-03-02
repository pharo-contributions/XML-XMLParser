"
This class is an XML parser that parses documents into a DOM tree of nodes. Browse the XML-Parser-DOM category for info on the nodes.

By default, CDATA sections are treated as regular string nodes and comments are ignored entirely. To suppress this behavior, enable #preservesCDataNodes: and #preservesCommentNodes: before parsing. You can also use #preservesIgnorableWhitespace: to preserve ignorable whitespace as string nodes.

You can control what node classes the DOM parser uses to create nodes by injecting a custom node factory with #nodeFactory: prior to parsing. See XMLNodeFactory.

See the superclass for more info.
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
XMLDOMParser >> attributeDeclaration: anElementName name: anAttributeName type: aType defaultPragma: aDefaultPragma defaultValue: aDefaultValue [
	self topNode addNode:
		(self nodeFactory attributeDeclarationClass
			element: anElementName
			attribute: anAttributeName
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

{ #category : #private }
XMLDOMParser >> doctypeDefinition: aDoctypeDefinition [
	self document doctypeDefinition: aDoctypeDefinition
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
XMLDOMParser >> elementDeclaration: anElementName contentModel: aContentModel [
	self topNode addNode:
		(self nodeFactory elementDeclarationClass
			element: anElementName
			contentModel: aContentModel)
]

{ #category : #'handling - lexical' }
XMLDOMParser >> endDTD [
	self popNode
]

{ #category : #'handling - content' }
XMLDOMParser >> endElement: aQualifiedName prefix: aPrefix uri: aURI localName: aLocalName [
	self popNode
]

{ #category : #'handling - declarations' }
XMLDOMParser >> generalEntityDeclaration: aName publicID: aPublicID systemID: aSystemID ndata: aNotationName [
	self topNode addNode:
		(self nodeFactory generalEntityDeclarationClass
			name: aName
			publicID: aPublicID
			systemID: aSystemID
			ndata: aNotationName)
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

{ #category : #deprecated }
XMLDOMParser >> nodeListClass [
	"will be deprecated"
	^ self configuration nodeListClass
]

{ #category : #deprecated }
XMLDOMParser >> nodeListClass: aClass [
	"will be deprecated"
	self configuration nodeListClass: aClass
]

{ #category : #private }
XMLDOMParser >> nodeStack [
	^ nodeStack
]

{ #category : #'handling - declarations' }
XMLDOMParser >> notationDeclaration: aName publicID: aPublicID systemID: aSystemID [
	self topNode addNode:
		(self nodeFactory notationDeclarationClass
			name: aName
			publicID: aPublicID
			systemID: aSystemID)
]

{ #category : #initialization }
XMLDOMParser >> on: aStringOrStream [
	super on: aStringOrStream.

	nodeStack := OrderedCollection new: 10.
]

{ #category : #'handling - declarations' }
XMLDOMParser >> parameterEntityDeclaration: aName publicID: aPublicID systemID: aSystemID [
	self topNode addNode:
		(self nodeFactory parameterEntityDeclarationClass
			name: aName
			publicID: aPublicID
			systemID: aSystemID)
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
	self document
		ifNotNil: [self setupInnerXMLDocumentForParser: parser].
	self nodeStack isEmpty
		ifFalse: [self setupInnerXMLNodesForParser: parser].
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
	"if enabled, <![CDATA[...]]> sections will be preserved as CDATA nodes
	and not ordinary string nodes and won't be merged with adjacent string
	nodes (not default)"
	self configuration preservesCDataNodes: aBoolean
]

{ #category : #configuring }
XMLDOMParser >> preservesCommentNodes [
	^ self configuration preservesCommentNodes
]

{ #category : #configuring }
XMLDOMParser >> preservesCommentNodes: aBoolean [
	"if enabled, comments will be preserved as comment nodes (not default)"
	self configuration preservesCommentNodes: aBoolean
]

{ #category : #configuring }
XMLDOMParser >> preservesIgnorableWhitespace [
	^ self configuration preservesIgnorableWhitespace
]

{ #category : #configuring }
XMLDOMParser >> preservesIgnorableWhitespace: aBoolean [
	"if enabled, ignorable whitespace will be preserved as string nodes (not default)"
	self configuration preservesIgnorableWhitespace: aBoolean
]

{ #category : #'handling - content' }
XMLDOMParser >> processingInstruction: aTargetString data: aDataString [
	self topNode addNode:
		(self nodeFactory newPI
			target: aTargetString;
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

{ #category : #private }
XMLDOMParser >> setupInnerXMLDocumentForParser: aParser [
	self document hasDoctypeDefinition
		ifTrue: [
			aParser driver doctypeDefinition addGeneralEntitiesFrom:
				self document doctypeDefinition]
]

{ #category : #private }
XMLDOMParser >> setupInnerXMLNodesForParser: aParser [
	self nodeStack do: [:each |
		each isElement
			ifTrue: [
				self
					startInnerXMLElement: each
					forParser: aParser]].
	aParser context: self topNode innerXMLContext.
]

{ #category : #'handling - lexical' }
XMLDOMParser >> startDTD: aRootElementName publicID: aPublicID systemID: aSystemID [
	| doctypeDeclaration |

	doctypeDeclaration := 
		self nodeFactory doctypeDeclarationClass
			root: aRootElementName
			publicID: aPublicID
			systemID: aSystemID.
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
XMLDOMParser >> startElement: aQualifiedName prefix: aPrefix uri: aURI localName: aLocalName attributes: aDictionary [
	self pushElement:
		((self nodeFactory
			classForElement: aQualifiedName
			prefix: aPrefix
			uri: aURI
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
