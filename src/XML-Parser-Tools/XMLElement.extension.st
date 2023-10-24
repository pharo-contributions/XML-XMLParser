Extension { #name : #XMLElement }

{ #category : #'*XML-Parser-Tools' }
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

{ #category : #'*XML-Parser-Tools' }
XMLElement >> inspectTreeIn: specBuilder [
	<inspectorPresentationOrder: 28 title: 'Tree'>
	
	^ specBuilder newTree
		roots: (Array with: self);
		display: [ :aNode | 
			self inspectorTreeStringFor: aNode 			
			];
"		displayIcon: [ :aNode | aNode iconName ifNotNil: [ :aName | self iconNamed: aName ] ];"
		children: [ :aNode |  aNode descendantElements ]
		
 
]

{ #category : #'*XML-Parser-Tools' }
XMLElement >> inspectorTreeStringFor: anXMLElement [
	| display |
	display := String streamContents: [:s| 
		s nextPutAll: anXMLElement name. 
		anXMLElement hasAttributes ifTrue: [ 
			s space.
			anXMLElement attributes associations do: [:association |
				s 
				  nextPutAll: association key;
				  nextPutAll: '="';
				  nextPutAll: association value;				
				  nextPutAll: '"'.								
			] separatedBy: [ s space ]	
		]
	].
	anXMLElement descendantElements isEmpty ifFalse: [ ^ '<',display, '>' ].
	^ anXMLElement asString
]
