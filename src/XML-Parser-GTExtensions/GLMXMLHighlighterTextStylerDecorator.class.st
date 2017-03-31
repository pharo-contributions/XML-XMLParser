"
An abstract base class for XML highlighter text styler decorators. Subclasses need to implement #highlightingParse:onSuccess:onError: .
"
Class {
	#name : #GLMXMLHighlighterTextStylerDecorator,
	#superclass : #GLMHighlighterTextStylerDecorator,
	#instVars : [
		'highlightableLengthLimit',
		'errorColor',
		'encoding'
	],
	#category : #'XML-Parser-GTExtensions-Highlighting-Parser'
}

{ #category : #accessing }
GLMXMLHighlighterTextStylerDecorator >> defaultStyler [
	^ GLMHighlighterTextParserStyler new
		view: self;
		parser: self
]

{ #category : #accessing }
GLMXMLHighlighterTextStylerDecorator >> encoding [
	^ encoding
]

{ #category : #accessing }
GLMXMLHighlighterTextStylerDecorator >> encoding: anEncodingName [
	encoding := anEncodingName
]

{ #category : #accessing }
GLMXMLHighlighterTextStylerDecorator >> errorColor [
	^ errorColor
]

{ #category : #accessing }
GLMXMLHighlighterTextStylerDecorator >> errorColor: aTextColor [
	errorColor := aTextColor
]

{ #category : #testing }
GLMXMLHighlighterTextStylerDecorator >> hasEncoding [
	^ self encoding notEmpty
]

{ #category : #accessing }
GLMXMLHighlighterTextStylerDecorator >> highlightableLengthLimit [
	^ highlightableLengthLimit
]

{ #category : #accessing }
GLMXMLHighlighterTextStylerDecorator >> highlightableLengthLimit: aLimit [
	highlightableLengthLimit := aLimit
]

{ #category : #private }
GLMXMLHighlighterTextStylerDecorator >> highlightingParse: aString onSuccess: aOneArgumentBlock onError: aTwoArgumentBlock [
	self subclassResponsibility
]

{ #category : #initialization }
GLMXMLHighlighterTextStylerDecorator >> initialize [
	super initialize.

	highlightableLengthLimit := 100000.
	errorColor := TextColor red.
	encoding := ''.
]

{ #category : #parsing }
GLMXMLHighlighterTextStylerDecorator >> parse: aString onError: anError [
	| highlightedText |

	aString size > self highlightableLengthLimit
		ifTrue: [^ aString asText].

	self
		highlightingParse: aString
		onSuccess: [:highlightingParser |
			highlightedText := highlightingParser asHighlightedText.
			encoding := highlightingParser encoding]
		onError: [:highlightingParser :position |
			highlightedText :=
				highlightingParser
					asHighlightedTextWithRemainderColored: self errorColor
					startingAt:
						(position >= aString size
							ifTrue: [1]
							ifFalse: [position]).
			encoding := highlightingParser encoding].

	^ highlightedText.
]

{ #category : #parsing }
GLMXMLHighlighterTextStylerDecorator >> parser [
	^ self
]

{ #category : #files }
GLMXMLHighlighterTextStylerDecorator >> saveToFile: anXMLFileHandleOrFileName [
	| sourceToSave streamConverter |

	sourceToSave := self text asString.
	streamConverter :=
		self hasEncoding
			ifTrue: [self encoding asXMLStreamConverter]
			ifFalse: [XMLStreamConverter default].
	anXMLFileHandleOrFileName asXMLFileHandle writeStreamDo: [:writeStream |
		writeStream
			streamConverter: streamConverter;
			nextPutByteOrderMark;
			nextPutAll: sourceToSave].
]
