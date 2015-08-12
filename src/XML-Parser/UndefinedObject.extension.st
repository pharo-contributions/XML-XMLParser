Extension { #name : #UndefinedObject }

{ #category : #'*XML-Parser' }
UndefinedObject >> xmlParserIsSeparator [
	"hack optimization to avoid testing for nil before sending
	xmlParserIsSeparator to objects from streams in XMLParser"
	^ false
]
