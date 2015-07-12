Extension { #name : #XMLNodeWithElements }

{ #category : #'*XML-Parser-GTExtensions' }
XMLNodeWithElements >> gtDisplayOn: stream [
	stream nextPutAll: self name
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLNodeWithElements classSide >> gtExampleXmlNode [
	<gtExample>
	^ XMLDocument gtExampleXmlNode nodes
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLNodeWithElements >> gtInspectorSourceIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite text 
		title: 'Source';
		acceptsSelection: true;
		display: [
			self hasParent
				ifTrue: [self prettyPrinted ]
				ifFalse: [self innerXMLPrettyPrinted] ];
		act: [:presentation |
			self hasParent
				ifTrue: [| oldParent oldIndex |
					oldParent := self parent.
					oldIndex := oldParent nodes indexOf: self.
					oldParent
						outerXML: presentation text
						forNode: self.
					composite entity: (oldParent nodeAt: oldIndex)]
				ifFalse: [self innerXML: presentation text].
			composite update]
		icon: GLMUIThemeExtraIcons glamorousAccept
		on: $s 
		entitled: 'Save'
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLNodeWithElements >> gtInspectorTreeIn: composite [
	<gtInspectorPresentationOrder: 40>
	^ composite tree 
		title: 'Tree';
		display: [ { self } ];
		children: #elements;
		format: #gtDisplayString;
		when: [self hasElements];
		rootsExpanded
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLNodeWithElements >> gtName [
	^ ''
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLNodeWithElements >> gtSpotterElementsFor: aStep [
	<spotterOrder: 40>
	aStep listProcessor
		title: 'All elements';
		allCandidates: [ self allElements ];
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
