Extension { #name : #PositionableStream }

{ #category : #'*XML-Parser' }
PositionableStream >> xmlParserAtBeginning [
	"overridden in Gemstone version"
	^ position = 0
]
