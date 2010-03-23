Extension { #name : #WriteStream }

{ #category : #'*xml-parser' }
WriteStream >> stringContents [
	| newSize |

	newSize := position.
	^ (String new: newSize)	
		replaceFrom: 1
		to: newSize
		with: collection
		startingAt: 1
]
