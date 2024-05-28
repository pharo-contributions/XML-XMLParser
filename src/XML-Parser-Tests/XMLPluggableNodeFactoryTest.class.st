Class {
	#name : 'XMLPluggableNodeFactoryTest',
	#superclass : 'XMLNodeFactoryTest',
	#category : 'XML-Parser-Tests-DOM-Factories',
	#package : 'XML-Parser-Tests',
	#tag : 'DOM-Factories'
}

{ #category : 'accessing' }
XMLPluggableNodeFactoryTest >> attributeListClass [
	^ XMLFAttributeList
]

{ #category : 'accessing' }
XMLPluggableNodeFactoryTest >> cdataClass [
	^ XMLFCData
]

{ #category : 'accessing' }
XMLPluggableNodeFactoryTest >> commentClass [
	^ XMLFComment
]

{ #category : 'accessing' }
XMLPluggableNodeFactoryTest >> documentClass [
	^ XMLFDocument
]

{ #category : 'accessing' }
XMLPluggableNodeFactoryTest >> elementClass [
	^ XMLFElement
]

{ #category : 'accessing' }
XMLPluggableNodeFactoryTest >> factoryClass [
	^ XMLPluggableNodeFactory
]

{ #category : 'instance creation' }
XMLPluggableNodeFactoryTest >> newFactoryWithClasses [
	^ self newFactory
		documentClass: self documentClass;
		elementClass: self elementClass;
		stringNodeClass: self stringNodeClass;
		cdataClass: self cdataClass;
		commentClass: self commentClass;
		piClass: self piClass
]

{ #category : 'accessing' }
XMLPluggableNodeFactoryTest >> nodeListClass [
	^ XMLFNodeList
]

{ #category : 'accessing' }
XMLPluggableNodeFactoryTest >> piClass [
	^ XMLFPI
]

{ #category : 'accessing' }
XMLPluggableNodeFactoryTest >> pluggableFactoryClass [
	^ self factoryClass
]

{ #category : 'accessing' }
XMLPluggableNodeFactoryTest >> stringNodeClass [
	^ XMLFString
]

{ #category : 'tests' }
XMLPluggableNodeFactoryTest >> testAttributeListClass [

	| factory |
	super testAttributeListClass.

	factory := self newFactoryWithClasses.
	self
		assert: (factory attributeListClass: self attributeListClass)
		identicalTo: factory;
		assert: factory attributeListClass
		identicalTo: self attributeListClass
]

{ #category : 'tests' }
XMLPluggableNodeFactoryTest >> testCDataClass [

	super testCDataClass.
	self
		assert: self newFactoryWithClasses cdataClass
		identicalTo: self cdataClass
]

{ #category : 'tests' }
XMLPluggableNodeFactoryTest >> testClassForElement [

	super testClassForElement.
	self
		assert: (self newFactoryWithClasses classForElement: 'test')
		identicalTo: self elementClass
]

{ #category : 'tests' }
XMLPluggableNodeFactoryTest >> testClassForElementNamespaceURI [

	super testClassForElementNamespaceURI.
	self
		assert:
		(self newFactoryWithClasses classForElement: 'test' namespaceURI: '')
		identicalTo: self elementClass.
	self
		assert: (self newFactoryWithClasses
				 classForElement: 'test'
				 namespaceURI: 'testNS')
		identicalTo: self elementClass
]

{ #category : 'tests' }
XMLPluggableNodeFactoryTest >> testCommentClass [

	super testCommentClass.
	self
		assert: self newFactoryWithClasses commentClass
		identicalTo: self commentClass
]

{ #category : 'tests' }
XMLPluggableNodeFactoryTest >> testDocumentClass [

	super testDocumentClass.
	self
		assert: self newFactoryWithClasses documentClass
		identicalTo: self documentClass
]

{ #category : 'tests' }
XMLPluggableNodeFactoryTest >> testElementClass [

	super testElementClass.
	self
		assert: self newFactoryWithClasses elementClass
		identicalTo: self elementClass
]

{ #category : 'tests' }
XMLPluggableNodeFactoryTest >> testNewCData [

	| cdata |
	super testNewCData.

	cdata := self newFactoryWithClasses newCData: 'test'.
	self
		assert: cdata class identicalTo: self cdataClass;
		assert: cdata string equals: 'test'
]

{ #category : 'tests' }
XMLPluggableNodeFactoryTest >> testNewComment [

	| comment |
	super testNewComment.

	comment := self newFactoryWithClasses newComment: 'test'.
	self
		assert: comment class identicalTo: self commentClass;
		assert: comment string equals: 'test'
]

{ #category : 'tests' }
XMLPluggableNodeFactoryTest >> testNewDocument [

	super testNewDocument.
	self
		assert: self newFactoryWithClasses newDocument class
		identicalTo: self documentClass
]

{ #category : 'tests' }
XMLPluggableNodeFactoryTest >> testNewElement [

	super testNewElement.
	self
		assert: self newFactoryWithClasses newElement class
		identicalTo: self elementClass
]

{ #category : 'tests' }
XMLPluggableNodeFactoryTest >> testNewElementNamed [

	| element |
	super testNewElementNamed.

	element := self newFactoryWithClasses newElementNamed: 'test'.
	self
		assert: element class identicalTo: self elementClass;
		assert: element name equals: 'test'
]

{ #category : 'tests' }
XMLPluggableNodeFactoryTest >> testNewElementNamedNamespaceURI [

	| element |
	super testNewElementNamedNamespaceURI.

	element := self newFactoryWithClasses
		           newElementNamed: 'prefix:test'
		           namespaceURI: 'prefixNS'.
	self
		assert: element class identicalTo: self elementClass;
		assert: element name equals: 'prefix:test';
		assert: element namespaceURI equals: 'prefixNS'
]

{ #category : 'tests' }
XMLPluggableNodeFactoryTest >> testNewPI [

	super testNewPI.
	self
		assert: self newFactoryWithClasses newPI class
		identicalTo: self piClass
]

{ #category : 'tests' }
XMLPluggableNodeFactoryTest >> testNewPITargetData [

	| pi |
	super testNewPITargetData.

	pi := self newFactoryWithClasses newPITarget: 'target' data: 'data'.
	self
		assert: pi class identicalTo: self piClass;
		assert: pi target equals: 'target';
		assert: pi data equals: 'data'
]

{ #category : 'tests' }
XMLPluggableNodeFactoryTest >> testNewStringNode [

	| string |
	super testNewStringNode.

	string := self newFactoryWithClasses newStringNode: 'test'.
	self
		assert: string class identicalTo: self stringNodeClass;
		assert: string string equals: 'test'
]

{ #category : 'tests' }
XMLPluggableNodeFactoryTest >> testNodeListClass [

	| factory |
	super testNodeListClass.

	factory := self newFactoryWithClasses.
	self
		assert: (factory nodeListClass: self nodeListClass)
		identicalTo: factory;
		assert: factory nodeListClass identicalTo: self nodeListClass
]

{ #category : 'tests' }
XMLPluggableNodeFactoryTest >> testPIClass [

	super testPIClass.
	self
		assert: self newFactoryWithClasses piClass
		identicalTo: self piClass
]

{ #category : 'tests' }
XMLPluggableNodeFactoryTest >> testParsingSample [

	| document factory |
	factory := self newFactoryWithClasses.
	document := (XMLDOMParser on: self sampleUserXML)
		            nodeFactory: factory;
		            preservesCDataNodes: true;
		            preservesCommentNodes: true;
		            parseDocument.
	self
		assert: document class identicalTo: self documentClass;
		assert: document nodeFactory identicalTo: factory.

	document allElementsDo: [ :each |
		self
			assert: each class identicalTo: self elementClass;
			assert: each nodeFactory identicalTo: factory ].

	document allNodesDo: [ :each |
		each isStringNode ifTrue: [
			self assert: each class identicalTo: (each isCData
					 ifTrue: [ self cdataClass ]
					 ifFalse: [ self stringNodeClass ]) ].
		each isComment ifTrue: [
			self assert: each class identicalTo: self commentClass ].
		each isPI ifTrue: [
			self assert: each class identicalTo: self piClass ] ]
]

{ #category : 'tests' }
XMLPluggableNodeFactoryTest >> testStringNodeClass [

	super testStringNodeClass.
	self
		assert: self newFactoryWithClasses stringNodeClass
		identicalTo: self stringNodeClass
]
