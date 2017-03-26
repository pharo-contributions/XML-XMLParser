Extension { #name : #XMLDocument }

{ #category : #'*XML-Parser-GTExtensions' }
XMLDocument >> addTreeViewChildrenTo: anOrderedCollection [
	self hasDoctypeDeclaration
		ifTrue: [anOrderedCollection addLast: self doctypeDeclaration].
	super addTreeViewChildrenTo: anOrderedCollection.
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLDocument classSide >> gtExampleXmlNode [
	<gtExample>
	^ XMLDOMParser parse: '<document><a></a><b></b></document>'
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLDocument >> newSourceEditorTextStylerDecorator [
	^ GLMXMLDocumentHighlighterTextStylerDecorator new
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLDocument >> outerXMLFromEditedSource: aString [
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
				version: newDocument version;
				encoding: newDocument encoding;
				isStandalone: newDocument isStandalone;
				doctypeDeclaration: newDocument doctypeDeclaration;
				doctypeDefinition: newDocument doctypeDefinition;
				removeNodes;
				addNodes: newDocument nodes copy].
	^ self.
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLDocument >> supportsSourceEditing [
	^ true
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLDocument >> supportsTreeView [
	^ self hasDoctypeDeclaration
		or: [super supportsTreeView]
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLDocument >> writeTreeViewLabelXMLOn: aWriter [
	self writeXMLDeclarationOn: aWriter
]
