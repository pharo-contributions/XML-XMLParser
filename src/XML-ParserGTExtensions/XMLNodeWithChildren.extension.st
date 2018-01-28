Extension { #name : #XMLNodeWithChildren }

{ #category : #'*XML-ParserGTExtensions' }
XMLNodeWithChildren >> addTreeViewChildrenTo: anOrderedCollection [
	self nodesDo: [:each |
		anOrderedCollection addLast: each]
]

{ #category : #'*XML-ParserGTExtensions' }
XMLNodeWithChildren >> supportsTreeView [
	^ self hasChildren
]

{ #category : #'*XML-ParserGTExtensions' }
XMLNodeWithChildren >> treeViewChildren [
	self supportsTreeView
		ifTrue: [| treeViewChildren |
			treeViewChildren := OrderedCollection new: self nodes size.
			self addTreeViewChildrenTo: treeViewChildren.
			^ treeViewChildren]
		ifFalse: [^ #()]
]
