Class {
	#name : #GLMXMLOuterXMLDocumentHighlighterTextStylerDecorator,
	#superclass : #GLMXMLDocumentHighlighterTextStylerDecorator,
	#instVars : [
		'outerXMLNode'
	],
	#category : #'XML-Parser-GTExtensions-Highlighting-Parser'
}

{ #category : #private }
GLMXMLOuterXMLDocumentHighlighterTextStylerDecorator class >> outerXMLNode: aNode [
	^ self new outerXMLNode: aNode
]

{ #category : #private }
GLMXMLOuterXMLDocumentHighlighterTextStylerDecorator >> newHighlightingParserFromHandler: aHighlightingParserHandler [
	| parser rootElement |

	parser := super newHighlightingParserFromHandler: aHighlightingParserHandler.

	self outerXMLNode document
		ifNotNil: [:document |
			parser driver isStandalone: document isStandalone.
			document hasDoctypeDefinition
				ifTrue: [
					parser driver doctypeDefinition
						addGeneralEntitiesFrom: document doctypeDefinition]].

	self outerXMLNode isElement
		ifTrue: [rootElement := self outerXMLNode]
		ifFalse: [
			(self outerXMLNode hasParent
				and: [self outerXMLNode parent isElement])
				ifTrue: [rootElement := self outerXMLNode parent]].
	rootElement
		ifNotNil: [
			parser driver currentElement: rootElement name.
			rootElement hasNamespaces
				ifTrue: [parser driver currentScope: rootElement namespaceScope]].

	^ parser.
]

{ #category : #private }
GLMXMLOuterXMLDocumentHighlighterTextStylerDecorator >> newHighlightingParserHandlerOn: aString [
	^ (super newHighlightingParserHandlerOn: aString)
		configuration: self outerXMLNode configuration copy
]

{ #category : #accessing }
GLMXMLOuterXMLDocumentHighlighterTextStylerDecorator >> outerXMLNode [
	^ outerXMLNode
]

{ #category : #accessing }
GLMXMLOuterXMLDocumentHighlighterTextStylerDecorator >> outerXMLNode: aNode [
	outerXMLNode := aNode
]