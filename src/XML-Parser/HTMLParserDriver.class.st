"
This is the driver for the HTMLHandler. It uses the HTMLElementNester to build a DOM tree from possibly bad markup.

"
Class {
	#name : #HTMLParserDriver,
	#superclass : #SAXDriver,
	#category : #'XML-Parser-HTML'
}

{ #category : #private }
HTMLParserDriver >> elementNesterClass [
	^ HTMLElementNester
]

{ #category : #'element nesting' }
HTMLParserDriver >> endNestingOfElement: anElementName [
	((self elementNester isVoidElement: anElementName)
		or: [(self elementNester hasOpenElement: anElementName) not])
		ifTrue: [^ self].

	self preEndElements:
		(self elementNester elementsToEndBeforeEnding: anElementName).

	super endNestingOfElement: anElementName.
]

{ #category : #'handling tokens' }
HTMLParserDriver >> handleEndDocument [
	self elementNester openElements
		reverseDo: [:each | self handleEndTag: each].

	super handleEndDocument.
]

{ #category : #'handling tokens' }
HTMLParserDriver >> handleNonHTMLSection: aString [
	self saxHandler characters: aString
]

{ #category : #'handling tokens' }
HTMLParserDriver >> handlePCData: aString [
	self
		preEndElements: self elementNester elementsToEndBeforePCData;
		preStartElements: self elementNester elementsToStartBeforePCData.

	super handlePCData: aString.
]

{ #category : #'handling tokens' }
HTMLParserDriver >> handleParseError: anError [
]

{ #category : #'handling tokens' }
HTMLParserDriver >> handleStartTag: anElementName attributes: anAttributeDictionary namespaces: aNamespaceDictionary [
	super
		handleStartTag: anElementName
		attributes: anAttributeDictionary
		namespaces: aNamespaceDictionary.

	(self elementNester isVoidElement: anElementName)
		ifTrue: [self preEndElements: (Array with: anElementName)].
]

{ #category : #'handling tokens' }
HTMLParserDriver >> handleXMLVersion: aVersion encoding: anEncoding standalone: aYesOrNo [
	super
		handleXMLVersion: (aVersion ifEmpty: '1.0')
		encoding: (anEncoding ifEmpty: 'UTF-8')
		standalone: 'no'
]

{ #category : #testing }
HTMLParserDriver >> isValidating [
	^ false
]

{ #category : #'element nesting' }
HTMLParserDriver >> preEndElements: anElementCollection [
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
HTMLParserDriver >> preStartElements: anElementCollection [
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
HTMLParserDriver >> resolvesExternalEntities [
	^ false
]

{ #category : #'element nesting' }
HTMLParserDriver >> startNestingOfElement: anElementName [
	(self elementNester isOpenUniqueElement: anElementName)
		ifTrue: [^ self].

	self preEndElements:
		(self elementNester elementsToEndBeforeStarting: anElementName).
	self preStartElements:
		(self elementNester elementsToStartBeforeStarting: anElementName).

	super startNestingOfElement: anElementName.
]

{ #category : #private }
HTMLParserDriver >> tokenizerClass [
	^ HTMLParserTokenizer
]

{ #category : #testing }
HTMLParserDriver >> usesNamespaces [
	^ false
]
