Class {
	#name : #XMLDocumentTest,
	#superclass : #XMLNodeWithElementsTest,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #testing }
XMLDocumentTest class >> isAbstract [
	^ false
]

{ #category : #'instance creation' }
XMLDocumentTest >> newNodeWithElements [
	^ super newNodeWithElements
		doctypeDeclaration: (XMLDoctypeDeclaration new root: 'zero');
		yourself
]

{ #category : #accessing }
XMLDocumentTest >> nodeClass [
	^ XMLDocument
]

{ #category : #tests }
XMLDocumentTest >> testDoctypeDeclaration [
	| document doctypeDeclaration |

	document := self nodeClass new.
	self assert: document doctypeDeclaration isNil.
	doctypeDeclaration := XMLDoctypeDeclaration new.
	self
		assert: (document doctypeDeclaration: doctypeDeclaration) == document;
		assert: document doctypeDeclaration == doctypeDeclaration;
		assert: doctypeDeclaration parent == document.
	self
		should: [self nodeClass new doctypeDeclaration: document doctypeDeclaration]
		raise: XMLDOMException.

	document doctypeDeclaration: nil.
	self
		assert: document doctypeDeclaration isNil;
		assert: doctypeDeclaration parent isNil.
]

{ #category : #tests }
XMLDocumentTest >> testDoctypeDefinition [
	| document doctypeDefinition |

	document := self nodeClass new.
	self assert: document doctypeDefinition isNil.
	doctypeDefinition := DTDDoctypeDefinition new.
	self
		assert: (document doctypeDefinition: doctypeDefinition) == document;
		assert: document doctypeDefinition == doctypeDefinition.
]

{ #category : #tests }
XMLDocumentTest >> testDocument [
	| document |

	super testDocument.

	document := self nodeClass new.
	self assert: document document == document.

	document := self newNodeWithElements.
	self assert: document document == document.
]

{ #category : #tests }
XMLDocumentTest >> testEncoding [
	self
		assert: self nodeClass new encoding isEmpty;
		assert: ((self nodeClass new encoding: 'UTF-8') encoding) = 'UTF-8'.
]

{ #category : #tests }
XMLDocumentTest >> testHasDoctypeDeclaration [
	| document |

	document := self nodeClass new.
	self deny: document hasDoctypeDeclaration.
	document doctypeDeclaration: XMLDoctypeDeclaration new.	
	self assert: document hasDoctypeDeclaration.
	document doctypeDeclaration: nil.
	self deny: document hasDoctypeDeclaration.
]

{ #category : #tests }
XMLDocumentTest >> testHasDoctypeDefinition [
	| document |

	document := self nodeClass new.
	self deny: document hasDoctypeDefinition.
	document doctypeDefinition: DTDDoctypeDefinition new.
	self assert: document hasDoctypeDefinition.
	document doctypeDefinition: nil.
	self deny: document hasDoctypeDefinition.
]

{ #category : #tests }
XMLDocumentTest >> testIsDocument [
	self assert: self nodeClass new isDocument
]

{ #category : #tests }
XMLDocumentTest >> testIsStandalone [
	self
		deny: self nodeClass new isStandalone;
		assert: (self nodeClass new isStandalone: true) isStandalone
]

{ #category : #tests }
XMLDocumentTest >> testRoot [
	| nodeWithElements firstNode newRoot |

	self assert: self nodeClass new root isNil.

	nodeWithElements := self newNodeWithElements.
	firstNode := XMLComment string: 'first'.
	nodeWithElements addNodeFirst: firstNode.
	self assert: (nodeWithElements root isElementNamed: 'zero').

	newRoot := XMLElement named: 'new-root'.
	nodeWithElements root: newRoot.
	self
		assert: nodeWithElements firstNode == firstNode;
		assert: nodeWithElements root == newRoot.

	nodeWithElements removeNodes.
	self assert: nodeWithElements root isNil.

	newRoot := XMLElement named: 'root'.
	self assert: (self nodeClass root: newRoot) root == newRoot.
]

{ #category : #tests }
XMLDocumentTest >> testValidate [
	| xml document |

	super testValidate.

	xml := '
		<!DOCTYPE one [
			<!ELEMENT one (two+)>
			<!ATTLIST one idref IDREF #REQUIRED>
			<!ELEMENT two (#PCDATA)*>
			<!ATTLIST two id ID #REQUIRED>]>
		<one idref="a">
			<two id="a">three</two><two id="b"><!--comment--></two>
		</one>'.

	document :=
		(XMLDOMParser on: xml)
			preservesCommentNodes: true;
			parseDocument.
	self
		shouldnt: [document validate]
		raise: XMLValidationException.
	self assert:
		(document canonicallyEquals: 
			((XMLDOMParser on: xml)
				preservesCommentNodes: true;
				parseDocument)).

	document
		allElementsNamed: 'two'
		do: [:each | each attributeAt: 'id' put: 'a'].
	self
		should: [document validate]
		raise: XMLValidationException.

	document := XMLDOMParser parse: xml.
	document root name: 'zero'.
	self
		should: [document validate]
		raise: XMLValidationException.

	document := XMLDOMParser parse: xml.
	document root attributeAt: 'idref' put: 'undeclared'.
	self
		should: [document validate]
		raise: XMLValidationException.

	document := XMLDOMParser parse: xml.
	document root addElementNamed: 'three'.
	self
		should: [document validate]
		raise: XMLValidationException.

	(document := XMLDOMParser parse: xml) doctypeDefinition: nil.
	document root
		name: 'zero';
		attributeAt: 'idref' put: 'undeclared';
		addElementNamed: 'three';
		allElementsNamed: 'two' do: [:each | each attributeAt: 'id' put: 'same'].
	self
		shouldnt: [document validate]
		raise: XMLValidationException.
]

{ #category : #tests }
XMLDocumentTest >> testValidateNoSubset [
	| xml document |

	xml := '<!DOCTYPE one>
		<one idref="a">
			<two id="a">three</two><two id="b"><!--comment--></two>
		</one>'.

	document :=
		(XMLDOMParser on: xml)
			preservesCommentNodes: true;
			parseDocument.
	self
		shouldnt: [document validate]
		raise: XMLValidationException.
	self assert:
		(document canonicallyEquals: 
			((XMLDOMParser on: xml)
				preservesCommentNodes: true;
				parseDocument)).

	document root name: 'five'.
	self
		should: [document validate]
		raise: XMLValidationException.

	document doctypeDefinition: nil.
	self
		shouldnt: [document validate]
		raise: XMLValidationException.
]

{ #category : #tests }
XMLDocumentTest >> testVersion [
	self
		assert: self nodeClass new version isNil;
		assert: (self nodeClass new version: 1.0) version = 1.0
]
