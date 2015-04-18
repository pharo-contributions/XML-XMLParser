Extension { #name : #BitmapCharacterSet }

{ #category : #'*XML-Parser' }
BitmapCharacterSet >> xmlParserIncludes: aCharacterOrNil [
	"should be exactly the same as includes: except uses xmlParserASCIIValue
	instead of asciiValue and so can accept both chars and nil as arguments.
	used to avoid nil tests when the set does not include the null character"
	| asciiValue |

	(asciiValue := aCharacterOrNil xmlParserASCIIValue) < 256
		ifTrue: [^ byteCharacters at: asciiValue + 1]
		ifFalse: [| byteIndex |
			wideCharacters
				ifNil: [^ false].
			(byteIndex := (asciiValue // 8) - 32 + 1) > wideCharacters size
				ifTrue: [^ false].
			^ ((wideCharacters at: byteIndex) bitAnd:
				(16r80 bitShift: (asciiValue \\ 8) negated)) > 0]
]
