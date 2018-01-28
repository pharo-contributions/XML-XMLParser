Extension { #name : #XMLAttributeList }

{ #category : #'*XML-ParserGTExtensions' }
XMLAttributeList >> gtInspectorItemsIn: aComposite [
	^ self
		addOrderedListTableToComposite: aComposite
		paneTitle: 'Attributes'
		columnTitle: 'Attribute'
]
