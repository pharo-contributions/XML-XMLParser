"
This is a base class for drivers. Drivers are sent messages by a tokenize that prompt it to handle XML tokens.
"
Class {
	#name : #XMLDriver,
	#superclass : #Object,
	#category : #'XML-Parser'
}

{ #category : #'handling tokens' }
XMLDriver >> handleCData: aString [
]

{ #category : #'handling tokens' }
XMLDriver >> handleComment: aString [
]

{ #category : #'handling tokens' }
XMLDriver >> handleEndDocument [
]

{ #category : #'handling tokens' }
XMLDriver >> handleEndTag: anElementName [
]

{ #category : #'handling tokens' }
XMLDriver >> handlePCData: aString [
]

{ #category : #'handling tokens' }
XMLDriver >> handlePI: piTarget data: piData [
]

{ #category : #'handling tokens' }
XMLDriver >> handleStartDocument [
]

{ #category : #'handling tokens' }
XMLDriver >> handleStartTag: anElementName attributes: anAttributeDictionary namespaces: aNamespaceDictionary [
]

{ #category : #'handling tokens' }
XMLDriver >> handleWhitespace: aString [
]

{ #category : #'handling tokens' }
XMLDriver >> handleXMLVersion: aVersion encoding: anEncoding standalone: aYesOrNo [
]

{ #category : #testing }
XMLDriver >> isValidating [
	self subclassResponsibility
]

{ #category : #private }
XMLDriver >> tokenizerClass [
	^ XMLTokenizer
]

{ #category : #initialization }
XMLDriver >> tokenizerOn: aStringOrStream [
	^ self tokenizerClass driver: self on: aStringOrStream
]

{ #category : #testing }
XMLDriver >> usesNamespaces [
	self subclassResponsibility
]
