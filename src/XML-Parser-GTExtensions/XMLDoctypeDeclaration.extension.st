Extension { #name : #XMLDoctypeDeclaration }

{ #category : #'*XML-Parser-GTExtensions' }
XMLDoctypeDeclaration >> writeTreeViewLabelXMLOn: aWriter [
	| oldLineBreak |

	"suppress blank line after doctype"
	oldLineBreak := aWriter lineBreak.
	aWriter lineBreak: ''.

	aWriter doctype
		root: self root;
		publicID: self publicID;
		systemID: self systemID;
		write.

	aWriter lineBreak: oldLineBreak.
]
