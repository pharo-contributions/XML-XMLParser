Extension { #name : #XMLInternalSubsetList }

{ #category : #'*XML-ParserGTExtensions' }
XMLInternalSubsetList >> gtInspectorItemsIn: aComposite [
	^ self
		addOrderedListTableToComposite: aComposite
		paneTitle: 'Nodes'
		columnTitle: 'Node'
]
