Extension { #name : 'XMLNode' }

{ #category : '*XML-Parser-Tools' }
XMLNode >> inspectSourceIn: specBuilder [
	<inspectorPresentationOrder: 29 title: 'Source'>
	
	^ specBuilder newText
		text: self asString;
		yourself
]

{ #category : '*XML-Parser-Tools' }
XMLNode >> inspectTreeIn: specBuilder [

	<inspectorPresentationOrder: 28 title: 'Tree'>
	| roots |
	roots := self inspectorRoots.
	^ specBuilder newTree
		  roots: roots;
		  display: [ :aNode | self inspectorTreeStringFor: aNode ];
		  "	displayIcon: [ :aNode | aNode iconName ifNotNil: [ :aName | self iconNamed: aName ] ];"
		  children: [ :aNode | aNode elements ];
		  expandRoots
]

{ #category : '*XML-Parser-Tools' }
XMLNode >> inspectorRoots [

	^ Array with: self
]

{ #category : '*XML-Parser-Tools' }
XMLNode >> inspectorTreeStringFor: anXMLElement [

	anXMLElement hasElements ifFalse: [ ^ anXMLElement asString ].
	^ String streamContents: [ :s |
		  s
			  nextPut: $<;
			  nextPutAll: anXMLElement name.
		  anXMLElement hasAttributes ifTrue: [
			  anXMLElement attributes associations do: [ :association |
				  s
					  space;
					  nextPutAll: association key;
					  nextPutAll: '="';
					  nextPutAll: association value;
					  nextPutAll: '"' ] ].
		  s nextPut: $> ]
]
