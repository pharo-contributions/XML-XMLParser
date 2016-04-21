Extension { #name : #XMLNodeWithChildren }

{ #category : #'*XML-Parser-GTExtensions' }
XMLNodeWithChildren >> requiresTreeView [
	^ self hasChildren
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLNodeWithChildren >> treeViewChildren [
	self hasChildren
		ifTrue: [^ self nodes]
		ifFalse: [^ #()]
]
