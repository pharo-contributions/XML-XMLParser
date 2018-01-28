Extension { #name : #XMLNodeList }

{ #category : #'*XML-ParserGTExtensions' }
XMLNodeList >> gtInspectorItemsIn: aComposite [
	^ self
		addOrderedListTableToComposite: aComposite
		paneTitle: 'Nodes'
		columnTitle: 'Node'
]
