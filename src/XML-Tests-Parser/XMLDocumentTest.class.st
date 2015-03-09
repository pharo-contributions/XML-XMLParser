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
		doctypeDeclaration: XMLDoctypeDeclaration new;
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
		assert: document doctypeDeclaration == doctypeDeclaration.
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
		assert: self nodeClass new encoding = 'UTF-8';
		assert: ((self nodeClass new encoding: 'UTF-16') encoding) = 'UTF-16'.
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
	| nodeWithElements |

	self assert: self nodeClass new root isNil.
	nodeWithElements := self newNodeWithElements.
	self assert: (nodeWithElements root isElementNamed: 'root').
	nodeWithElements removeNodes.
	self assert: nodeWithElements root isNil.
	nodeWithElements addNode: (XMLElement named: 'new-root').
	self assert: (nodeWithElements root isElementNamed: 'new-root').
]

{ #category : #tests }
XMLDocumentTest >> testVersion [
	self
		assert: self nodeClass new version isNil;
		assert: (self nodeClass new version: 1.0) version = 1.0
]
