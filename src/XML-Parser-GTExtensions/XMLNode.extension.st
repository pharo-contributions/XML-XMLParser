Extension { #name : #XMLNode }

{ #category : #'*XML-Parser-GTExtensions' }
XMLNode >> asHighlightedText [
	^ self asHighlightedTextWrittenWith: [:writer | self writeXMLOn: writer]
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
XMLNode >> gtInspectorSourceIn: composite [
	<gtInspectorPresentationOrder: 6>

	"removed unfinished source panel editing support for now"
	composite text
		title: 'Source';
		format: #asHighlightedText
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLNode >> gtInspectorTreeIn: composite [
	<gtInspectorPresentationOrder: 5>
	^ composite tree
		title: 'Tree';
		display: [ {self} ];
		children: #treeViewChildren;
		format: #treeViewLabelText;
		when: [self requiresTreeView];
		rootsExpanded
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLNode >> requiresTreeView [
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
