Extension { #name : #XMLDoctypeDeclaration }

{ #category : #'*XML-ParserGTExtensions' }
XMLDoctypeDeclaration >> removeFromParent [
	self parent doctypeDeclaration: nil
]

{ #category : #'*XML-ParserGTExtensions' }
XMLDoctypeDeclaration >> supportsSourceEditing [
	^ false
]

{ #category : #'*XML-ParserGTExtensions' }
XMLDoctypeDeclaration >> writeTreeViewLabelXMLOn: aWriter [
	aWriter doctype
		root: self root;
		publicID: self publicID;
		systemID: self systemID;
		write
]
