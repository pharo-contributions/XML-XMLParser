Class {
	#name : #XMLNodeFactoryTest,
	#superclass : #TestCase,
	#category : #'XML-Parser-Tests-DOM-Factories'
}

{ #category : #testing }
XMLNodeFactoryTest class >> shouldInheritSelectors [
	^ true
]

{ #category : #accessing }
XMLNodeFactoryTest >> attributeAssociations [
	^ Array
		with: 'one' -> '1'
		with: 'two' -> '2'
]

{ #category : #accessing }
XMLNodeFactoryTest >> attributes [
	^ XMLAttributeDictionary newFrom: self attributeAssociations
]

{ #category : #accessing }
XMLNodeFactoryTest >> factoryClass [
	^ XMLNodeFactory
]

{ #category : #'instance creation' }
XMLNodeFactoryTest >> newFactory [
	^ self factoryClass new
]

{ #category : #accessing }
XMLNodeFactoryTest >> pluggableFactoryClass [
	^ XMLPluggableNodeFactory
]

{ #category : #source }
XMLNodeFactoryTest >> sampleUserXML [
	^
	XMLWriter new
		enablePrettyPrinting;
		writeWith: [:writer |
			writer pi
				target: 'xml-stylesheet';
				data: 'type="text/css" href="sample.css"'.
			writer comment: 'sample'.
			writer tag
				name: 'user:user';
				xmlnsAt: 'user' put: 'urn:user';
				with: [
					writer
						tag: 'user:username' with: 'jsmith';
						tag: 'user:real-name' with: 'John Smith';
						tag: 'user:date-registered' with: [writer cdata: DateAndTime now printString];
						tag: 'user:date-last-active' with: [writer cdata: DateAndTime now printString];
						tag: 'table-name' with: 'users';
						tag: 'row-id' with: '1000';
						tag: 'serializationFormat' with: 'XML']];
		contents
]

{ #category : #tests }
XMLNodeFactoryTest >> testAsPluggableNodeFactory [

	| factory pluggableFactory |
	factory := self factoryClass new.
	pluggableFactory := factory asPluggableNodeFactory.
	self
		assert: pluggableFactory class
		identicalTo: self pluggableFactoryClass.
	factory class == self pluggableFactoryClass
		ifTrue: [ self assert: pluggableFactory identicalTo: factory ]
		ifFalse: [ self deny: pluggableFactory identicalTo: factory ]
]

{ #category : #tests }
XMLNodeFactoryTest >> testAttributeDeclarationClass [

	self
		assert: self newFactory attributeDeclarationClass
		identicalTo: XMLAttributeDeclaration
]

{ #category : #tests }
XMLNodeFactoryTest >> testAttributeListClass [

	self
		assert: self newFactory attributeListClass
		identicalTo: XMLCachingAttributeList
]

{ #category : #tests }
XMLNodeFactoryTest >> testCDataClass [

	self assert: self newFactory cdataClass identicalTo: XMLCData
]

{ #category : #tests }
XMLNodeFactoryTest >> testClassForElement [

	self
		assert: (self newFactory classForElement: 'test')
		identicalTo: XMLElement
]

{ #category : #tests }
XMLNodeFactoryTest >> testClassForElementNamespaceURI [

	self
		assert: (self newFactory classForElement: 'test' namespaceURI: '')
		identicalTo: XMLElement.
	self
		assert:
		(self newFactory classForElement: 'test' namespaceURI: 'testNS')
		identicalTo: XMLElement
]

{ #category : #tests }
XMLNodeFactoryTest >> testCommentClass [

	self assert: self newFactory commentClass identicalTo: XMLComment
]

{ #category : #tests }
XMLNodeFactoryTest >> testDoctypeDeclarationClass [

	self
		assert: self newFactory doctypeDeclarationClass
		identicalTo: XMLDoctypeDeclaration
]

{ #category : #tests }
XMLNodeFactoryTest >> testDocumentClass [

	self assert: self newFactory documentClass identicalTo: XMLDocument
]

{ #category : #tests }
XMLNodeFactoryTest >> testElementClass [

	self assert: self newFactory elementClass identicalTo: XMLElement
]

{ #category : #tests }
XMLNodeFactoryTest >> testElementDeclarationClass [

	self
		assert: self newFactory elementDeclarationClass
		identicalTo: XMLElementDeclaration
]

{ #category : #tests }
XMLNodeFactoryTest >> testGeneralEntityDeclarationClass [

	self
		assert: self newFactory generalEntityDeclarationClass
		identicalTo: XMLGeneralEntityDeclaration
]

{ #category : #tests }
XMLNodeFactoryTest >> testNewCData [

	| cdata |
	cdata := self newFactory newCData: 'test'.
	self
		assert: cdata class identicalTo: XMLCData;
		assert: cdata string equals: 'test'
]

{ #category : #tests }
XMLNodeFactoryTest >> testNewComment [

	| comment |
	comment := self newFactory newComment: 'test'.
	self
		assert: comment class identicalTo: XMLComment;
		assert: comment string equals: 'test'
]

{ #category : #tests }
XMLNodeFactoryTest >> testNewDocument [

	self
		assert: self newFactory newDocument class
		identicalTo: XMLDocument
]

{ #category : #tests }
XMLNodeFactoryTest >> testNewElement [

	self assert: self newFactory newElement class identicalTo: XMLElement
]

{ #category : #tests }
XMLNodeFactoryTest >> testNewElementNamed [

	| element |
	element := self newFactory newElementNamed: 'test'.
	self
		assert: element class identicalTo: XMLElement;
		assert: element name equals: 'test'
]

{ #category : #tests }
XMLNodeFactoryTest >> testNewElementNamedAttributes [

	| element |
	element := self newFactory
		           newElementNamed: 'test'
		           attributes: self attributeAssociations.
	self
		assert: element class identicalTo: XMLElement;
		assert: element name equals: 'test';
		assert: element attributes equals: self attributes
]

{ #category : #tests }
XMLNodeFactoryTest >> testNewElementNamedNamespaceURI [

	| element |
	element := self newFactory
		           newElementNamed: 'prefix:test'
		           namespaceURI: 'prefixNS'.
	self
		assert: element class identicalTo: XMLElement;
		assert: element name equals: 'prefix:test';
		assert: element namespaceURI equals: 'prefixNS'
]

{ #category : #tests }
XMLNodeFactoryTest >> testNewElementNamedNamespaceURIAttributes [

	| element |
	element := self newFactory
		           newElementNamed: 'prefix:test'
		           namespaceURI: 'prefixNS'
		           attributes: self attributeAssociations.
	self
		assert: element class identicalTo: XMLElement;
		assert: element name equals: 'prefix:test';
		assert: element namespaceURI equals: 'prefixNS';
		assert: element attributes equals: self attributes
]

{ #category : #tests }
XMLNodeFactoryTest >> testNewPI [

	self assert: self newFactory newPI class identicalTo: XMLPI
]

{ #category : #tests }
XMLNodeFactoryTest >> testNewPITargetData [

	| pi |
	pi := self newFactory newPITarget: 'target' data: 'data'.
	self
		assert: pi class identicalTo: XMLPI;
		assert: pi target equals: 'target';
		assert: pi data equals: 'data'
]

{ #category : #tests }
XMLNodeFactoryTest >> testNewStringNode [

	| cdata |
	cdata := self newFactory newStringNode: 'test'.
	self
		assert: cdata class identicalTo: XMLString;
		assert: cdata string equals: 'test'
]

{ #category : #tests }
XMLNodeFactoryTest >> testNodeListClass [

	self assert: self newFactory nodeListClass identicalTo: XMLNodeList
]

{ #category : #tests }
XMLNodeFactoryTest >> testNotationDeclarationClass [

	self
		assert: self newFactory notationDeclarationClass
		identicalTo: XMLNotationDeclaration
]

{ #category : #tests }
XMLNodeFactoryTest >> testPIClass [

	self assert: self newFactory piClass identicalTo: XMLPI
]

{ #category : #tests }
XMLNodeFactoryTest >> testParameterEntityDeclarationClass [

	self
		assert: self newFactory parameterEntityDeclarationClass
		identicalTo: XMLParameterEntityDeclaration
]

{ #category : #tests }
XMLNodeFactoryTest >> testStringNodeClass [

	self assert: self newFactory stringNodeClass identicalTo: XMLString
]
