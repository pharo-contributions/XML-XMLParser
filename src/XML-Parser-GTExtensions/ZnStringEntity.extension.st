Extension { #name : #ZnStringEntity }

{ #category : #'*XML-Parser-GTExtensions' }
ZnStringEntity >> gtInspectorXmlIn: composite [
	<gtInspectorPresentationOrder: 40>
	| xml |
	xml := [XMLDOMParser parse: self string]
		on: XMLParserException
		do: [ ^ self ].
	(xml gtInspectorTreeIn: composite)
		title: 'XML'
]
