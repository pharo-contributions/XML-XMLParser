Extension { #name : #XMLOrderedList }

{ #category : #'*XML-Parser-GemstoneCompatibility' }
XMLOrderedList >> capacity [
	^ collection size
]

{ #category : #'*XML-Parser-GemstoneCompatibility' }
XMLOrderedList >> copyReplaceFrom: aStart to: aStop with: aReplacementCollection [
	| start stop |

	"bound the start and stop so they are always in range"
	start := (aStart max: 1) min: self size + 1.
	stop := (aStop max: start - 1) min: self size.
	^ self newWithCollection:
		(collection
			copyReplaceFrom: start
			to: stop
			with:
				"needed because gemstone's replaceFrom:to:with:startingAt: won't
				accept non-SequnceableCollection classes (which the arg isn't if
				it's an XMLOrderedList)"
				((aReplacementCollection isKindOf: SequenceableCollection)
					ifTrue: [aReplacementCollection]
					ifFalse: [aReplacementCollection asArray]))
]
