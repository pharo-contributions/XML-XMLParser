Extension { #name : #XMLNodeWithChildren }

{ #category : #'*XML-Explorer' }
XMLNodeWithChildren >> addExplorerContentsTo: aSequenceableCollection [
	self nodesDo: [:each |
		aSequenceableCollection addLast:
			(ObjectExplorerWrapper
				with: each
				name: (each explorerLabel contractTo: 32)
				model: self)].
]

{ #category : #'*XML-Explorer' }
XMLNodeWithChildren >> explorerContents [
	self hasExplorerContents
		ifTrue: [| contents |
			contents := OrderedCollection new: self nodes size.
			self addExplorerContentsTo: contents.
			^ contents]
		ifFalse: [^ #()].
]

{ #category : #'*XML-Explorer' }
XMLNodeWithChildren >> hasExplorerContents [
	^ self hasChildren
]
