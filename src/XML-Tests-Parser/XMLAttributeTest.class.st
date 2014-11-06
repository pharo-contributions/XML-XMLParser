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
XMLAttributeTest >> test1basicNodeProtocol [
	| node element |

	node := self nodeClass new.
	self
		deny: node hasChildren;
		assert: node element isNil;
		assert: node contentString isEmpty.

	element := XMLElement new.
	node element: element.
	self assert: node element == element.
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
