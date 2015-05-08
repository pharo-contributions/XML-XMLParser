Extension { #name : #XMLDocument }

{ #category : #'*XML-Parser-GTExtensions' }
XMLDocument classSide >> gtExampleXmlNode [
	<gtExample>
	^ XMLDOMParser parse: '<document><a></a><b></b></document>'
]
