Extension { #name : #Stream }

{ #category : #'*XML-Parser' }
Stream >> parseXML [
	^ XMLDOMParser parse: self
]

{ #category : #'*XML-Parser' }
Stream >> xmlParserAtBeginning [
	"overridden in the GS version to use Stream>>atBeginning because
	not all streams are 0-based on GS"

	^ self position = 0
]
