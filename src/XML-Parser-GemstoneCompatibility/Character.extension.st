Extension { #name : #Character }

{ #category : #'*XML-Parser-GemstoneCompatibility' }
Character >> xmlParserASCIIValue [
	^ self asciiValue
]

{ #category : #'*XML-Parser-GemstoneCompatibility' }
Character >> xmlParserIsSeparator [
	| tmpValue |

	(tmpValue := self asciiValue) == 32 "space"
		ifTrue: [^ true].
	tmpValue == 10 "lf"
		ifTrue: [^ true].
	tmpValue == 9 "tab"
		ifTrue: [^ true].
	tmpValue == 13 "cr"
		ifTrue: [^ true].
	"no form feeds"
	^ false.
]

{ #category : #'*XML-Parser-GemstoneCompatibility' }
Character >> xmlParserIsWhitespace [
	| tmpValue |

	(tmpValue := self asciiValue) == 32 "space"
		ifTrue: [^ true].
	tmpValue == 10 "lf"
		ifTrue: [^ true].
	tmpValue == 9 "tab"
		ifTrue: [^ true].
	tmpValue == 13 "cr"
		ifTrue: [^ true].
	tmpValue == 12 "form feed"
		ifTrue: [^ true].
	^ false.
]
