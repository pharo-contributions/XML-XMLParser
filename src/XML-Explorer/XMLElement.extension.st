Extension { #name : #XMLElement }

{ #category : #'*XML-Explorer' }
XMLElement >> writeExplorerLabelXMLOn: aWriter [
	(self hasExplorerContents
		ifTrue: [aWriter startTag]
		ifFalse: [aWriter tag])
			name: self name;
			"uses setAttributes: for performance"
			setAttributes: attributes
]
