Extension { #name : #UndefinedObject }

{ #category : #'*XML-Parser' }
UndefinedObject >> xmlParserASCIIValue [
	"optimization to allow treating nils as characters in BitmapCharacterSet
	includes testing"
	^ 0
]

{ #category : #'*XML-Parser' }
UndefinedObject >> xmlParserIsSeparator [
	"hack optimization to avoid testing for nil before sending
	xmlParserIsSeparator to objects from streams in XMLParser"
	^ false
]
