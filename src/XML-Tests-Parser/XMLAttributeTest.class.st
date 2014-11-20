Class {
	#name : #XMLAttributeTest,
	#superclass : #XMLNodeTest,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #assertions }
XMLAttributeTest >> assertAttribute: anAttribute hasName: aName value: aValue [
	self
		assert: anAttribute name = aName;
		assert: (anAttribute isNamed: aName);
		assert: anAttribute value = aValue;
		assert: anAttribute printString = (aName, '="', aValue, '"')
]

{ #category : #accessing }
XMLAttributeTest >> nodeClass [
	^ XMLAttribute
]

{ #category : #tests }
XMLAttributeTest >> test7attributeNodes [
	| attribute |

	attribute := XMLAttribute new.
	self
		assertAttribute: attribute hasName: '' value: '';
		assertNode: attribute hasName: '' namespaceURI: '';
		assertAttribute: (attribute name: 'name') hasName: 'name' value: '';
		assertNode: attribute hasName: 'name' namespaceURI: '';
		assertAttribute: (attribute value: 'value') hasName: 'name' value: 'value';
		assertAttribute: (XMLAttribute name: 'name' value: 'value') hasName: 'name' value: 'value';
		assertNode: (attribute prefix: 'prefix') hasName: 'prefix:name' namespaceURI: '';
		assertNode: (XMLAttribute name: 'prefix:name' value: 'value') hasName: 'prefix:name' namespaceURI: ''.
]

{ #category : #tests }
XMLAttributeTest >> testAncestorElements [
	self should: [super testAncestorElements] raise: Error
]

{ #category : #tests }
XMLAttributeTest >> testAncestorElementsDo [
	self should: [super testAncestorElementsDo] raise: Error
]

{ #category : #tests }
XMLAttributeTest >> testAncestorNodes [
	self should: [super testAncestorNodes] raise: Error
]

{ #category : #tests }
XMLAttributeTest >> testAncestorNodesDo [
	self should: [super testAncestorNodesDo] raise: Error
]

{ #category : #tests }
XMLAttributeTest >> testElement [
	| node element |

	node := self nodeClass new.
	element := XMLElement new.
	node element: element.
	self assert: node element == element.
]

{ #category : #tests }
XMLAttributeTest >> testHasParent [
	self should: [super testHasParent] raise: Error
]

{ #category : #tests }
XMLAttributeTest >> testNextNode [
	self should: [super testNextNode] raise: Error
]

{ #category : #tests }
XMLAttributeTest >> testParent [
	| node |

	node := self nodeClass new.
	self
		should: [node parent] raise: Error;
		should: [node parent: self nodeClass new] raise: Error.
]

{ #category : #tests }
XMLAttributeTest >> testPreviousNode [
	self should: [super testPreviousNode] raise: Error
]
