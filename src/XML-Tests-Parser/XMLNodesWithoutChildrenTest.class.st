Class {
	#name : #XMLNodesWithoutChildrenTest,
	#superclass : #XMLNodeTest,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #assertions }
XMLNodesWithoutChildrenTest >> assertAttribute: anAttribute hasName: aName value: aValue [
	self
		assert: anAttribute name = aName;
		assert: (anAttribute isNamed: aName);
		assert: anAttribute value = aValue;
		assert: anAttribute printString = (aName, '="', aValue, '"')
]

{ #category : #assertions }
XMLNodesWithoutChildrenTest >> assertCData: aCDataNode hasString: aString [
	self
		assertStringNode: aCDataNode
		hasString: aString
		printString: '<![CDATA[', aString, ']]>'
]

{ #category : #assertions }
XMLNodesWithoutChildrenTest >> assertComment: aComment hasString: aString [
	self
		assert: aComment string = aString;
		assert: aComment printString = ('<!--', aString, '-->')
]

{ #category : #assertions }
XMLNodesWithoutChildrenTest >> assertNode: anObservedNode canNotifyNodes: anObserverArray [
	anObservedNode notifyOf: #mockNotifyWith: with: #one.
	self assert: (anObserverArray allSatisfy: [:each | each lastNotificationArguments = #(one)]).

	anObservedNode notifyOf: #mockNotifyWith:with: with: #one with: #two.
	self assert: (anObserverArray allSatisfy: [:each | each lastNotificationArguments = #(one two)]).

	anObservedNode notifyOf: #mockNotifyWith:with:with: with: #one with: #two with: #three.
	self assert: (anObserverArray allSatisfy: [:each | each lastNotificationArguments = #(one two three)]).

	anObserverArray do: [:each | each lastNotificationArguments: nil].
	anObservedNode notifyOf: #mockNotifyWith:with:with: withArguments: #(one two three).
	self assert: (anObserverArray allSatisfy: [:each | each lastNotificationArguments = #(one two three)]). 
]

{ #category : #assertions }
XMLNodesWithoutChildrenTest >> assertPI: aNode hasTarget: aTarget data: aData [
	self
		assert: aNode target = aTarget;
		assert: aNode data = aData;
		assert: aNode printString = ('<?', aTarget, ' ', aData, '?>')
]

{ #category : #assertions }
XMLNodesWithoutChildrenTest >> assertStringNode: aStringNode hasString: aString printString: aPrintString [
	self
		assert: aStringNode string = aString;
		assert: aStringNode contentString = aString;
		assert: aStringNode printString = aPrintString
]

{ #category : #tests }
XMLNodesWithoutChildrenTest >> test1basicNodeProtocol [
	| node parent |

	node := XMLMockNode new.
	self
		assertNode: node hasType: nil;
		deny: node hasChildren;
		assert: (#(nextNode previousNode parent) allSatisfy: [:each | (node perform: each) isNil]);
		assert: node printString = (node class name asString, '(', node identityHash printString, ') ');
		assert: node contentString isEmpty.

	parent := XMLMockNode new.
	node parent: parent.
	self
		assert: node hasParent;
		assert: node parent == parent.
]

{ #category : #tests }
XMLNodesWithoutChildrenTest >> test2nodeNotification [
	| observedNode firstObserverNode secondObserverNode |

	observedNode := XMLMockNode new.
	self
		shouldnt: [observedNode notifyOf: #invalid: with: #one] raise: Error;
		shouldnt: [observedNode notifyOf: #invalid:invalid: with: #one with: #two] raise: Error;
		shouldnt: [observedNode notifyOf: #invalid:invalid:invalid: with: #one with: #two with: #three] raise: Error;
		shouldnt: [observedNode notifyOf: #invalid:invalid:invalid: withArguments: #(one two three)] raise: Error.

	firstObserverNode := XMLMockObserverNode new.
	observedNode addObserver: firstObserverNode.
	self assertNode: observedNode canNotifyNodes: (Array with: firstObserverNode).

	secondObserverNode := XMLMockObserverNode new.
	observedNode addObserver: secondObserverNode.
	self
		assertNode: observedNode
		canNotifyNodes: (Array with: firstObserverNode with: secondObserverNode).

	observedNode removeObserver: firstObserverNode.
	self assertNode: observedNode canNotifyNodes: (Array with: secondObserverNode).

	self
		should: [observedNode notifyOf: #invalid: with: #one] raise: Error;
		should: [observedNode notifyOf: #invalid:invalid: with: #one with: #two] raise: Error;
		should: [observedNode notifyOf: #invalid:invalid:invalid: with: #one with: #two with: #three] raise: Error;
		should: [observedNode notifyOf: #invalid:invalid:invalid: withArguments: #(one two three)] raise: Error.
]

{ #category : #tests }
XMLNodesWithoutChildrenTest >> test3processingInstructionNodes [
	| pi t d |

	pi := XMLPI new.
	t := 'target'.
	d := 'data'.
	self
		assertNode: pi hasType: #isPI;
		assertPI: pi hasTarget: '' data: '';
		assertPI: (pi target: t) hasTarget: t data: '';
		assertPI: (pi data: d) hasTarget: t data: d;
		assertPI: (XMLPI target: t data: d) hasTarget: t data: d.
]

{ #category : #tests }
XMLNodesWithoutChildrenTest >> test4stringNodes [
	| node raw escaped |

	node := XMLString new.
	raw := self markupString.
	escaped := self escapedString.
	self
		assertNode: node hasTypes: #(isStringNode isContentNode);
		assertStringNode: node hasString: '' printString: '';
		assertStringNode: (node string: raw) hasString: raw printString: escaped;
		assertStringNode: (node addContent: raw) hasString: raw, raw printString: escaped, escaped.
	self
		assertStringNode: (node addContent: (XMLString string: raw))
		hasString: raw, raw, raw
		printString: escaped, escaped, escaped.

	self
		assertStringNode: (XMLString string: raw)
		hasString: raw
		printString: escaped.
	self
		assertStringNode: (XMLString string: (XMLString string: raw))
		hasString: raw
		printString: escaped.

	self
		assertStringNode: raw asXMLString hasString: raw printString: escaped;
		assert: node asXMLString == node.
]

{ #category : #tests }
XMLNodesWithoutChildrenTest >> test5cdataNode [
	| node raw |

	node := XMLCData new.
	raw := self markupString.
	self
		assertNode: node hasTypes: #(isCData isStringNode isContentNode);
		assertCData: node hasString: '';
		assertCData: (node string: raw) hasString: raw;
		assertCData: (node addContent: raw) hasString: raw, raw;
		assertCData: (node addContent: raw asXMLString) hasString: raw, raw, raw;
		assert: node asXMLString == node
]

{ #category : #tests }
XMLNodesWithoutChildrenTest >> test6commentNodes [
	| comment raw escaped |

	comment := XMLComment new.
	self
		assertNode: comment hasType: #isComment;
		assertComment: comment hasString: '';
		assertComment: (comment string: 'test') hasString: 'test';
		assertComment: (XMLComment string: 'test') hasString: 'test'.
]

{ #category : #tests }
XMLNodesWithoutChildrenTest >> test7attributeNodes [
	| attribute element |

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

	element := XMLElement new.
	self
		assert: attribute element isNil;
		assert: (attribute element: element) element == element.
]
