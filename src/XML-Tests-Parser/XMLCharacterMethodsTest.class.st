Class {
	#name : #XMLCharacterMethodsTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser'
}

{ #category : #accesing }
XMLCharacterMethodsTest class >> nonChars [
	^ #(16r0 16r1 16r2 16r3 16r4 16r5 16r6 16r7 16r8
			16rB 16rC 16rE 16rF
			16r10 16r11 16r12 16r13 16r14 16r15 16r16 16r17 16r18 16r19
			16r1A 16r1B 16r1C 16r1D 16r1E 16r1F
			16rD800 16rDFFF
			16rFFFE 16rFFFF)
			collect: [:each | each asCharacter]
]

{ #category : #tests }
XMLCharacterMethodsTest >> testIsXMLChar [
	self class nonChars do: [:each |
		self deny: each isXMLChar]
]

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
