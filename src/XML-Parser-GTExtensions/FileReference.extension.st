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
				"saved to get the converter later"
				currentTextStylerDecorator := GLMXMLHighlighterTextStylerDecorator new.
				GLMHighlighterTextRubEditingMode withStylerDecorator: currentTextStylerDecorator];
			display: [XMLPositionExternalStreamConverter convert: self readStream];
			withLineNumbers: true;
			act: [:presentation | | outputConverter outputString |
					"can raise exceptions so must be called before deleting"
					outputConverter := currentTextStylerDecorator converter.
					outputString := presentation text asString.
					self
						ensureDelete;
						writeStreamDo: [:stream |
							outputConverter
								ifNotNil: [stream converter: outputConverter].
							stream nextPutAll: outputString]]
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
