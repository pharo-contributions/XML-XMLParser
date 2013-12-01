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
	((self elementNester isVoidElement: anElementName)
		or: [(self elementNester hasOpenElement: anElementName) not])
		ifTrue: [^ self].

	self preEndElements:
		(self elementNester elementsToEndBeforeEnding: anElementName).

	super handleEndTag: anElementName
]

{ #category : #'handling tokens' }
HTMLDriver >> handleNonHTMLSection: aString [
	self saxHandler characters: aString
]

{ #category : #'handling tokens' }
HTMLDriver >> handlePCData: aString [
	self
		preEndElements: self elementNester elementsToEndBeforePCData;
		preStartElements: self elementNester elementsToStartBeforePCData.

	super handlePCData: aString.
]

{ #category : #'handling tokens' }
HTMLDriver >> handleParseError: anError [
]

{ #category : #'handling tokens' }
HTMLDriver >> handleStartTag: anElementName attributes: anAttributeDictionary namespaces: aNamespaceDictionary [
	(self elementNester isOpenUniqueElement: anElementName)
		ifTrue: [^ self].

	self preEndElements:
		(self elementNester elementsToEndBeforeStarting: anElementName).
	self preStartElements:
		(self elementNester elementsToStartBeforeStarting: anElementName).

	super
		handleStartTag: anElementName
		attributes: anAttributeDictionary
		namespaces: aNamespaceDictionary.

	(self elementNester isVoidElement: anElementName)
		ifTrue: [self preEndElements: (Array with: anElementName)].

]

{ #category : #'handling tokens' }
HTMLDriver >> handleXMLVersion: aVersion encoding: anEncoding standalone: aYesOrNo [
	super
		handleXMLVersion: '1.0'
		encoding: anEncoding
		standalone: ''
]

{ #category : #testing }
HTMLDriver >> isValidating [
	^ false
]

{ #category : #private }
HTMLDriver >> preEndElements: anElementCollection [
	anElementCollection do: [:each |
		(self elementNester hasOpenElements)
			ifFalse: [^ self].

		super handleEndTag: each].
]

{ #category : #private }
HTMLDriver >> preStartElements: anElementCollection [
	anElementCollection do: [:each |
		super
			handleStartTag: each
			attributes: Dictionary new
			namespaces: nil].
]

{ #category : #testing }
HTMLDriver >> resolvesExternalEntities [
	^ false
]

{ #category : #private }
HTMLDriver >> tokenizerClass [
	^ HTMLTokenizer
]

{ #category : #testing }
HTMLDriver >> usesNamespaces [
	^ false
]
