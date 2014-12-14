Extension { #name : #Character }

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
