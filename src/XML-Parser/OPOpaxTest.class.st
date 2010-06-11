Class {
	#name : #OPOpaxTest,
	#superclass : #TestCase,
	#instVars : [
		'packages'
	],
	#category : #'XML-Parser-Opax-Test'
}

{ #category : #testing }
OPOpaxTest >> lessSimpleXmlSample [
	^'
<Test1>
	<Test1>
	</Test1>
	<Test2>
		<Test1>
		</Test1>
	</Test2>
</Test1>
'
]

{ #category : #readme }
OPOpaxTest >> readme [
"
Opax is a small addition to SAXParser that enables dealing with tags polymorphically.
"
]

{ #category : #testing }
OPOpaxTest >> simpleXmlSample [
	^'
<Test1>
</Test1>
'
]

{ #category : #testing }
OPOpaxTest >> testCreation [
	self assert: ((OPGenericElement newElementWithTag: 'test1') isMemberOf: OPTest1Element).
	self assert: ((OPGenericElement newElementWithTag: 'anotherTest1') isMemberOf: OPTest1Element).
	self assert: ((OPGenericElement newElementWithTag: 'some random string') isMemberOf: OPGenericElement)
]

{ #category : #testing }
OPOpaxTest >> testLessSimpleXml [
	| parser root test1RootElement |
	parser := OPOpaxHandler on: self lessSimpleXmlSample readStream.
	parser startDocument.
	parser parseDocument.
	
	root := parser stack first.
	
	self assert: parser stack size = 1.
	self assert: (root isMemberOf: OPRootElement).
	self assert: root children size = 1.
	
	test1RootElement := root children first.
	
	self assert: (test1RootElement isMemberOf: OPTest1Element).
	self assert: test1RootElement tag = 'Test1'.
	self assert: test1RootElement children size = 2.
	self assert: (test1RootElement children first isMemberOf: OPTest1Element).
	self assert: (test1RootElement children last isMemberOf: OPTest2Element).
	self assert: test1RootElement children first tag = 'Test1'.
	self assert: test1RootElement children last tag = 'Test2'.
	self assert: root allChildren size = 4
]

{ #category : #testing }
OPOpaxTest >> testOPOpaxDriverTestClass [

	| parser root |
	
	parser := OPOpaxHandlerTestClass on: self simpleXmlSample readStream.
	parser startDocument.
	parser parseDocument.


	self assert: (parser cStackGet = 0).
	self assert: (parser cStackSet = 0).
	self assert: (parser cStartDocument > 0).
	self assert: (parser cEndDocument > 0).
	self assert: (parser cEndElement > 0).
	self assert: (parser cStartElement > 0).
	self assert: (parser cChar = 0).


	root := parser stack first.
	
	self assert: (parser stack size = 1).
	self assert: (root isMemberOf: OPRootElement).
	self assert: (root children size = 1).
	self assert: (root children first isMemberOf: OPTest1Element).
	
]

{ #category : #testing }
OPOpaxTest >> testSimpleXml [
	| parser root |
	parser := OPOpaxHandler on: self simpleXmlSample readStream.
	parser startDocument.
	parser parseDocument.
	root := parser stack first.
	self assert: parser stack size = 1.
	self assert: (root isMemberOf: OPRootElement).
	self assert: root children size = 1.
	self assert: (root children first isMemberOf: OPTest1Element)
]

{ #category : #testing }
OPOpaxTest >> testXmlWithAttributes [
	| parser root test1RootElement |
	parser := OPOpaxHandler on: self xmlWithAttributesSample readStream.
	parser startDocument.
	parser parseDocument.
	root := parser stack first.
	self assert: parser stack size = 1.
	self assert: (root isMemberOf: OPRootElement).
	self assert: root children size = 1.
	test1RootElement := root children first.
	self assert: test1RootElement attributes size = 1.
	self assert: (test1RootElement attributeNamed: 'name') = 'test1'.
	self assert: (test1RootElement isMemberOf: OPTest1Element).
	self assert: test1RootElement children size = 2.
	self assert: (test1RootElement children first isMemberOf: OPTest1Element).
	self assert: (test1RootElement children last isMemberOf: OPTest2Element)
]

{ #category : #testing }
OPOpaxTest >> testXmlWithAttributesAndHeader [
	| parser root test1RootElement |
	parser := OPOpaxHandler on: self xmlWithAttributesAndHeaderSample readStream.
	parser startDocument.
	parser parseDocument.
	root := parser stack first.
	
	self assert: parser stack size = 1.
	self assert: (root isMemberOf: OPRootElement).
	self assert: root children size = 1.
	test1RootElement := root children first.
	self assert: test1RootElement attributes size = 1.
	self assert: (test1RootElement attributeNamed: 'name') = 'test1'.
	self assert: (test1RootElement isMemberOf: OPTest1Element).
	self assert: test1RootElement children size = 2.
	self assert: (test1RootElement children first isMemberOf: OPTest1Element).
	self assert: (test1RootElement children last isMemberOf: OPTest2Element)
]

{ #category : #testing }
OPOpaxTest >> xmlWithAttributesAndHeaderSample [
	^'
<?xml version="1.0" encoding="UTF-8"?>
<Test1 name="test1">
	<Test1 name="test1-test1">
	</Test1>
	<Test2 name="test1-test2">
		<Test1 name="test1-test2-test1">
		</Test1>
	</Test2>
</Test1>
'
]

{ #category : #testing }
OPOpaxTest >> xmlWithAttributesSample [
	^'
<Test1 name="test1">
	<Test1 name="test1-test1">
	</Test1>
	<Test2 name="test1-test2">
		<Test1 name="test1-test2-test1">
		</Test1>
	</Test2>
</Test1>
'
]
