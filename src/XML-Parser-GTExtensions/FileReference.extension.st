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
					GLMXMLHighlighterTextStylerDecorator new.
				GLMHighlighterTextRubEditingMode withStylerDecorator:
					currentTextStylerDecorator];
			display: [
				XMLExternalDocumentConverter convert: xmlFileHandle rawReadStream];
			withLineNumbers: true;
			act: [:presentation | | sourceToSave streamConverter |
				sourceToSave := presentation text asString.
				streamConverter :=
					currentTextStylerDecorator hasEncoding
						ifTrue: [currentTextStylerDecorator encoding asXMLStreamConverter]
						ifFalse: [XMLStreamConverter default].
				xmlFileHandle writeStreamDo: [:writeStream |
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
