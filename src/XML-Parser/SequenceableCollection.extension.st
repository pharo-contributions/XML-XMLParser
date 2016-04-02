Extension { #name : #SequenceableCollection }

{ #category : #'*XML-Parser' }
SequenceableCollection >> xmlLastOrNil [
	"for speed to avoid at:ifAbsent: closure"
	| lastOrNilOffset |

	(lastOrNilOffset := self size) > 0
		ifTrue: [^ self at: lastOrNilOffset]
		ifFalse: [^ nil]
]
