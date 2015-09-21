Extension { #name : #XMLDocument }

{ #category : #'*XML-Parser-GTExtensions' }
XMLDocument classSide >> gtExampleXmlNode [
	<gtExample>
	^ XMLDOMParser parse: '<document><a></a><b></b></document>'
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLDocument >> treeLabelText [
	| writer |

	writer := XMLHighlightingWriter new.
	self writeXMLDeclarationOn: writer.
	^ writer asHighlightedText.
]
