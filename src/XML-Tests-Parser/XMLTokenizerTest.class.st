Class {
	#name : #XMLTokenizerTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser'
}

{ #category : #accessing }
XMLTokenizerTest class >> badNCNames [
	"all NC (non-qualified) names are names, but not all names are NC names"
	^ self badNames, self nonNCNameNames
]

{ #category : #accessing }
XMLTokenizerTest class >> badNames [
	"all names are Nmtokens, but not all Nmtokesn are names"
	^ self badNmtokens, self nonNameNmtokens
]

{ #category : #accessing }
XMLTokenizerTest class >> badNmtokenChars [
	"16r10FFFF is the max value a char can hold on GS, so nothing above it
	is tested for"
	^ #(16r00 16r01 16r0F 16r10
			16r2C 16r2F 16r40 16r5B
			16r5E 16r60 16r7B 16r80
			16rBF 16rD7 16rF7 16r37E
			16r2000 16r200B 16r200E 16r206F
			16r2190 16r2BFF 16r2FFF 16r3000
			16rD800 16rF8FF 16rFDD0 16rFDEF
			16rFFFE 16r0FFFF 16rF0000 16r10FFFF)
			collect: [:each | each asCharacter]
]

{ #category : #accessing }
XMLTokenizerTest class >> badNmtokens [
	^ #('' ' ' '	'), (self badNmtokenChars collect: [:each | 'test' copyWith: each])
]

{ #category : #accessing }
XMLTokenizerTest class >> nonNCNameNames [
	^ #(':' 'test:test' 'test:' ':test')
]

{ #category : #accessing }
XMLTokenizerTest class >> nonNameNmtokens [
	^ self nonNameStartCharNameChars collect: [:each | 'test' copyWithFirst: each]
]

{ #category : #accessing }
XMLTokenizerTest class >> nonNameStartCharNameChars [
	"NameChars that aren't NameStartChars"
	^ #($- $.
			$0 $1 $2 $3 $4 $5 $6 $7 $8 $9
			16rB7 16r0300 16r036F 16r203F 16r2040)
			collect: [:each | each asCharacter]
]

{ #category : #accessing }
XMLTokenizerTest >> badNCNames [
	^ self class badNCNames
]

{ #category : #accessing }
XMLTokenizerTest >> badNames [
	^ self class badNames
]

{ #category : #accessing }
XMLTokenizerTest >> badNmtokens [
	^ self class badNmtokens
]

{ #category : #accessing }
XMLTokenizerTest >> nonNCNameNames [
	^ self class nonNCNameNames
]

{ #category : #accessing }
XMLTokenizerTest >> nonNameNmtokens [
	^ self class nonNameNmtokens
]

{ #category : #tests }
XMLTokenizerTest >> testIsNCName [
	self badNCNames do: [:each |
		self deny: (self tokenizerClass isNCName: each)].
]

{ #category : #tests }
XMLTokenizerTest >> testIsName [
	self nonNCNameNames do: [:each |
		self assert: (self tokenizerClass isName: each)].
	self badNames do: [:each |
		self deny: (self tokenizerClass isName: each)].
]

{ #category : #tests }
XMLTokenizerTest >> testIsNmtoken [
	self nonNCNameNames do: [:each |
		self assert: (self tokenizerClass isNmtoken: each)].
	self nonNameNmtokens do: [:each |
		self assert: (self tokenizerClass isNmtoken: each)].
	self badNmtokens do: [:each |
		self deny: (self tokenizerClass isNmtoken: each)].
]

{ #category : #tests }
XMLTokenizerTest >> testNextNCNameFrom [
	| readStream writeStream |

	self badNCNames do: [:each |
		readStream := each readStream.
		writeStream := String new writeStream.
		(self tokenizerClass
			nextNCNameFrom: readStream
			on: writeStream)
			ifTrue: [
				"the size is tested instead of = for GS compatbility"
				self deny: writeStream contents size = each size]].
]

{ #category : #tests }
XMLTokenizerTest >> testNextNameFromOn [
	| readStream writeStream |

	self nonNCNameNames do: [:each |
		readStream := each readStream.
		writeStream := String new writeStream.
		self assert:
			(self tokenizerClass
				nextNameFrom: readStream
				on: writeStream).
		self assert: writeStream contents = each].

	self badNames do: [:each |
		readStream := each readStream.
		writeStream := String new writeStream.
		(self tokenizerClass
			nextNameFrom: readStream
			on: writeStream)
			ifTrue: [
				"the size is tested instead of = for GS compatbility"
				self deny: writeStream contents size = each size]].
]

{ #category : #tests }
XMLTokenizerTest >> testNextNmtokenFromOn [
	| readStream writeStream |

	self nonNCNameNames, self nonNameNmtokens do: [:each |
		readStream := each readStream.
		writeStream := String new writeStream.
		self assert:
			(self tokenizerClass
				nextNmtokenFrom: readStream
				on: writeStream).
		self assert: writeStream contents = each].

	self badNmtokens do: [:each |
		readStream := each readStream.
		writeStream := String new writeStream.
		(self tokenizerClass
			nextNmtokenFrom: readStream
			on: writeStream)
			ifTrue: [
				"the size is tested instead of = for GS compatbility"
				self deny: writeStream contents size = each size]].
]

{ #category : #accessing }
XMLTokenizerTest >> tokenizerClass [
	^ XMLWellFormedParserTokenizer
]
