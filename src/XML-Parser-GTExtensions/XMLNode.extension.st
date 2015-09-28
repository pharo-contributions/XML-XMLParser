Extension { #name : #XMLNode }

{ #category : #'*XML-Parser-GTExtensions' }
XMLNode >> asHighlightedSpotterText [
	^ XMLHighlightingWriter new
		writeWith: [:writer |
			writer formatter indentString: '  '.
			self writeXMLOn: writer];
		asHighlightedText
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLNode >> asHighlightedText [
	^ XMLHighlightingWriter new
		writeWith: [:writer | self writeXMLOn: writer];
		asHighlightedText
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
	^ self asHighlightedText
]
