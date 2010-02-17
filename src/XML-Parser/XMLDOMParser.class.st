Class {
	#name : #XMLDOMParser,
	#superclass : #SAXHandler,
	#instVars : [
		'entity',
		'stack',
		'incremental'
	],
	#category : #'XML-Parser-Parser'
}

{ #category : #examples }
XMLDOMParser class >> addressBookXMLWithDTD [
	"XMLDOMParser addressBookXMLWithDTD"
	^self parseDocumentFrom: XMLTokenizer addressBookXMLWithDTD readStream useNamespaces: true
]

{ #category : #'instance creation' }
XMLDOMParser class >> parseDocumentFrom: aStream [
	^self parseDocumentFrom: aStream useNamespaces: false
]

{ #category : #'instance creation' }
XMLDOMParser class >> parseDocumentFrom: aStream useNamespaces: aBoolean [
	^(super
		parseDocumentFrom: (aStream isStream ifTrue: [aStream] ifFalse: [aStream readStream])
		useNamespaces: aBoolean) document
]

{ #category : #content }
XMLDOMParser >> characters: aString [
	| newElement |
	newElement := XMLStringNode string: aString.
	self top addContent: newElement.

]

{ #category : #private }
XMLDOMParser >> defaultNamespace [
	^self top
		ifNotNil: [self top namespace]
]

{ #category : #content }
XMLDOMParser >> documentAttributes: attributeList [
	self document version: (attributeList at: 'version' ifAbsent: [nil]).
	self document encoding: (attributeList at: 'encoding' ifAbsent: [nil]).
	self document requiredMarkup: (attributeList at: 'requiredMarkup' ifAbsent: [nil]).

]

{ #category : #parsing }
XMLDOMParser >> domDocument [
	[self startDocument; parseDocument]
		ensure: [self driver stream close].
	^document
]

{ #category : #content }
XMLDOMParser >> endDocument [
	self pop.
	super endDocument
]

{ #category : #content }
XMLDOMParser >> endElement: elementName [
	| currentElement |
	currentElement := self pop.
	currentElement name = elementName
		ifFalse: [self driver errorExpected: 'End tag "', elementName , '" doesn''t match "' , currentElement name , '".']
]

{ #category : #content }
XMLDOMParser >> endElement: localName namespace: namespace namespaceURI: uri qualifiedName: qualifiedName [
	| currentElement |
	currentElement := self pop.
	(currentElement namespace isNil
		or: [currentElement namespace = self defaultNamespace])
		ifTrue: [
			currentElement localName = localName
				ifFalse: [self driver errorExpected: 'End tag "', localName , '" doesn''t match "' , currentElement localName  , '".']]
		ifFalse: [
			currentElement qualifiedName = qualifiedName
				ifFalse: [self driver errorExpected: 'End tag "', qualifiedName , '" doesn''t match "' , currentElement qualifiedName  , '".']]
]

{ #category : #accessing }
XMLDOMParser >> incremental [
	^incremental
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
XMLDOMParser >> nextEntity [
	| currentTop |
	currentTop := self top.
	[self driver nextEntity isNil
		or: [self top ~~ currentTop]] whileTrue.
	^entity
]

{ #category : #parsing }
XMLDOMParser >> nextEntityStart [
	[self driver nextEntity.
	self stack isEmpty] whileTrue.
	^entity
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
	self stack add: anObject.
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
	^stack
]

{ #category : #content }
XMLDOMParser >> startDocument [
	self document: XMLDocument new.
	self push: self document 
]

{ #category : #content }
XMLDOMParser >> startElement: elementName attributeList: attributeList [

	self pushElement: (XMLElement named: elementName attributes: attributeList)
]

{ #category : #content }
XMLDOMParser >> startElement: localName namespaceURI: namespaceUri namespace: namespace attributeList: attributeList [
	| newElement |
	"newElement := namespace = self defaultNamespace
		ifTrue: [XMLElement named: localName namespace: nil uri: nil attributes: attributeList]
		ifFalse: [XMLElement named: localName namespace: namespace uri: namespaceUri attributes: attributeList]."
	newElement := XMLElement named: localName namespace: namespace uri: namespaceUri attributes: attributeList.

	self pushElement: newElement.
]

{ #category : #private }
XMLDOMParser >> top [
	^self stack isEmpty
		ifTrue: [nil]
		ifFalse: [self stack last]
]
