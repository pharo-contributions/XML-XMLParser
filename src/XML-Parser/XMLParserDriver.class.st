"
This is a base class for parser drivers. Drivers are sent messages by a tokenizer to handle various XML tokens as they are read. To create a driver, subclass this class and override the handler messages and testing messages that control tokenization.
"
Class {
	#name : #XMLParserDriver,
	#superclass : #Object,
	#category : #'XML-Parser'
}

{ #category : #'handling tokens' }
XMLParserDriver >> handleCData: aString [
]

{ #category : #'handling tokens' }
XMLParserDriver >> handleComment: aString [
]

{ #category : #'handling tokens' }
XMLParserDriver >> handleEndDocument [
]

{ #category : #'handling tokens' }
XMLParserDriver >> handleEndTag: anElementName [
]

{ #category : #'handling tokens' }
XMLParserDriver >> handlePCData: aString [
]

{ #category : #'handling tokens' }
XMLParserDriver >> handlePI: piTarget data: piData [
]

{ #category : #'handling tokens' }
XMLParserDriver >> handleStartDocument [
]

{ #category : #'handling tokens' }
XMLParserDriver >> handleStartTag: anElementName attributes: anAttributeDictionary namespaces: aNamespaceDictionary [
]

{ #category : #'handling tokens' }
XMLParserDriver >> handleWhitespace: aString [
]

{ #category : #'handling tokens' }
XMLParserDriver >> handleXMLVersion: aVersion encoding: anEncoding standalone: aYesOrNo [
]

{ #category : #testing }
XMLParserDriver >> isValidating [
	self subclassResponsibility
]

{ #category : #private }
XMLParserDriver >> tokenizerClass [
	^ XMLTokenizer
]

{ #category : #initialization }
XMLParserDriver >> tokenizerOn: aStringOrStream [
	^ self tokenizerClass driver: self on: aStringOrStream
]

{ #category : #testing }
XMLParserDriver >> usesNamespaces [
	self subclassResponsibility
]
