Class {
	#name : #XMLCharacterMethodsTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser'
}

{ #category : #tests }
XMLCharacterMethodsTest >> testIsXMLSeparator [
	| separators |

	separators := Character xmlSeparators.
	0 to: 255 do: [:each | | char |
		char := each asCharacter.
		(separators includes: char)
			ifTrue: [self assert: char isXMLSeparator]
			ifFalse: [self deny: char isXMLSeparator]].
	self
		assert: (nil respondsTo: #isXMLSeparator);
		deny: nil isXMLSeparator.
]

{ #category : #tests }
XMLCharacterMethodsTest >> testIsXMLWhitespace [
	| whitespace |

	whitespace := Character xmlWhitespace.
	0 to: 255 do: [:each | | char |
		char := each asCharacter.
		(whitespace includes: char)
			ifTrue: [self assert: char isXMLWhitespace]
			ifFalse: [self deny: char isXMLWhitespace]].
	self
		assert: (nil respondsTo: #isXMLWhitespace);
		deny: nil isXMLWhitespace.
]

{ #category : #tests }
XMLCharacterMethodsTest >> testXMLSplit [
	self
		assert: ($: xmlSplit: '') = (OrderedCollection with: '');
		assert: ($: xmlSplit: 'abc') = (OrderedCollection with: 'abc');
		assert: ($: xmlSplit: ':') = #('' '') asOrderedCollection;
		assert: ($: xmlSplit: '::') = #('' '' '') asOrderedCollection;
		assert: ($: xmlSplit: 'a:bc:') = #('a' 'bc' '') asOrderedCollection;
		assert: ($: xmlSplit: ':ab:c:') = #('' 'ab' 'c' '') asOrderedCollection;
		assert: ($: xmlSplit: 'a:bc:') = #('a' 'bc' '') asOrderedCollection;
		assert: ($: xmlSplit: 'ab::cd::ef') = #('ab'  '' 'cd' '' 'ef') asOrderedCollection;
		assert:
			($: xmlSplit: '::ab:::cd:::ef::') =
				#('' '' 'ab'  '' '' 'cd' '' '' 'ef' '' '') asOrderedCollection
]
