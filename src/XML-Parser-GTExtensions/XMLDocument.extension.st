Extension { #name : #XMLDocument }

{ #category : #'*XML-Parser-GTExtensions' }
XMLDocument classSide >> gtExampleXmlNode [
	<gtExample>
	^ XMLDOMParser parse: '<document><a></a><b></b></document>'
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLDocument >> hasTreeNodeChildren [
	^ self hasChildren
		or: [self hasDoctypeDeclaration]
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLDocument >> treeNodeChildren [
	self hasDoctypeDeclaration
		ifTrue: [^ self nodes copyWithFirst: self doctypeDeclaration]
		ifFalse: [^ self nodes]
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLDocument >> writeTreeNodeLabelXMLOn: aWriter [
	self writeXMLDeclarationOn: aWriter
]
