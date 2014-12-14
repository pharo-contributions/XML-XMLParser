Class {
	#name : #XMLStringTest,
	#superclass : #XMLNodeTest,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #accessing }
XMLStringTest >> nodeClass [
	^ XMLString
]

{ #category : #tests }
XMLStringTest >> testAddContent [
	| node |

	node := self nodeClass new.
	node addContent: 'one'.
	self assert: node string = 'one'.

	node addContent: (self nodeClass string: 'two').
	self assert: node string = 'onetwo'.

	node addContent: 'three'.
	self assert: node string = 'onetwothree'.
]

{ #category : #tests }
XMLStringTest >> testAppend [
	| node |

	node := self nodeClass new.
	node append: 'one'.
	self assert: node string = 'one'.

	node append: (self nodeClass string: 'two').
	self assert: node string = 'onetwo'.

	node append: 'three'.
	self assert: node string = 'onetwothree'.
]

{ #category : #tests }
XMLStringTest >> testAsString [
	self
		assert: self nodeClass new asString isEmpty;
		assert: (self nodeClass string: 'test') asString = 'test'
]

{ #category : #tests }
XMLStringTest >> testAsXMLEscapedString [
	| node |

	node := self nodeClass string: self markupString.
	self	
		assert: node string = self markupString;
		deny: node string = self escapedString;
		assert: node asXMLEscapedString = self escapedString.
]

{ #category : #tests }
XMLStringTest >> testAsXMLString [
	| node |

	node := self nodeClass new.
	self assert: node asXMLString == node.
]

{ #category : #tests }
XMLStringTest >> testBeginsWith [
	| node |

	node := self nodeClass string: 'test'.
	0 to: node string size - 1 do: [:i | | prefix |
		prefix := node string allButLast: i.
		self
			assert: (node beginsWith: prefix);
			assert: (node beginsWith: (self nodeClass string: prefix));
			deny: (node beginsWith: (prefix copyWith: $.));
			deny: (node beginsWith: (self nodeClass string: (prefix copyWith: $.)))].
]

{ #category : #tests }
XMLStringTest >> testCanonicallyEquals [
	super testCanonicallyEquals.
	self
		assert: ((self nodeClass string: 'test') canonicallyEquals: (self nodeClass string: 'test'));
		deny: ((self nodeClass string: 'test') canonicallyEquals: self nodeClass new).
]

{ #category : #tests }
XMLStringTest >> testContentString [
	super testContentString.
	self
		assert: (self nodeClass string: 'test') contentString = 'test';
		assert: ((self nodeClass new) contentString: 'test') contentString = 'test'.
]

{ #category : #tests }
XMLStringTest >> testDeleteFromTo [
	| node |

	node := self nodeClass new.
	node deleteFrom: 1 to: 0.
	self assert: node string isEmpty.

	node append: 'onetwothree'.
	node deleteFrom: 0 to: -1.
	node deleteFrom: 12 to: 13.
	self assert: node string = 'onetwothree'.

	node deleteFrom: 4 to: 6.
	self assert: node string = 'onethree'.

	node deleteFrom: 4 to: 8.
	self assert: node string = 'one'.

	node deleteFrom: 1 to: 3.
	self assert: node string isEmpty.
]

{ #category : #tests }
XMLStringTest >> testEndsWith [
	| node |

	node := self nodeClass string: 'test'.
	0 to: node string size - 1 do: [:i | | suffix |
		suffix := node string allButFirst: i.
		self
			assert: (node endsWith: suffix);
			assert: (node endsWith: (self nodeClass string: suffix));
			deny: (node endsWith: (suffix copyWithFirst: $.));
			deny: (node endsWith: (self nodeClass string: (suffix copyWithFirst: $.)))].
]

{ #category : #tests }
XMLStringTest >> testIncludesSubstring [
	| node |

	node := self nodeClass new.
	self
		deny: (node includesSubstring: 'one');
		deny: (node includesSubstring: (self nodeClass string: 'one')).
	node prepend: 'one'.
	self
		assert: (node includesSubstring: 'one');
		assert: (node includesSubstring: (self nodeClass string: 'one')).

	self
		deny: (node includesSubstring: 'three');
		deny: (node includesSubstring: (self nodeClass string: 'three')).
	node append: 'three'.
	self
		assert: (node includesSubstring: 'three');
		assert: (node includesSubstring: (self nodeClass string: 'three')).

	self
		deny: (node includesSubstring: 'onetwothree');
		deny: (node includesSubstring: (self nodeClass string: 'onetwothree')).
	node replaceFrom: 4 to: 3 with: 'two'.
	self
		assert: (node includesSubstring: 'onetwothree');
		assert: (node includesSubstring: (self nodeClass string: 'onetwothree')).
]

{ #category : #tests }
XMLStringTest >> testIndexOfSubstring [
	| node |

	node := self nodeClass new.
	self
		assert: (node indexOfSubstring: 'one') isZero;
		assert: (node indexOfSubstring: (self nodeClass string: 'one')) isZero.
	node prepend: 'one'.
	self
		assert: (node indexOfSubstring: 'one') = 1;
		assert: (node indexOfSubstring: (self nodeClass string: 'one')) = 1.

	self
		assert: (node indexOfSubstring: 'two') isZero;
		assert: (node indexOfSubstring: (self nodeClass string: 'two')) isZero.
	node append: 'two'.
	self
		assert: (node indexOfSubstring: 'two') = 4;
		assert: (node indexOfSubstring: (self nodeClass string: 'two')) = 4.
]

{ #category : #tests }
XMLStringTest >> testIsContentNode [
	self assert: self nodeClass new isContentNode
]

{ #category : #tests }
XMLStringTest >> testIsEmpty [
	self
		assert: self nodeClass new isEmpty;
		deny: (self nodeClass string: ' ') isEmpty
]

{ #category : #tests }
XMLStringTest >> testIsString [
	| node |

	node := self nodeClass new.
	self
		assert: (node isString: '');
		assert: (node isString: self nodeClass new);
		deny: (node isString: 'test');
		deny: (node isString: (self nodeClass string: 'test')).
	node string: 'test'.
	self
		assert: (node isString: 'test');
		assert: (node isString: (self nodeClass string: 'test'));
		deny: (node isString: '');
		deny: (node isString: self nodeClass new).
]

{ #category : #tests }
XMLStringTest >> testIsStringNode [
	| node |

	self assert: self nodeClass new isStringNode.

	node := self nodeClass new.
	self
		assert: (node isStringNode: '');
		assert: (node isStringNode: self nodeClass new);
		deny: (node isStringNode: 'test');
		deny: (node isStringNode: (self nodeClass string: 'test')).
	node string: 'test'.
	self
		assert: (node isStringNode: 'test');
		assert: (node isStringNode: (self nodeClass string: 'test'));
		deny: (node isStringNode: '');
		deny: (node isStringNode: self nodeClass new).
]

{ #category : #tests }
XMLStringTest >> testIsWhitespace [
	| node |

	node := self nodeClass new.
	self deny: node isWhitespace.

	node string: self whitespaceCharacters.
	self assert: node isWhitespace.

	node append: 'non-space'.
	self deny: node isWhitespace.
]

{ #category : #tests }
XMLStringTest >> testMergeAdjacent [
	| element nodes |

	(element := XMLElement new)
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
		assert: nodes size = 6;
		assert: (nodes first isStringNode and: [nodes first string = 'onetwothree']);
		assert: nodes second isComment;
		assert: (nodes third isStringNode and: [nodes third string = 'four']);
		assert: (nodes fourth isStringNode and: [nodes fourth string = 'five']);
		assert: nodes fifth isComment;
		assert: (nodes sixth isStringNode and: [nodes sixth string = 'six']).

	nodes fourth mergeAdjacent.
	nodes fifth mergeAdjacent.
	self
		assert: nodes size = 5;
		assert: (nodes first isStringNode and: [nodes first string = 'onetwothree']);
		assert: nodes second isComment;
		assert: (nodes third isStringNode and: [nodes third string = 'fourfive']);
		assert: nodes fourth isComment;
		assert: (nodes fifth isStringNode and: [nodes fifth string = 'six']).
]

{ #category : #tests }
XMLStringTest >> testPrepend [
	| node |

	node := self nodeClass new.
	node prepend: 'three'.
	self assert: node string = 'three'.

	node prepend: (self nodeClass string: 'two').
	self assert: node string = 'twothree'.

	node prepend: 'one'.
	self assert: node string = 'onetwothree'.
]

{ #category : #tests }
XMLStringTest >> testReplaceAllWith [
	| node |

	(node := self nodeClass new) replaceAll: 'old' with: 'new'.
	self assert: node string isEmpty.

	node string: 'one old two old three old'.
	node replaceAll: 'old' with: (self nodeClass string: 'new').
	self assert: node string = 'one new two new three new'.

	node replaceAll: 'new' with: ''.
	self assert: node string = 'one  two  three '.
]

{ #category : #tests }
XMLStringTest >> testReplaceFromToWith [
	| node |

	(node := self nodeClass new) replaceFrom: -1 to: -3 with: 'one'.
	self assert: node string = 'one'.

	node replaceFrom: 5 to: 3 with: (self nodeClass string: 'fourthree').
	self assert: node string = 'onefourthree'.

	node replaceFrom: 4 to: 7 with: ' two '.
	self assert: node string = 'one two three'.

	node replaceFrom: 14 to: 13 with: (self nodeClass string: ' four').
	self assert: node string = 'one two three four'.
]

{ #category : #tests }
XMLStringTest >> testSize [
	self
		assert: self nodeClass new size = 0;
		assert: (self nodeClass string: 'test') size = 4
]

{ #category : #tests }
XMLStringTest >> testSortKey [
	self assert: (self nodeClass string: 'test') sortKey = 'test'
]

{ #category : #tests }
XMLStringTest >> testSplitAt [
	| node newNode element |

	node := self nodeClass string: 'onetwo'.
	newNode := node splitAt: 0.
	self
		deny: node == newNode;
		assert: node string isEmpty;
		assert: newNode string = 'onetwo'.

	node := self nodeClass string: 'onetwo'.
	newNode := node splitAt: 7.
	self
		deny: node == newNode;
		assert: node string = 'onetwo';
		assert: newNode string isEmpty.

	(element := XMLElement new) addNode: node.
	newNode := node splitAt: 4.
	self
		deny: node == newNode;
		assert: node string = 'one';
		assert: newNode string = 'two';
		assert: (element nodeAfter: node) == newNode.
]

{ #category : #tests }
XMLStringTest >> testString [
	| node |

	node := self nodeClass new.
	self assert: node string isEmpty.

	node string: self markupString.
	self assert: node string = self markupString.

	node string: ''.
	self assert: node string isEmpty.
]

{ #category : #tests }
XMLStringTest >> testWriteXMLOn [
	self
		assert: self nodeClass new printString isEmpty;
		assert: (self nodeClass string: self markupString) printString = self escapedString.
]

{ #category : #accessing }
XMLStringTest >> whitespaceCharacters [
	"for portability"
	^ String withAll:
		(((0 to: 255) collect: [:each | each asCharacter])
			select: [:each | each isSeparator])
]
