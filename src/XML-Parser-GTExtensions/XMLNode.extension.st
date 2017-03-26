Extension { #name : #XMLNode }

{ #category : #'*XML-Parser-GTExtensions' }
XMLNode >> asHighlightedText [
	^ self asHighlightedTextWrittenWith: [:writer |
		self writeXMLOn: writer]
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLNode >> asHighlightedTextWrittenWith: aBlock [
	| writer |

	writer := XMLHighlightingWriter new.
	self escapesContentEntitiesWhenWriting
		ifFalse: [writer escapesContentEntityReferences: false].
	aBlock value: writer.
	^ writer asHighlightedText.
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLNode classSide >> gtExampleNodeWithParent [
	<gtExample>
	^ self new parent: self new
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLNode >> gtInspectorSourceIn: aComposite inContext: aGTInspector [
	<gtInspectorPresentationOrder: 6>

	aComposite custom:
		(self supportsSourceEditing
			ifTrue: [
				GLMRubricHighlightedTextPresentation new
					title: 'Source';
					editingMode: [
						GLMHighlighterTextRubEditingMode withStylerDecorator:
							self newSourceEditorTextStylerDecorator];
					display: [self asHighlightedText];
					withLineNumbers: true;
					act: [:presentation |
						| newOuterXMLNode currentPane |
						newOuterXMLNode :=
							self outerXMLFromEditedSource:
								presentation text asString.
						currentPane := aComposite pane.
						(aGTInspector panes copyUpTo: currentPane)
							ifEmpty: [
								"no previous panes; delete any panes after the current
								and make its selection the new outer XML node (closing
								and reopening is a hack but it works for now)"
								aGTInspector browser close.
								aGTInspector openOn: newOuterXMLNode]
							ifNotEmpty: [:previousPanes |
								"update all previous panes and replace the current
								pane one selecting the new outer XML node"
								previousPanes do: [:each | each update].
								previousPanes last presentations first
									selection: newOuterXMLNode]]
						icon: GLMUIThemeExtraIcons glamorousAccept
						on: $s
						entitled: 'Save']
			ifFalse: [
				GLMXMLDisabledRubricHighlightedTextPresentation new
					title: 'Source';
					editingMode: [
						GLMHighlighterTextRubEditingMode withStylerDecorator:
							(GLMXMLDisabledDocumentHighlighterTextStylerDecorator
								disabledText: self asHighlightedText)];
					display: [self asHighlightedText];
					withLineNumbers: true])
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLNode >> gtInspectorTreeIn: aComposite [
	<gtInspectorPresentationOrder: 5>

	^ aComposite tree
		title: 'Tree';
		display: [ {self} ];
		children: #treeViewChildren;
		format: #treeViewLabelText;
		when: [self supportsTreeView];
		rootsExpanded
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLNode >> newSourceEditorTextStylerDecorator [
	^ GLMXMLOuterXMLDocumentHighlighterTextStylerDecorator outerXMLNode: self
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLNode >> outerXMLFromEditedSource: aString [
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

{ #category : #'*XML-Parser-GTExtensions' }
XMLNode >> supportsSourceEditing [
	^ self hasParent
		and: [self parent isDocument not]
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLNode >> supportsTreeView [
	"returns true if this node needs a tree view tab when inspected"
	^ false
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLNode >> treeViewChildren [
	"returns the subnodes of this node in a tree view"
	^ #()
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLNode >> treeViewLabelText [
	"the label Text of this node to be used in a tree view"
	^ self asHighlightedTextWrittenWith: [:writer |
		self writeTreeViewLabelXMLOn: writer]
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLNode >> writeTreeViewLabelXMLOn: aWriter [
	self writeXMLOn: aWriter
]
