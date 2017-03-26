Extension { #name : #ZnStringEntity }

{ #category : #'*XML-Parser-GTExtensions' }
ZnStringEntity >> gtInspectorXMLIn: composite [
	<gtInspectorPresentationOrder: 40>
	| document |

	[document := XMLDOMParser parse: self string]
		on: XMLParserException
		do: [^ self].
	(document gtInspectorTreeIn: composite)
		title: 'XML'
]
