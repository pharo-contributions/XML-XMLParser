Extension { #name : #FileReference }

{ #category : #'*XML-Parser-GTExtensions' }
FileReference >> gtInspectorXMLFileIn: aComposite [
	<gtInspectorPresentationOrder: 4>

	| currentTextStylerDecorator |

	self isXMLFile
		ifFalse: [^ self].

	aComposite custom:
		(GLMRubricHighlightedTextPresentation new
			title: 'Source';
			editingMode: [
				"saved to get the encoding later"
				currentTextStylerDecorator := GLMXMLHighlighterTextStylerDecorator new.
				GLMHighlighterTextRubEditingMode withStylerDecorator: currentTextStylerDecorator];
			display: [XMLExternalDocumentConverter convertFileNamed: self fullName];
			withLineNumbers: true;
			act: [:presentation | | sourceToSave streamConverter |
				sourceToSave := presentation text asString.
				streamConverter := currentTextStylerDecorator encoding asXMLStreamConverter.
				self fullName asXMLFileHandle writeStreamDo: [:writeStream |
					writeStream
						streamConverter: streamConverter;
						nextPutByteOrderMark;
						nextPutAll: sourceToSave].
				presentation clearUserEdits]
				icon: GLMUIThemeExtraIcons glamorousSave
				on: $s
				entitled: 'Save').
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
		allCandidates: [(XMLDOMParser parseFileNamed: self fullName) allElements];
		itemName: #gtDisplayString;
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true.
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
				(XMLExternalDocumentConverter convertFileNamed: self fullName)];
		entity: self.
]
