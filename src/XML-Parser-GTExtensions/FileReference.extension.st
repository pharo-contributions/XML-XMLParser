Extension { #name : #FileReference }

{ #category : #'*XML-Parser-GTExtensions' }
FileReference >> gtInspectorXMLFileIn: aComposite [
	<gtInspectorPresentationOrder: 4>

	| xmlFileHandle currentTextStylerDecorator |

	xmlFileHandle := XMLFileSystemFileHandle fileReference: self.
	xmlFileHandle isXMLDocumentFile
		ifFalse: [^ self].

	aComposite custom:
		(GLMRubricHighlightedTextPresentation new
			title: 'Source';
			editingMode: [
				"saved to get the encoding later"
				currentTextStylerDecorator :=
					GLMXMLDocumentHighlighterTextStylerDecorator new.
				GLMHighlighterTextRubEditingMode withStylerDecorator:
					currentTextStylerDecorator];
			display: [
				XMLExternalDocumentConverter convert: xmlFileHandle rawReadStream];
			withLineNumbers: true;
			act: [:presentation |
				currentTextStylerDecorator saveToFile: xmlFileHandle.
				presentation pane update]
				icon: GLMUIThemeExtraIcons glamorousSave
				on: $s
				entitled: 'Save';
			act: [:presentation | presentation pane update]
				icon: GLMUIThemeExtraIcons glamorousUndo
				on: $Z
				entitled: 'Revert';
			selectionAct: [:presentation |
				presentation selection:
					(XMLDOMParser parse:
						(presentation selectedText asString
							ifEmpty: [presentation text asString]))]
				on: $g
				entitled: 'Parse and go';
			act: [:presentation |
				presentation selection:
					(XMLDOMParser parse: presentation text asString)]
				icon: GLMUIThemeExtraIcons glamorousGo
				on: $G
				entitled: 'Parse all and go').
]

{ #category : #'*XML-Parser-GTExtensions' }
FileReference >> spotterForXMLFileFor: aStep [
	<spotterOrder: 40>

	| xmlFileHandle |

	xmlFileHandle := XMLFileSystemFileHandle fileReference: self.
	xmlFileHandle isXMLDocumentFile
		ifFalse: [^ self].

	aStep listProcessor
		title: 'XML Document';
		allCandidates: [
			(XMLDOMParser parse: xmlFileHandle rawReadStream) allElements];
		itemName: #gtDisplayString;
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true.
]

{ #category : #'*XML-Parser-GTExtensions' }
FileReference >> spotterPreviewXMLFileIn: aComposite [
	<spotterPreview: 10>

	| xmlFileHandle |

	xmlFileHandle := XMLFileSystemFileHandle fileReference: self.
	xmlFileHandle isXMLDocumentFile
		ifFalse: [^ self].

	aComposite text
		title: 'Source';
		display: [
			"the source is converted to a decoded string and then highlighted"
			XMLHighlightingParser parse:
				(XMLExternalDocumentConverter convert: xmlFileHandle rawReadStream)];
		entity: self.
]
