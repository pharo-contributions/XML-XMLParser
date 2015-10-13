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
	<gtInspectorPresentationOrder: 40>

	"removed unfinished source panel editing support for now"
	composite text 
		title: 'Source';
		format: #asHighlightedText
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLNode >> gtInspectorTreeIn: composite [
	<gtInspectorPresentationOrder: 40>
	^ composite tree
		title: 'Tree';
		display: [ {self} ];
		children: #treeNodeChildren;
		format: #treeNodeLabelText;
		when: [self hasTreeNodeChildren];
		rootsExpanded
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLNode >> hasTreeNodeChildren [
	^ self hasChildren
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLNode >> treeNodeChildren [
	^ #()
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLNode >> treeNodeLabelText [
	^ self asHighlightedTextWrittenWith: [:writer | self writeTreeNodeLabelXMLOn: writer]
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLNode >> writeTreeNodeLabelXMLOn: aWriter [
	self writeXMLOn: aWriter
]
