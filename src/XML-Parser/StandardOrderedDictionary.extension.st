Extension { #name : #StandardOrderedDictionary }

{ #category : #'*XML-Parser' }
StandardOrderedDictionary >> xmlAt: aKey newPut: aValue [
	"should be identical to at:put: except it returns whether the key is new"
	| oldSize |

	oldSize := dictionary size.
	dictionary at: aKey put: aValue.
	dictionary size > oldSize
		ifTrue: [
			orderedKeys size > oldSize
				ifFalse: [self growOrderedKeys].
			orderedKeys at: oldSize + 1 put: aKey.
			^ true].
	^ false.
]
