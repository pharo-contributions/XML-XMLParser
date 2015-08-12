Class {
	#name : #XMLCharacterMethodsTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser'
}

{ #category : #tests }
XMLCharacterMethodsTest >> testSplit [
	self
		assert: ($: xmlParserSplit: '') = (OrderedCollection with: '');
		assert: ($: xmlParserSplit: 'abc') = (OrderedCollection with: 'abc');
		assert: ($: xmlParserSplit: ':') = #('' '') asOrderedCollection;
		assert: ($: xmlParserSplit: '::') = #('' '' '') asOrderedCollection;
		assert: ($: xmlParserSplit: 'a:bc:') = #('a' 'bc' '') asOrderedCollection;
		assert: ($: xmlParserSplit: ':ab:c:') = #('' 'ab' 'c' '') asOrderedCollection;
		assert: ($: xmlParserSplit: 'a:bc:') = #('a' 'bc' '') asOrderedCollection;
		assert: ($: xmlParserSplit: 'ab::cd::ef') = #('ab'  '' 'cd' '' 'ef') asOrderedCollection;
		assert:
			($: xmlParserSplit: '::ab:::cd:::ef::') =
				#('' '' 'ab'  '' '' 'cd' '' '' 'ef' '' '') asOrderedCollection
]

{ #category : #tests }
XMLCharacterMethodsTest >> testXMLParserIsSeparator [
	| separators |

	separators := Character xmlParserSeparators.
	0 to: 255 do: [:each | | char |
		char := each asCharacter.
		(separators includes: char)
			ifTrue: [self assert: char xmlParserIsSeparator]
			ifFalse: [self deny: char xmlParserIsSeparator]].
]

{ #category : #tests }
XMLCharacterMethodsTest >> testXMLParserIsWhitespace [
	| whitespace |

	whitespace := Character xmlParserWhitespace.
	0 to: 255 do: [:each | | char |
		char := each asCharacter.
		(whitespace includes: char)
			ifTrue: [self assert: char xmlParserIsWhitespace]
			ifFalse: [self deny: char xmlParserIsWhitespace]].
]
