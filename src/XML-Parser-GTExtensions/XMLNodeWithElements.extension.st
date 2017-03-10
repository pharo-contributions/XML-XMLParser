Extension { #name : #XMLNodeWithElements }

{ #category : #'*XML-Parser-GTExtensions' }
XMLNodeWithElements >> addTreeViewChildrenTo: aSequenceableCollection [
	self nodesDo: [:each |
		(each isStringNode
			and: [each isEmpty
				or: [each isWhitespace]])
			ifFalse: [aSequenceableCollection addLast: each]]
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLNodeWithElements classSide >> gtExampleXmlNode [
	<gtExample>
	^ XMLDocument gtExampleXmlNode nodes
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLNodeWithElements >> requiresTreeView [
	^ self hasChildren
		and: [self nodes size > 1
			or: [self firstNode isStringNode not]]
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLNodeWithElements >> spotterForAllElementsFor: aStep [
	<spotterOrder: 40>
	aStep listProcessor
		title: 'All elements';
		allCandidates: [self allElements];
		itemName: #gtDisplayString;
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLNodeWithElements >> spotterForDirectElementsFor: aStep [
	<spotterOrder: 40>
	aStep listProcessor
		title: 'Direct elements';
		allCandidates: [self elements];
		itemName: #gtDisplayString;
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLNodeWithElements >> spotterPreviewSourceIn: aComposite [
	<spotterPreview: 10>
	
	aComposite text
		title: 'Source';
		display: [
			self asHighlightedTextWrittenWith: [:writer |
				"use less indent for spotter previews"
				writer formatter indentString: '  '.
				self writeXMLOn: writer]];
		entity: self
]
