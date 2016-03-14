Extension { #name : #Character }

{ #category : #'*XML-Parser' }
Character >> isXMLSeparator [
	"a temp is used because Character in newer SpurVM images
	has no 'value' inst var"
	| tempValue |

	(tempValue := self asciiValue) = 32 "space"
		ifTrue: [^ true].
	tempValue = 10 "lf"
		ifTrue: [^ true].
	tempValue = 9 "tab"
		ifTrue: [^ true].
	tempValue = 13 "cr"
		ifTrue: [^ true].
	"no form feeds"
	^ false.
]

{ #category : #'*XML-Parser' }
Character >> isXMLWhitespace [
	"a temp is used because Character in newer SpurVM images
	has no 'value' inst var"
	| tempValue |

	(tempValue := self asciiValue) = 32 "space"
		ifTrue: [^ true].
	tempValue = 10 "lf"
		ifTrue: [^ true].
	tempValue = 9 "tab"
		ifTrue: [^ true].
	tempValue = 13 "cr"
		ifTrue: [^ true].
	tempValue = 12 "form feed"
		ifTrue: [^ true].
	^ false.
]

{ #category : #'*XML-Parser' }
Character class >> xmlSeparators [
	^ String
		with: 32 asCharacter "space"
		with: 10 asCharacter "lf"
		with: 9 asCharacter "tab"
		with: 13 asCharacter "cr"
]

{ #category : #'*XML-Parser' }
Character >> xmlSplit: aCollection [
	"faster, portable version"
	| parts |

	parts := OrderedCollection new.
	self
		xmlSplit: aCollection
		do: [:each | parts addLast: each].
	^ parts.
]

{ #category : #'*XML-Parser' }
Character >> xmlSplit: aCollection do: aBlock [
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
Character class >> xmlWhitespace [
	^ self xmlSeparators copyWith: 12 asCharacter "form feed"
]
