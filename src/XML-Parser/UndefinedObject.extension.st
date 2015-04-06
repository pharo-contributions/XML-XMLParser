Extension { #name : #UndefinedObject }

{ #category : #'*XML-Parser' }
UndefinedObject >> xmlParserIsSeparator [
	"hack optimization to avoid testing for nil before sending
	isSeparator in XMLParser"
	^ false
]
