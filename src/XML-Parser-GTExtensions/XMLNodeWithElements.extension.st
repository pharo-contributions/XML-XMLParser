Extension { #name : #XMLNodeWithElements }

{ #category : #'*XML-Parser-GTExtensions' }
XMLNodeWithElements classSide >> gtExampleXmlNode [
	<gtExample>
	^ XMLDocument gtExampleXmlNode nodes
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLNodeWithElements >> gtSpotterAllElementsFor: aStep [
	<spotterOrder: 40>
	aStep listProcessor
		title: 'All elements';
		allCandidates: [ self allElements ];
		itemName: [ :element | element gtDisplayString ];
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLNodeWithElements >> gtSpotterDirectElementsFor: aStep [
	<spotterOrder: 40>
	aStep listProcessor
		title: 'Direct elements';
		allCandidates: [ self elements ];
		itemName: [ :element | element gtDisplayString ];
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLNodeWithElements >> spotterPreviewSourceIn: aComposite [
	<spotterPreview: 10>
	
	aComposite text
		title: 'Source';
		display: [ :anElement | self prettyPrinted ];
		entity: self
]
