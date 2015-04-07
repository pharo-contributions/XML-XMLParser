Extension { #name : #Character }

{ #category : #'*XML-Parser' }
Character >> xmlParserIsSeparator [
	"Overridden in Gemstone version"
	value = 32 "space"
		ifTrue: [^ true].
	value = 10 "lf"
		ifTrue: [^ true].
	value = 9 "tab"
		ifTrue: [^ true].
	value = 13 "cr"
		ifTrue: [^ true].
	"no form feeds"
	^ false.
]

{ #category : #'*XML-Parser' }
Character >> xmlParserIsWhitespace [
	"Overridden in Gemstone version"
	value = 32 "space"
		ifTrue: [^ true].
	value = 10 "lf"
		ifTrue: [^ true].
	value = 9 "tab"
		ifTrue: [^ true].
	value = 13 "cr"
		ifTrue: [^ true].
	value = 12 "form feed"
		ifTrue: [^ true].
	^ false.
]

{ #category : #'*XML-Parser' }
Character class >> xmlParserSeparators [
	^ String
		with: 32 asCharacter "Character space asciiValue"
		with: 10 asCharacter "Character lf asciiValue"
		with: 9 asCharacter "Character tab asciiValue"
		with: 13 asCharacter "Character cr asciiValue"
]

{ #category : #'*XML-Parser' }
Character >> xmlParserSplit: aCollection [
	"faster, portable version"
	| parts |

	parts := OrderedCollection new.
	self xmlParserSplit: aCollection do: [:each | parts addLast: each].
	^ parts.
]

{ #category : #'*XML-Parser' }
Character >> xmlParserSplit: aCollection do: aBlock [
	"faster, portable version"
	| start |

	start := 1.
	1 to: aCollection size do: [:end |
		((aCollection at: end) == self)
			ifTrue: [
				aBlock value: (aCollection copyFrom: start to: end - 1).
				start := end + 1]].
	start > aCollection size
		ifTrue: [aBlock value: '']
		ifFalse: [aBlock value: (aCollection copyFrom: start to: aCollection size)].
]

{ #category : #'*XML-Parser' }
Character class >> xmlParserWhitespace [
	^ self xmlParserSeparators copyWith:
		12 asCharacter "Character newPage asciiValue"
]
