Extension { #name : #XMLDocument }

{ #category : #'*XML-ParserGTExtensions' }
XMLDocument >> addTreeViewChildrenTo: anOrderedCollection [
	self hasDoctypeDeclaration
		ifTrue: [anOrderedCollection addLast: self doctypeDeclaration].
	super addTreeViewChildrenTo: anOrderedCollection.
]

{ #category : #'*XML-ParserGTExtensions' }
XMLDocument classSide >> gtExampleXmlNode [
	<gtExample>
	^ XMLDOMParser parse: '<document><a></a><b></b></document>'
]

{ #category : #'*XML-ParserGTExtensions' }
XMLDocument >> newSourceEditorTextStylerDecorator [
	^ GLMXMLDocumentHighlighterTextStylerDecorator new
		configuration: self configuration
]

{ #category : #'*XML-ParserGTExtensions' }
XMLDocument >> setOuterXMLFromEditedSource: aString [
	| newDocument |

	[newDocument :=
		(self parserHandlerClass on: aString)
			configuration: self configuration;
			parseDocument]
		on: Error
		do: [:error |
			newDocument := nil.
			error pass].
	newDocument
		ifNotNil: [
			self
				removeNodes;
				configuration: newDocument configuration;
				version: newDocument version;
				encoding: newDocument encoding;
				isStandalone: newDocument isStandalone;
				doctypeDeclaration: newDocument doctypeDeclaration;
				doctypeDefinition: newDocument doctypeDefinition;
				addNodes: newDocument nodes copy].
	^ self.
]

{ #category : #'*XML-ParserGTExtensions' }
XMLDocument >> supportsSourceEditing [
	^ true
]

{ #category : #'*XML-ParserGTExtensions' }
XMLDocument >> supportsTreeView [
	^ self hasDoctypeDeclaration
		or: [super supportsTreeView]
]

{ #category : #'*XML-ParserGTExtensions' }
XMLDocument >> writeTreeViewLabelXMLOn: aWriter [
	self writeXMLDeclarationOn: aWriter
]
