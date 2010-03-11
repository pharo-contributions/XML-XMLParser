"
XMLDOMParser parses XML into a tree of XML nodes representing the document structure. To see what kinds of nodes it produces and what can be done with them, browse XML-Parser-Nodes.
"
Class {
	#name : #XMLDOMParser,
	#superclass : #SAXHandler,
	#instVars : [
		'document',
		'entity',
		'stack',
		'incremental'
	],
	#category : #'XML-Parser-Parser'
}

{ #category : #content }
XMLDOMParser >> characters: aString [
	self top addContent: aString

]

{ #category : #accessing }
XMLDOMParser >> document [
	^ document
]

{ #category : #accessing }
XMLDOMParser >> document: aDocument [
	document := aDocument
]

{ #category : #content }
XMLDOMParser >> documentAttributes: attributeList [
	self document version: (attributeList at: 'version' ifAbsent: [nil]).
	self document encoding: (attributeList at: 'encoding' ifAbsent: [nil]).
	self document requiredMarkup: (attributeList at: 'requiredMarkup' ifAbsent: [nil]).

]

{ #category : #parsing }
XMLDOMParser >> domDocument [
	[self parseDocument] ensure: [self driver stream close].

	^ document.
]

{ #category : #content }
XMLDOMParser >> endDocument [
	self pop.
	super endDocument
]

{ #category : #content }
XMLDOMParser >> endElement: localName qualifiedName: qualifiedName prefix: prefix uri: namespaceUri [
	| currentElement |
	currentElement := self pop.
	(currentElement qualifiedName = qualifiedName)
		ifFalse: [
			self
				errorExpectedEndTag: currentElement qualifiedName
				butGot: qualifiedName]
]

{ #category : #errors }
XMLDOMParser >> errorExpectedEndTag: anExpectedEndTag butGot: aTag [
	self driver parseError: 'expexted </', anExpectedEndTag, '> but got </', aTag, '>'
]

{ #category : #accessing }
XMLDOMParser >> incremental [
	^ incremental
]

{ #category : #accessing }
XMLDOMParser >> incremental: aBoolean [
	incremental := aBoolean
]

{ #category : #initialize }
XMLDOMParser >> initialize [
	super initialize.
	stack := OrderedCollection new.
	incremental := false
]

{ #category : #parsing }
XMLDOMParser >> nextEntityStart [
	[self driver nextToken.
	self stack isEmpty] whileTrue.
	^entity
]

{ #category : #parsing }
XMLDOMParser >> nextToken [
	| currentTop |
	currentTop := self top.
	[self driver nextToken isNil
		or: [self top ~~ currentTop]] whileTrue.
	^entity
]

{ #category : #parsing }
XMLDOMParser >> parseDocument [
	super parseDocument.
	^ self document.
]

{ #category : #private }
XMLDOMParser >> pop [
	| oldTop |
	oldTop := self stack removeLast.
	entity := oldTop.
	^oldTop
]

{ #category : #content }
XMLDOMParser >> processingInstruction: piName data: dataString [
	| piNode |
	piNode := XMLPI target: piName data: dataString.
	self top addNode: piNode
]

{ #category : #private }
XMLDOMParser >> push: anObject [
	self stack addLast: anObject.
	entity := anObject

]

{ #category : #private }
XMLDOMParser >> pushElement: anElement [

	(self incremental not and: [self stack notEmpty])
			ifTrue: [self top addElement: anElement].

	self push: anElement.
]

{ #category : #private }
XMLDOMParser >> stack [
	^ stack
]

{ #category : #content }
XMLDOMParser >> startDocument [
	self document: XMLDocument new.
	self push: self document 
]

{ #category : #content }
XMLDOMParser >> startElement: localName prefix: prefix uri: namespaceUri attributes: attributes [
	self pushElement:
		(XMLElement
			localName: localName
			prefix: prefix
			attributes: attributes
			scope: self currentScope)
]

{ #category : #private }
XMLDOMParser >> top [
	^self stack isEmpty
		ifTrue: [nil]
		ifFalse: [self stack last]
]
