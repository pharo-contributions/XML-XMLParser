Extension { #name : #WriteStream }

{ #category : #'*xml-parser' }
WriteStream >> stringContents [
	| newSize |

	newSize := position.
	^ (collection class new: newSize)	
		replaceFrom: 1
		to: newSize
		with: collection
		startingAt: 1
]
