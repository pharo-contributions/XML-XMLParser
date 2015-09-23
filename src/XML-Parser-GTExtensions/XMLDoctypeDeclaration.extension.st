Extension { #name : #XMLDoctypeDeclaration }

{ #category : #'*XML-Parser-GTExtensions' }
XMLDoctypeDeclaration >> treeNodeLabelText [
	| writer |

	(writer := XMLHighlightingWriter new) lineBreak: ''.
	writer doctype
		root: self root;
		publicID: self publicID;
		systemID: self systemID.
	^ writer asHighlightedText.
]
