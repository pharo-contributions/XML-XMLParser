Extension { #name : #XMLDoctypeDeclaration }

{ #category : #'*XML-Explorer' }
XMLDoctypeDeclaration >> writeExplorerLabelXMLOn: aWriter [
	aWriter doctype
		root: self root;
		publicID: self publicID;
		systemID: self systemID;
		write
]
