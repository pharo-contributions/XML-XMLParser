"
This is a generic parser. 
There is two ways to parse XML files, either using SAX, or using DOM. Both ways are supported in the XML-Parser package. SAX is event-based while DOM is tree-based. Ask google for more information
"
Class {
	#name : #XMLParser,
	#superclass : #XMLTokenizer,
	#category : #'XML-Parser'
}

{ #category : #callbacks }
XMLParser >> attribute: aSymbol value: aString [
	"This method is called for each attribute/value pair in a start tag"

	^self subclassResponsibility
]

{ #category : #callbacks }
XMLParser >> beginStartTag: aSymbol asPI: aBoolean [
	"This method is called for at the beginning of a start tag.
	The asPI parameter defines whether or not the tag is a 'processing
	instruction' rather than a 'normal' tag."

	^self subclassResponsibility
]

{ #category : #callbacks }
XMLParser >> endStartTag: aSymbol [
	"This method is called at the end of the start tag after all of the
	attributes have been processed"

	^self subclassResponsibility
]

{ #category : #callbacks }
XMLParser >> endTag: aSymbol [
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
