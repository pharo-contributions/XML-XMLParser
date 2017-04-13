Extension { #name : #LazyStandardOrderedDictionary }

{ #category : #'*XML-Parser' }
LazyStandardOrderedDictionary >> xmlAt: aKey newPut: aValue [
	"add just to be consistent with StandardOrderedDictionary, but it
	should not be needed"
	^ self copiedOrderPreservingDictionary
		xmlAt: aKey
		newPut: aValue
]
