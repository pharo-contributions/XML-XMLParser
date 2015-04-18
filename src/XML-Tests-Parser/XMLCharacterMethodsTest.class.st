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
XMLCharacterMethodsTest >> testXMLParserASCIIValue [
	| characterSet |

	characterSet := BitmapCharacterSet new.
	self
		assert: nil xmlParserASCIIValue isZero;
		deny: (characterSet xmlParserIncludes: nil).
	(0 to: 16rF0000) do: [:each | | char |
		char := each asCharacter.
		self
			assert: char xmlParserASCIIValue = each;
			deny: (characterSet xmlParserIncludes: char).
		characterSet add: char.
		self assert: (characterSet xmlParserIncludes: char)].
	self assert: (characterSet xmlParserIncludes: nil).
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
