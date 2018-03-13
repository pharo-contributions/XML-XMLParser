Extension { #name : #XMLNFAState }

{ #category : #'*XML-ParserGTExtensions' }
XMLNFAState >> gtInspectorTreeIn: aComposite [
	<gtInspectorPresentationOrder: 1>

	aComposite tree
		title: 'Tree';
		display: [{self}];
		children: [:each | each treeViewChildren];
		format: [:each | each treeViewLabelText];
		when: [self supportsTreeView];
		"these two features need to be disabled, because we're modeling a
		cyclic directed graph as a tree, and the tree presentation will
		loop in #pathIn: otherwise"
		shouldValidate: false;
		allowsRecursiveSearch: false;
		rootsExpanded
]

{ #category : #'*XML-ParserGTExtensions' }
XMLNFAState >> supportsTreeView [
	self nextStatesDo: [:each |
		^ true].
	^ false.
]

{ #category : #'*XML-ParserGTExtensions' }
XMLNFAState >> treeViewChildren [
	| nextStates |

	nextStates := #().
	self nextStatesDo: [:each |
		nextStates := nextStates copyWith: each].
	^ nextStates.
]

{ #category : #'*XML-ParserGTExtensions' }
XMLNFAState >> treeViewLabelText [
	^ (String streamContents: [:stream |
		stream
			nextPutAll: self class name asString;
			nextPut: $(.
		self printLabelOn: stream.
		stream nextPut: $)]) asText
]
