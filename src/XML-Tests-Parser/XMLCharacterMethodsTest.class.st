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

	separators := #(
			32 "Character space asciiValue"
			9 "Character tab asciiValue"
			13 "Character cr asciiValue"
			10 "Character lf asciiValue"
		) asSet.
	0 to: 255 do: [:each |
		(separators includes: each)
			ifTrue: [self assert: each asCharacter xmlParserIsSeparator]
			ifFalse: [self deny: each asCharacter xmlParserIsSeparator]].
]

{ #category : #tests }
XMLCharacterMethodsTest >> testXMLParserIsWhitespace [
	| whitespace |

	whitespace := #(
			32 "Character space asciiValue"
			9 "Character tab asciiValue"
			13 "Character cr asciiValue"
			10 "Character lf asciiValue"
			12 "Character newPage asciiValue"
		) asSet.
	0 to: 255 do: [:each |
		(whitespace includes: each)
			ifTrue: [self assert: each asCharacter xmlParserIsWhitespace]
			ifFalse: [self deny: each asCharacter xmlParserIsWhitespace]].
]
