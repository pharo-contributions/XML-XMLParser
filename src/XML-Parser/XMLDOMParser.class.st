"
XMLDOMParser parses XML into a tree of XML nodes representing the document structure. To see what kinds of nodes it produces and what can be done with them, browse XML-Parser-Nodes. 
"
Class {
	#name : #XMLDOMParser,
	#superclass : #SAXHandler,
	#instVars : [
		'document',
		'incremental',
		'nodeStack'
	],
	#category : #'XML-Parser-Parser'
}

{ #category : #content }
XMLDOMParser >> characters: aString [
	self topNode addContent: aString

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
	self document
		version: (attributeList at: 'version' ifAbsent: [nil]);
		encoding: (attributeList at: 'encoding' ifAbsent: [nil]);
		requiredMarkup: (attributeList at: 'requiredMarkup' ifAbsent: [nil])

]

{ #category : #parsing }
XMLDOMParser >> domDocument [
	[self parseDocument] ensure: [self driver stream close].

	^ document.
]

{ #category : #content }
XMLDOMParser >> endDocument [
	self popNode.
	super endDocument
]

{ #category : #content }
XMLDOMParser >> endElement: aQualifiedName prefix: aPrefix uri: aUri localName: aLocalName [
	self popNode
]

{ #category : #accessing }
XMLDOMParser >> incremental [
	^ incremental ifNil: [incremental := false]
]

{ #category : #accessing }
XMLDOMParser >> incremental: aBoolean [
	incremental := aBoolean
]

{ #category : #private }
XMLDOMParser >> nodeStack [
	^ nodeStack ifNil: [nodeStack := OrderedCollection new: 30]
]

{ #category : #parsing }
XMLDOMParser >> parseDocument [
	super parseDocument.
	^ self document.
]

{ #category : #private }
XMLDOMParser >> popNode [
	^ self nodeStack removeLast
]

{ #category : #content }
XMLDOMParser >> processingInstruction: piName data: dataString [
	self topNode addNode: (XMLPI target: piName data: dataString)
]

{ #category : #private }
XMLDOMParser >> pushElement: anElement [

	(self incremental not and: [self nodeStack notEmpty])
			ifTrue: [self topNode addElement: anElement].

	self pushNode: anElement.
]

{ #category : #private }
XMLDOMParser >> pushNode: aNode [
	^ self nodeStack addLast: aNode

]

{ #category : #content }
XMLDOMParser >> startDocument [
	self document: XMLDocument new.
	self pushNode: self document 
]

{ #category : #content }
XMLDOMParser >> startElement: aQualifiedName prefix: aPrefix uri: aUri localName: aLocalName attributes: aDictionary [
	self pushElement:
		((XMLElement
			qualifiedName: aQualifiedName
			prefix: aPrefix
			localName: aLocalName
			attributes: aDictionary)
				setScope: self currentScope)
]

{ #category : #private }
XMLDOMParser >> topNode [
	^ self nodeStack isEmpty
		ifTrue: [nil]
		ifFalse: [self nodeStack last]
]
