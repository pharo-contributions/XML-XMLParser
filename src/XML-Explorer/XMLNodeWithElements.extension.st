Extension { #name : #XMLNodeWithElements }

{ #category : #'*XML-Explorer' }
XMLNodeWithElements >> addExplorerContentsTo: aSequenceableCollection [
	self nodesDo: [:each |
		(each isStringNode
			and: [each isEmpty
				or: [each isWhitespace]])
			ifFalse: [
				aSequenceableCollection addLast:
					(ObjectExplorerWrapper
						with: each
						name: (each explorerLabel contractTo: 32)
						model: self)]].
]

{ #category : #'*XML-Explorer' }
XMLNodeWithElements >> hasExplorerContents [
	^ self hasChildren
		and: [
			self nodes anySatisfy: [:each |
				each isStringNode not
					or: [each isEmpty not
						or: [each isWhitespace not]]]]
]
