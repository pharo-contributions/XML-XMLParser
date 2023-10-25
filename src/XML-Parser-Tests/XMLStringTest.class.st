Class {
	#name : #XMLStringTest,
	#superclass : #XMLNodeTest,
	#category : #'XML-Parser-Tests-DOM'
}

{ #category : #accessing }
XMLStringTest >> nodeClass [
	^ XMLString
]

{ #category : #tests }
XMLStringTest >> testAcceptNodeVisitor [

	| visitor stringNode message |
	visitor := XMLRecordingNodeVisitor new.
	stringNode := self newNode.
	self
		assert: (stringNode acceptNodeVisitor: visitor)
		identicalTo: stringNode;
		assert: visitor messageRecorder hasMessages.

	message := visitor messageRecorder nextMessage.
	self
		assert: message selector identicalTo: #visitStringNode:;
		assert: message arguments equals: (Array with: stringNode);
		deny: visitor messageRecorder hasMessages
]

{ #category : #tests }
XMLStringTest >> testAppend [

	| stringNode |
	stringNode := self newNode.
	stringNode append: 'one'.
	self assert: stringNode string equals: 'one'.

	stringNode append: (self nodeClass string: 'two').
	self assert: stringNode string equals: 'onetwo'.

	stringNode append: 'three'.
	self assert: stringNode string equals: 'onetwothree'
]

{ #category : #tests }
XMLStringTest >> testAsString [

	self
		assert: self newNode asString equals: '';
		assert: (self nodeClass string: 'test') asString equals: 'test'
]

{ #category : #tests }
XMLStringTest >> testAsXMLEscapedString [

	| stringNode |
	stringNode := self nodeClass string: self markupString.
	self
		assert: stringNode string equals: self markupString;
		deny: stringNode string equals: self escapedString;
		assert: stringNode asXMLEscapedString equals: self escapedString
]

{ #category : #tests }
XMLStringTest >> testAsXMLStringNode [

	| stringNode |
	stringNode := self newNode.
	self assert: stringNode asXMLStringNode identicalTo: stringNode
]

{ #category : #tests }
XMLStringTest >> testBeginsWith [
	| stringNode |

	stringNode := self nodeClass string: 'test'.
	0 to: stringNode string size - 1 do: [:i | | prefix |
		prefix := stringNode string allButLast: i.
		self
			assert: (stringNode beginsWith: prefix);
			assert: (stringNode beginsWith: (self nodeClass string: prefix));
			deny: (stringNode beginsWith: (prefix copyWith: $.));
			deny: (stringNode beginsWith: (self nodeClass string: (prefix copyWith: $.)))]
]

{ #category : #tests }
XMLStringTest >> testCanonicallyEquals [
	super testCanonicallyEquals.
	self assert:
		((self nodeClass string: 'test') canonicallyEquals:
			(self nodeClass string: 'test')).
	self deny:
		((self nodeClass string: 'test') canonicallyEquals:
			self newNode)
]

{ #category : #tests }
XMLStringTest >> testDeleteFromTo [

	| stringNode |
	stringNode := self newNode.
	stringNode deleteFrom: 1 to: 0.
	self assert: stringNode string equals: ''.

	stringNode append: 'onetwothree'.
	stringNode deleteFrom: 0 to: -1.
	stringNode deleteFrom: 12 to: 13.
	self assert: stringNode string equals: 'onetwothree'.

	stringNode deleteFrom: 4 to: 6.
	self assert: stringNode string equals: 'onethree'.

	stringNode deleteFrom: 4 to: 8.
	self assert: stringNode string equals: 'one'.

	stringNode deleteFrom: 1 to: 3.
	self assert: stringNode string equals: ''
]

{ #category : #tests }
XMLStringTest >> testEndsWith [
	| stringNode |

	stringNode := self nodeClass string: 'test'.
	0 to: stringNode string size - 1 do: [:i | | suffix |
		suffix := stringNode string allButFirst: i.
		self
			assert: (stringNode endsWith: suffix);
			assert: (stringNode endsWith: (self nodeClass string: suffix));
			deny: (stringNode endsWith: (suffix copyWithFirst: $.));
			deny: (stringNode endsWith: (self nodeClass string: (suffix copyWithFirst: $.)))]
]

{ #category : #tests }
XMLStringTest >> testIncludesSubstring [
	| stringNode |

	stringNode := self newNode.
	self
		assert: (stringNode includesSubstring: '');
		assert: (stringNode includesSubstring: (self nodeClass string: ''));
		deny: (stringNode includesSubstring: 'one');
		deny: (stringNode includesSubstring: (self nodeClass string: 'one')).
	stringNode prepend: 'one'.
	self
		assert: (stringNode includesSubstring: 'one');
		assert: (stringNode includesSubstring: (self nodeClass string: 'one')).

	self
		deny: (stringNode includesSubstring: 'three');
		deny: (stringNode includesSubstring: (self nodeClass string: 'three')).
	stringNode append: 'three'.
	self
		assert: (stringNode includesSubstring: 'three');
		assert: (stringNode includesSubstring: (self nodeClass string: 'three')).

	self
		deny: (stringNode includesSubstring: 'two');
		deny: (stringNode includesSubstring: (self nodeClass string: 'two')).
	stringNode replaceFrom: 4 to: 3 with: 'two'.
	self
		assert: (stringNode includesSubstring: 'two');
		assert: (stringNode includesSubstring: (self nodeClass string: 'two')).

	self
		assert: (stringNode includesSubstring: '');
		assert: (stringNode includesSubstring: (self nodeClass string: ''))
]

{ #category : #tests }
XMLStringTest >> testIndexOfSubstring [

	| stringNode |
	stringNode := self newNode.
	self
		assert: (stringNode indexOfSubstring: 'one') isZero;
		assert:
			(stringNode indexOfSubstring: (self nodeClass string: 'one'))
				isZero.
	stringNode prepend: 'one'.
	self
		assert: (stringNode indexOfSubstring: 'one') equals: 1;
		assert:
			(stringNode indexOfSubstring: (self nodeClass string: 'one'))
		equals: 1.

	self
		assert: (stringNode indexOfSubstring: 'two') isZero;
		assert:
			(stringNode indexOfSubstring: (self nodeClass string: 'two'))
				isZero.
	stringNode append: 'two'.
	self
		assert: (stringNode indexOfSubstring: 'two') equals: 4;
		assert:
			(stringNode indexOfSubstring: (self nodeClass string: 'two'))
		equals: 4
]

{ #category : #tests }
XMLStringTest >> testIsContentNode [
	self assert: self newNode isContentNode
]

{ #category : #tests }
XMLStringTest >> testIsEmpty [
	| node |

	node := self newNode.
	self assert: node isEmpty.

	node string: ' '.
	self deny: node isEmpty.

	node string: ''.
	self assert: node isEmpty
]

{ #category : #tests }
XMLStringTest >> testIsStringNode [
	| stringNode |

	self assert: self newNode isStringNode.

	stringNode := self newNode.
	self
		assert: (stringNode isStringNode: '');
		assert: (stringNode isStringNode: self newNode);
		deny: (stringNode isStringNode: 'test');
		deny: (stringNode isStringNode: (self nodeClass string: 'test')).

	stringNode string: 'test'.
	self
		assert: (stringNode isStringNode: 'test');
		assert: (stringNode isStringNode: (self nodeClass string: 'test'));
		deny: (stringNode isStringNode: '');
		deny: (stringNode isStringNode: self newNode)
]

{ #category : #tests }
XMLStringTest >> testIsWhitespace [
	| stringNode |

	stringNode := self newNode.
	self deny: stringNode isWhitespace.

	stringNode string: Character xmlWhitespace.
	self assert: stringNode isWhitespace.

	stringNode append: 'non-space'.
	self deny: stringNode isWhitespace
]

{ #category : #tests }
XMLStringTest >> testMergeAdjacent [

	| element nodes |
	(element := self newElement)
		addNode: (self nodeClass string: 'one');
		addNode: (self nodeClass string: 'two');
		addNode: (self nodeClass string: 'three');
		addNode: XMLComment new;
		addNode: (self nodeClass string: 'four');
		addNode: (self nodeClass string: 'five');
		addNode: XMLComment new;
		addNode: (self nodeClass string: 'six').

	element nodes second mergeAdjacent.
	nodes := element nodes.
	self
		assert: nodes size equals: 6;
		assert:
			(nodes first isStringNode and: [
					 nodes first string = 'onetwothree' ]);
		assert: nodes second isComment;
		assert:
			(nodes third isStringNode and: [ nodes third string = 'four' ]);
		assert:
			(nodes fourth isStringNode and: [ nodes fourth string = 'five' ]);
		assert: nodes fifth isComment;
		assert:
			(nodes sixth isStringNode and: [ nodes sixth string = 'six' ]).

	nodes fourth mergeAdjacent.
	nodes fifth mergeAdjacent.
	self
		assert: nodes size equals: 5;
		assert:
			(nodes first isStringNode and: [
					 nodes first string = 'onetwothree' ]);
		assert: nodes second isComment;
		assert:
			(nodes third isStringNode and: [ nodes third string = 'fourfive' ]);
		assert: nodes fourth isComment;
		assert:
			(nodes fifth isStringNode and: [ nodes fifth string = 'six' ])
]

{ #category : #tests }
XMLStringTest >> testNotEmpty [
	| node |

	node := self newNode.
	self deny: node isNotEmpty.

	node string: ' '.
	self assert: node isNotEmpty.

	node string: ''.
	self deny: node isNotEmpty
]

{ #category : #tests }
XMLStringTest >> testPrepend [

	| stringNode |
	stringNode := self newNode.
	stringNode prepend: 'three'.
	self assert: stringNode string equals: 'three'.

	stringNode prepend: (self nodeClass string: 'two').
	self assert: stringNode string equals: 'twothree'.

	stringNode prepend: 'one'.
	self assert: stringNode string equals: 'onetwothree'
]

{ #category : #tests }
XMLStringTest >> testReplaceAllWith [

	| stringNode |
	(stringNode := self newNode) replaceAll: 'old' with: 'new'.
	self assert: stringNode string equals: ''.

	stringNode string: 'one old two old three old'.
	stringNode replaceAll: 'old' with: (self nodeClass string: 'new').
	self assert: stringNode string equals: 'one new two new three new'.

	stringNode replaceAll: 'new' with: ''.
	self assert: stringNode string equals: 'one  two  three '
]

{ #category : #tests }
XMLStringTest >> testReplaceFromToWith [

	| stringNode |
	(stringNode := self newNode) replaceFrom: -1 to: -3 with: 'one'.
	self assert: stringNode string equals: 'one'.

	stringNode replaceFrom: 1 to: 0 with: 'zero'.
	self assert: stringNode string equals: 'zeroone'.

	stringNode
		replaceFrom: 9
		to: 7
		with: (self nodeClass string: 'fourthree').
	self assert: stringNode string equals: 'zeroonefourthree'.

	stringNode replaceFrom: 8 to: 11 with: ' two '.
	self assert: stringNode string equals: 'zeroone two three'.

	stringNode replaceFrom: 0 to: 4 with: ''.
	self assert: stringNode string equals: 'one two three'.

	stringNode
		replaceFrom: 14
		to: 13
		with: (self nodeClass string: ' four').
	self assert: stringNode string equals: 'one two three four'
]

{ #category : #tests }
XMLStringTest >> testSize [

	self
		assert: self newNode size equals: 0;
		assert: (self nodeClass string: 'test') size equals: 4
]

{ #category : #tests }
XMLStringTest >> testSortKey [

	self assert: (self nodeClass string: 'test') sortKey equals: 'test'
]

{ #category : #tests }
XMLStringTest >> testSplitAt [

	| stringNode newStringNode element |
	stringNode := self nodeClass string: 'onetwo'.
	newStringNode := stringNode splitAt: 0.
	self
		deny: stringNode identicalTo: newStringNode;
		assert: stringNode string equals: '';
		assert: newStringNode string equals: 'onetwo'.

	stringNode := self nodeClass string: 'onetwo'.
	newStringNode := stringNode splitAt: 7.
	self
		deny: stringNode identicalTo: newStringNode;
		assert: stringNode string equals: 'onetwo';
		assert: newStringNode string equals: ''.

	(element := self newElement) addNode: stringNode.
	newStringNode := stringNode splitAt: 4.
	self
		deny: stringNode identicalTo: newStringNode;
		assert: stringNode string equals: 'one';
		assert: newStringNode string equals: 'two';
		assert: (element nodeAfter: stringNode) identicalTo: newStringNode
]

{ #category : #tests }
XMLStringTest >> testString [

	| stringNode |
	stringNode := self nodeClass string: self markupString.
	self
		assert: stringNode class identicalTo: self nodeClass;
		assert: stringNode string equals: self markupString.

	stringNode := self newNode.
	self assert: stringNode string equals: ''.

	stringNode string: self markupString.
	self assert: stringNode string equals: self markupString.

	stringNode string: ''.
	self assert: stringNode string equals: ''
]

{ #category : #tests }
XMLStringTest >> testWriteXMLOn [

	self assert: self newNode printString equals: ''.
	self
		assert: (self nodeClass string: self markupString) printString
		equals: self escapedString
]
