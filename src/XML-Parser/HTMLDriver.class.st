Class {
	#name : #HTMLDriver,
	#superclass : #SAXDriver,
	#category : #'XML-Parser-HTML'
}

{ #category : #'handling tokens' }
HTMLDriver >> handleEndDocument [
	self elementNester openElements
		reverseDo: [:each | self handleEndTag: each].

	super handleEndDocument.
]

{ #category : #'handling tokens' }
HTMLDriver >> handleEndTag: anElementName [
	(self elementNester hasOpenElement: anElementName)
		ifFalse: [^ self].

	(self elementNester elementsToEndBeforeEnding: anElementName)
		do: [:each | super handleEndTag: each].

	super handleEndTag: anElementName
]

{ #category : #parsing }
HTMLDriver >> handleParseError: anError [
]

{ #category : #'handling tokens' }
HTMLDriver >> handleStartTag: anElementName attributes: anAttributeDictionary namespaces: aNamespaceDictionary [
	self elementNester hasOpenSelfClosingTag
		ifTrue: [self handleEndTag: self elementNester currentElement].

	(self elementNester elementsToEndBeforeStarting: anElementName)
		do: [:each | self handleEndTag: each].

	super handleStartTag: anElementName attributes: anAttributeDictionary namespaces: aNamespaceDictionary
]

{ #category : #'handling tokens' }
HTMLDriver >> handleXMLVersion: aVersion encoding: anEncoding standalone: aYesOrNo [
	super handleXMLVersion: '1.0' encoding: anEncoding standalone: 'no'
]

{ #category : #private }
HTMLDriver >> tokenizerClass [
	^ HTMLTokenizer
]
