"
A highlighting XML document text style decorator for editing the ""outer"" XML of a document or document node.
"
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
	| parser rootElement context |

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

	(context := self outerXMLNode parent newInnerXMLContext) isContentContext
		ifTrue: [aHighlightingParserHandler startContent].
	parser context: context.

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
