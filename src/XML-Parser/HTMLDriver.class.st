Class {
	#name : #HTMLDriver,
	#superclass : #SAXDriver,
	#category : #'XML-Parser-HTML'
}

{ #category : #'element nesting' }
HTMLDriver >> endNestingElement: anElementName [
	((self elementNester isVoidElement: anElementName)
		or: [(self elementNester hasOpenElement: anElementName) not])
		ifTrue: [^ self].

	self preEndElements:
		(self elementNester elementsToEndBeforeEnding: anElementName).

	super endNestingElement: anElementName.
]

{ #category : #'handling tokens' }
HTMLDriver >> handleEndDocument [
	self elementNester openElements
		reverseDo: [:each | self handleEndTag: each].

	super handleEndDocument.
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
		handleXMLVersion: (aVersion ifEmpty: '1.0')
		encoding: (anEncoding ifEmpty: 'UTF-8')
		standalone: 'no'
]

{ #category : #testing }
HTMLDriver >> isValidating [
	^ false
]

{ #category : #'element nesting' }
HTMLDriver >> preEndElements: anElementCollection [
	anElementCollection do: [:each |
		(self elementNester hasOpenElements)
			ifFalse: [^ self].

		self elementNester endElement: each.
	
		each splitQualifiedNameInto: [:prefixPart :localPart |
			self saxHandler 
				endElement: each
				prefix: prefixPart
				uri: ''
				localName: localPart]].
]

{ #category : #'element nesting' }
HTMLDriver >> preStartElements: anElementCollection [
	anElementCollection do: [:each |
		self elementNester startElement: each.

		each splitQualifiedNameInto: [:prefixPart :localPart |
			self saxHandler 
				startElement: each
				prefix: prefixPart
				uri: ''
				localName: localPart
				attributes: Dictionary new]].
]

{ #category : #testing }
HTMLDriver >> resolvesExternalEntities [
	^ false
]

{ #category : #'element nesting' }
HTMLDriver >> startNestingElement: anElementName [
	(self elementNester isOpenUniqueElement: anElementName)
		ifTrue: [^ self].

	self preEndElements:
		(self elementNester elementsToEndBeforeStarting: anElementName).
	self preStartElements:
		(self elementNester elementsToStartBeforeStarting: anElementName).

	super startNestingElement: anElementName.
]

{ #category : #private }
HTMLDriver >> tokenizerClass [
	^ HTMLTokenizer
]

{ #category : #testing }
HTMLDriver >> usesNamespaces [
	^ false
]
