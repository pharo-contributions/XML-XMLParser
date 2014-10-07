Extension { #name : #OrderedCollection }

{ #category : #'*XML-Parser' }
OrderedCollection >> lastOrNil [
	"for speed to avoid at:ifAbsent: closure"
	| lastOrNilOffset |

	(lastOrNilOffset := self size) > 0
		ifTrue: [^ self at: lastOrNilOffset]
		ifFalse: [^ nil]
]
