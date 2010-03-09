"
This is a generic parser that supports rudimentary handling of elements and character data. For a more complete SAX-like API, see SAXHandler (and SAXDriver). For a DOM-like API, see XMLDOMParser and the classes under XML-Parser-Nodes.
"
Class {
	#name : #XMLParser,
	#superclass : #XMLTokenizer,
	#category : #'XML-Parser-Parser'
}

{ #category : #callbacks }
XMLParser >> attribute: aName value: aValue [
	"This method is called for each attribute/value pair in a start tag"

	^self subclassResponsibility
]

{ #category : #callbacks }
XMLParser >> beginStartTag: aString asPI: aBoolean [
	"This method is called for at the beginning of a start tag.
	The asPI parameter defines whether or not the tag is a 'processing
	instruction' rather than a 'normal' tag."

	^self subclassResponsibility
]

{ #category : #callbacks }
XMLParser >> endStartTag: aString [
	"This method is called at the end of the start tag after all of the
	attributes have been processed"

	^self subclassResponsibility
]

{ #category : #callbacks }
XMLParser >> endTag: aString [
	"This method is called when the parser encounters either an
	end tag or the end of a unary tag"

	^self subclassResponsibility
]

{ #category : #'handling tokens' }
XMLParser >> handleCData: aString [
	self text: aString
]

{ #category : #'handling tokens' }
XMLParser >> handleEndTag: aString [
	self endTag: aString
]

{ #category : #'handling tokens' }
XMLParser >> handlePCData: aString [
	self text: aString
]

{ #category : #'handling tokens' }
XMLParser >> handleStartTag: tagName attributes: attributes [
	self beginStartTag: tagName asPI: false.
	attributes keysAndValuesDo: [:key :value |
		self attribute: key value: value].
	self endStartTag: tagName
]

{ #category : #callbacks }
XMLParser >> text: aString [
	"This method is called for the blocks of text between tags.
	It preserves whitespace, but has all of the enclosed entities expanded"

	^self subclassResponsibility
]
