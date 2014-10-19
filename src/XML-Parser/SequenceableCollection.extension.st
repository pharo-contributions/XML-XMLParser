Extension { #name : #SequenceableCollection }

{ #category : #'*XML-Parser' }
SequenceableCollection >> lastOrNil [
	"for speed to avoid at:ifAbsent: closure"
	| lastOrNilOffset |

	(lastOrNilOffset := self size) > 0
		ifTrue: [^ self at: lastOrNilOffset]
		ifFalse: [^ nil]
]
