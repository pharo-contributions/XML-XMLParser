Extension { #name : #XMLNodeWithChildren }

{ #category : #'*XML-Parser-GTExtensions' }
XMLNodeWithChildren >> addTreeViewChildrenTo: aSequenceableCollection [
	self nodesDo: [:each |
		aSequenceableCollection addLast: each]
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLNodeWithChildren >> requiresTreeView [
	^ self hasChildren
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLNodeWithChildren >> treeViewChildren [
	self requiresTreeView
		ifTrue: [| treeViewChildren |
			treeViewChildren := OrderedCollection new: self nodes size.
			self addTreeViewChildrenTo: treeViewChildren.
			^ treeViewChildren]
		ifFalse: [^ #()]
]
