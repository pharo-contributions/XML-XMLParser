Extension { #name : #XMLDocument }

{ #category : #'*XML-Parser-GTExtensions' }
XMLDocument >> addTreeViewChildrenTo: aSequenceableCollection [
	self hasDoctypeDeclaration
		ifTrue: [aSequenceableCollection addLast: self doctypeDeclaration].
	super addTreeViewChildrenTo: aSequenceableCollection.
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLDocument classSide >> gtExampleXmlNode [
	<gtExample>
	^ XMLDOMParser parse: '<document><a></a><b></b></document>'
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLDocument >> requiresTreeView [
	^ self hasDoctypeDeclaration
		or: [super requiresTreeView]
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLDocument >> writeTreeViewLabelXMLOn: aWriter [
	self writeXMLDeclarationOn: aWriter
]
