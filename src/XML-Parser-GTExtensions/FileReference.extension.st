Extension { #name : #FileReference }

{ #category : #'*XML-Parser-GTExtensions' }
FileReference >> gtInspectorXMLFileIn: composite [
	<gtInspectorPresentationOrder: 40>

	self isXMLFile
		ifFalse: [^ self].
	
	composite custom:
		(GLMRubricHighlightedTextPresentation new
			title: 'Source';
			editingMode: [
				GLMHighlighterTextRubEditingMode withStylerDecorator:
					GLMXMLHighlighterTextStylerDecorator new];
			display: [XMLPositionExternalStreamConverter convert: self readStream];
			act: [:presentation | 
					self
						ensureDelete;
						writeStreamDo: [:stream |
							stream nextPutAll: presentation text asString]]
				icon: GLMUIThemeExtraIcons glamorousSave 
				on: $s 
				entitled: 'Save')
]

{ #category : #'*XML-Parser-GTExtensions' }
FileReference >> isXMLFile [
	^ #('xml' 'xhtml') includes: self extension asLowercase
]

{ #category : #'*XML-Parser-GTExtensions' }
FileReference >> spotterForXMLFileFor: aStep [
	<spotterOrder: 40>

	self isXMLFile
		ifFalse: [^ self].

	aStep listProcessor
		title: 'XML Document';
		allCandidates: [(XMLDOMParser parse: self readStream) allElements];
		itemName: #gtDisplayString;
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #'*XML-Parser-GTExtensions' }
FileReference >> spotterPreviewXMLFileIn: aComposite [
	<spotterPreview: 10>

	self isXMLFile
		ifFalse: [^ self].

	aComposite text
		title: 'Source';
		display: [
			XMLHighlightingParser parse:
				(XMLPositionExternalStreamConverter convert: self readStream)];
		entity: self.
]
