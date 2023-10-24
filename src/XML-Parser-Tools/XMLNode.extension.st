Extension { #name : #XMLNode }

{ #category : #'*XML-Parser-Tools' }
XMLNode >> inspectSourceIn: specBuilder [
	<inspectorPresentationOrder: 29 title: 'Source'>
	
	^ specBuilder newText
		text: self asString;
		yourself
]

{ #category : #'*XML-Parser-Tools' }
XMLNode >> inspectTreeIn: specBuilder [
	<inspectorPresentationOrder: 28 title: 'Tree'>
	
	| roots |
	roots := self isDocument ifTrue: [ (Array with: self root) ] ifFalse: [ (Array with: self) ].
	^ specBuilder newTree
		roots: roots;
		display: [ :aNode | 
			self inspectorTreeStringFor: aNode 			
			];
"		displayIcon: [ :aNode | aNode iconName ifNotNil: [ :aName | self iconNamed: aName ] ];"
		children: [ :aNode |  aNode descendantElements ]
		
 
]

{ #category : #'*XML-Parser-Tools' }
XMLNode >> inspectorTreeStringFor: anXMLElement [
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
