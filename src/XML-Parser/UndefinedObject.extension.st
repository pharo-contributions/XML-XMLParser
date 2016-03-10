Extension { #name : #UndefinedObject }

{ #category : #'*XML-Parser' }
UndefinedObject >> xmlParserIsSeparator [
	"hack optimization to avoid testing for nil before sending
	this to objects from streams in XMLParser"
	^ false
]

{ #category : #'*XML-Parser' }
UndefinedObject >> xmlParserIsWhitespace [
	"hack optimization to avoid testing for nil before sending
	this to objects from streams in XMLParser"
	^ false
]
