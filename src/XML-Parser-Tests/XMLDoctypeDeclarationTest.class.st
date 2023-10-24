Class {
	#name : #XMLDoctypeDeclarationTest,
	#superclass : #XMLNodeWithChildrenTest,
	#category : #'XML-Parser-Tests-DOM'
}

{ #category : #testing }
XMLDoctypeDeclarationTest class >> isAbstract [
	^ false
]

{ #category : #'instance creation' }
XMLDoctypeDeclarationTest >> newNodeWithNodes [
	^ self newNode
		addNode: (XMLComment string: 'before');
		addNode: (XMLGeneralEntityDeclaration name: 'one' replacement: 'two');
		addNode: (XMLParameterEntityDeclaration name: 'three' publicID: 'four' systemID: 'four');
		addNode: (XMLElementDeclaration element: 'five' contentModel: '(six|sevent|eight)');
		addNode:
			(XMLAttributeDeclaration
				element: 'five'
				attribute: 'nine'
				type: 'CDATA'
				defaultPragma: '#IMPLIED'
				defaultValue: 'ten');
		addNode:
			(XMLNotationDeclaration
				name: 'eleven'
				publicID: 'twelve'
				systemID: 'twelve');
		addNode: (XMLPI target: 'thirteen' data: 'fourteen');
		addNode: (XMLComment string: 'after');
		yourself
]

{ #category : #accessing }
XMLDoctypeDeclarationTest >> nodeClass [
	^ XMLDoctypeDeclaration
]

{ #category : #accessing }
XMLDoctypeDeclarationTest >> nodeListClass [
	^ XMLInternalSubsetList
]

{ #category : #accessing }
XMLDoctypeDeclarationTest >> selectListClass [
	^ XMLInternalSubsetList
]

{ #category : #tests }
XMLDoctypeDeclarationTest >> testAllNodes [

	| nodeWithNodes allNodes |
	nodeWithNodes := self newNodeWithNodes.
	allNodes := nodeWithNodes allNodes.
	self
		assert: allNodes size equals: 9;
		assert: allNodes first identicalTo: nodeWithNodes;
		assert: allNodes second isComment;
		assert: allNodes second string equals: 'before';
		assert: allNodes third class
		identicalTo: XMLGeneralEntityDeclaration;
		assert: allNodes fourth class
		identicalTo: XMLParameterEntityDeclaration;
		assert: allNodes fifth class identicalTo: XMLElementDeclaration;
		assert: allNodes sixth class identicalTo: XMLAttributeDeclaration;
		assert: allNodes seventh class identicalTo: XMLNotationDeclaration;
		assert: allNodes eighth isPI;
		assert: allNodes ninth isComment;
		assert: allNodes ninth string equals: 'after'
]

{ #category : #tests }
XMLDoctypeDeclarationTest >> testCanonicallyEquals [
	self
		assert: (self newNode canonicallyEquals: self newNode);
		assert: (self newNodeWithNodes canonicallyEquals: self newNodeWithNodes);
		assert: (self newNodeWithNodes canonicallyEquals: self newNode)
]

{ #category : #tests }
XMLDoctypeDeclarationTest >> testPublicID [

	| doctype |
	doctype := self newNode.
	self
		assert: doctype publicID equals: '';
		assert: (doctype publicID: 'test') identicalTo: doctype;
		assert: doctype publicID equals: 'test'
]

{ #category : #tests }
XMLDoctypeDeclarationTest >> testRoot [

	| doctype |
	doctype := self newNode.
	self
		assert: doctype root equals: '';
		assert: (doctype root: 'test') identicalTo: doctype;
		assert: doctype root equals: 'test'
]

{ #category : #tests }
XMLDoctypeDeclarationTest >> testRootPublicIDSystemID [

	| doctype |
	doctype := self nodeClass
		           root: 'one'
		           publicID: 'two'
		           systemID: 'three'.
	self
		assert: doctype class identicalTo: self nodeClass;
		assert: doctype root equals: 'one';
		assert: doctype publicID equals: 'two';
		assert: doctype systemID equals: 'three'
]

{ #category : #tests }
XMLDoctypeDeclarationTest >> testSystemID [

	| doctype |
	doctype := self newNode.
	self
		assert: doctype systemID equals: '';
		assert: (doctype systemID: 'test') identicalTo: doctype;
		assert: doctype systemID equals: 'test'
]

{ #category : #tests }
XMLDoctypeDeclarationTest >> testWriteXMLOn [

	| doctype elementDeclaration |
	doctype := self newNode.
	self assert: doctype printString equals: '<!DOCTYPE >'.
	doctype root: 'one'.
	self assert: doctype printString equals: '<!DOCTYPE one>'.
	doctype publicID: 'two'.
	self
		assert: doctype printString
		equals: '<!DOCTYPE one PUBLIC "two" "">'.
	doctype systemID: 'three'.
	self
		assert: doctype printString
		equals: '<!DOCTYPE one PUBLIC "two" "three">'.

	elementDeclaration := XMLElementDeclaration
		                      element: 'four'
		                      contentModel: '(five|six)'.
	doctype addNode: elementDeclaration.
	self
		assert: doctype printString
		equals: '<!DOCTYPE one PUBLIC "two" "three" ['
			, elementDeclaration printString , ']>'.
	self
		assert:
		(self nodeClass root: 'one' publicID: '' systemID: 'two')
			printString
		equals: '<!DOCTYPE one SYSTEM "two">'
]
