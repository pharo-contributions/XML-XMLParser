Extension { #name : 'XMLElement' }

{ #category : '*XML-Parser-Tools' }
XMLElement >> inspectAttributesIn: specBuilder [
	<inspectorPresentationOrder: 30 title: 'Attributes'>
	
	| builder table |
	builder := (StSimpleInspectorBuilder on: specBuilder).

	self attributes keysAndValuesDo: [:key :value |
			builder key: key value: value
		 ].	
	table := builder table.
	table columns first title: #'Name'.
	table columns second title: #'Value'.
	^ table
	
			
			
]
