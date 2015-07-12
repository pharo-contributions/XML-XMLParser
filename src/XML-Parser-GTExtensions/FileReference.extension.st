Extension { #name : #FileReference }

{ #category : #'*XML-Parser-GTExtensions' }
FileReference >> gtSpotterXMLDocumentFor: aStep [
	<spotterOrder: 40>
	self extension = 'xml' ifFalse: [ ^ self ].
	aStep listProcessor
		title: 'XML document';
		allCandidates: [ { XMLDOMParser parse: self } ];
		itemName: [ :element | element gtDisplayString ];
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]
