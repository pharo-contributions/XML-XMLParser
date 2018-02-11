Extension { #name : #XMLNode }

{ #category : #'*XML-ParserGTExtensions' }
XMLNode >> acceptEditedSource: aSourceTextOrString inContext: aGTInspector [
	| newOuterXMLNode |

	newOuterXMLNode :=
		self setOuterXMLFromEditedSource: aSourceTextOrString asString.

	"find the previous panes of the first pane inspecting
	the receiver (not necessarily the current pane)"
	(aGTInspector panes
		copyFrom: 1
		to:
			(aGTInspector panes findFirst: [:each |
				(each port: #entity) value = self]) - 1)
		ifEmpty: [
			"no previous panes; delete any panes after the
			current and make its selection the new outer XML
			node (closing and reopening is a hack to do this,
			but it works for now)"
			aGTInspector browser close.
			aGTInspector openOn: newOuterXMLNode]
		ifNotEmpty: [:previousPanes |
			"update all previous panes and replace the first
			pane inspecting the receiver with one inspecting
			the new outer XML node"
			previousPanes do: [:each | each update].
			previousPanes last presentations first
				selection: newOuterXMLNode].
]

{ #category : #'*XML-ParserGTExtensions' }
XMLNode >> addRemoveActionTo: aPresentation in: aComposite inContext: aGTInspector [
	(self supportsRemoveAction not
		or: [aGTInspector panes size <= 1
			or: [(aGTInspector panes first port: #entity) value = self]])
		ifTrue: [^ self].

	aPresentation
		act: [| removeStartIndex |
			(UIManager default confirm: 'Remove node from DOM tree?')
				ifTrue: [
					self removeFromParent.

					"remove all panes starting with the first pane inspecting
					the receiver (not necessarily the current pane)"
					removeStartIndex :=
						aGTInspector panes findFirst: [:each |
							(each port: #entity) value = self].
					removeStartIndex
						to: aGTInspector panes size
						do: [:i |
							aGTInspector removeLastPane].

					"update the remaining panes"
					aGTInspector panes do: [:each |
						each update]]]
		icon: GLMUIThemeExtraIcons glamorousRemove
		on: $X
		entitled: 'Remove'.
]

{ #category : #'*XML-ParserGTExtensions' }
XMLNode >> asHighlightedSourceText [
	^ self asHighlightedTextWrittenWith: [:writer |
		"Add some formatting for the the non-content markup (markup outside
		the root element), because whatever formatting was there was
		lost during parsing. Avoid other formatting, to try to preserve the
		original."
		writer enablePrologPrettyPrinting.
		self writeXMLOn: writer]
]

{ #category : #'*XML-ParserGTExtensions' }
XMLNode >> asHighlightedText [
	^ self asHighlightedTextWrittenWith: [:writer |
		self writeXMLOn: writer]
]

{ #category : #'*XML-ParserGTExtensions' }
XMLNode >> asHighlightedTextWrittenWith: aBlock [
	| writer |

	writer := XMLHighlightingWriter new.
	self escapesContentEntitiesWhenWriting
		ifFalse: [writer escapesContentEntityReferences: false].
	aBlock value: writer.
	^ writer asHighlightedText.
]

{ #category : #'*XML-ParserGTExtensions' }
XMLNode classSide >> gtExampleNodeWithParent [
	<gtExample>
	^ self new parent: self new
]

{ #category : #'*XML-ParserGTExtensions' }
XMLNode >> gtInspectorSourceIn: aComposite inContext: aGTInspector [
	<gtInspectorPresentationOrder: 2>

	| sourceEditor currentTextStylerDecorator |

	sourceEditor :=
		aComposite custom: 
			(self supportsSourceEditing
				ifTrue: [
					GLMRubricHighlightedTextPresentation new
						editingMode: [
							currentTextStylerDecorator :=
								self newSourceEditorTextStylerDecorator.
							GLMHighlighterTextRubEditingMode withStylerDecorator:
								currentTextStylerDecorator];
						act: [
							self
								acceptEditedSource: currentTextStylerDecorator text
								inContext: aGTInspector]
							icon: GLMUIThemeExtraIcons glamorousAccept
							on: $s
							entitled: 'Accept';
						act: [:presentation |
							(presentation hasUnacceptedEdits not
								or: [UIManager default confirm: 'Revert source edits?'])
								ifTrue: [presentation update]]
							icon: GLMUIThemeExtraIcons glamorousUndo
							on: $Z
							entitled: 'Revert';
						act: [
							self promptForSourceSaveFileName
								ifNotEmpty: [:fileName |
									self
										acceptEditedSource: currentTextStylerDecorator text
										inContext: aGTInspector.
									currentTextStylerDecorator saveToFile: fileName]]
							icon: GLMUIThemeExtraIcons glamorousSave
							entitled: 'Save as']
				ifFalse: [
					GLMXMLDisabledRubricHighlightedTextPresentation new
						editingMode: [
							currentTextStylerDecorator :=
								GLMXMLDisabledDocumentHighlighterTextStylerDecorator
									disabledText: self asHighlightedSourceText
									encoding:
										(self document
											ifNil: ['']
											ifNotNil: [:document | document encoding]).
							GLMHighlighterTextRubEditingMode withStylerDecorator:
								currentTextStylerDecorator];
						act: [
							self promptForSourceSaveFileName
								ifNotEmpty: [:fileName |
									currentTextStylerDecorator saveToFile: fileName]]
							icon: GLMUIThemeExtraIcons glamorousSave
							entitled: 'Save as']).

	sourceEditor
		title: 'Source';
		display: [self asHighlightedSourceText];
		withLineNumbers: true.

	self
		addRemoveActionTo: sourceEditor
		in: aComposite
		inContext: aGTInspector.
]

{ #category : #'*XML-ParserGTExtensions' }
XMLNode >> gtInspectorTreeIn: aComposite inContext: aGTInspector [
	<gtInspectorPresentationOrder: 1>

	| treeView |

	treeView :=
		aComposite tree
			title: 'Tree';
			display: [{self}];
			children: [:each | each treeViewChildren];
			format: [:each | each treeViewLabelText];
			when: [self supportsTreeView];
			act: [
				self promptForSourceSaveFileName
					ifNotEmpty: [:fileName |
						self
							printToFileNamed: fileName
							beforeWritingDo: [:writer |
								writer enablePrologPrettyPrinting]]]
				icon: GLMUIThemeExtraIcons glamorousSave
				entitled: 'Save as';
			rootsExpanded.

	self
		addRemoveActionTo: treeView
		in: aComposite
		inContext: aGTInspector
]

{ #category : #'*XML-ParserGTExtensions' }
XMLNode >> newSourceEditorTextStylerDecorator [
	^ GLMXMLOuterXMLDocumentHighlighterTextStylerDecorator outerXMLNode: self
]

{ #category : #'*XML-ParserGTExtensions' }
XMLNode >> promptForSourceSaveFileName [
	^ (UITheme builder
		fileSave: 'Save XML source to file'
		extensions:
			"'xml' must come first so it's the default extension"
			(XMLFileHandle xmlDocumentFileExtensions sorted: [:a :b |
				a = 'xml'
					or: [b ~= 'xml'
						and: [a <= b]]]))
			ifNil: ['']
			ifNotNil: [:reference | reference fullName]
]

{ #category : #'*XML-ParserGTExtensions' }
XMLNode >> removeFromParent [
	self parent removeNode: self
]

{ #category : #'*XML-ParserGTExtensions' }
XMLNode >> setOuterXMLFromEditedSource: aString [
	| oldParent oldPosition oldSize |

	oldParent := self parent.
	oldPosition := oldParent nodes indexOf: self.
	oldSize := oldParent nodes size.
	oldParent
		outerXML: aString
		forNode: self.
	^ oldParent nodes size = oldSize
		ifTrue: [oldParent nodes at: oldPosition]
		ifFalse: [oldParent].
]

{ #category : #'*XML-ParserGTExtensions' }
XMLNode >> supportsRemoveAction [
	^ self hasParent
]

{ #category : #'*XML-ParserGTExtensions' }
XMLNode >> supportsSourceEditing [
	^ self hasParent
		and: [self parent isDocument not]
]

{ #category : #'*XML-ParserGTExtensions' }
XMLNode >> supportsTreeView [
	"returns true if this node needs a tree view tab when inspected"
	^ false
]

{ #category : #'*XML-ParserGTExtensions' }
XMLNode >> treeViewChildren [
	"returns the subnodes of this node in a tree view"
	^ #()
]

{ #category : #'*XML-ParserGTExtensions' }
XMLNode >> treeViewLabelText [
	"the label Text of this node to be used in a tree view"
	^ self asHighlightedTextWrittenWith: [:writer |
		self writeTreeViewLabelXMLOn: writer]
]

{ #category : #'*XML-ParserGTExtensions' }
XMLNode >> writeTreeViewLabelXMLOn: aWriter [
	self writeXMLOn: aWriter
]
