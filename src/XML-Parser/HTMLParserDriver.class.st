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

{ #category : #private }
HTMLParserDriver >> endElement: anElementName [
	| prefix |

	self elementNester endElement: anElementName.

	prefix := anElementName qualifiedNamePrefix.	
	self saxHandler 
		endElement: anElementName
		prefix: prefix
		uri: ''
		localName: (anElementName qualifiedNameLocalPart: prefix)
]

{ #category : #private }
HTMLParserDriver >> endElements: anElementCollection [
	anElementCollection do: [:each |
		(self elementNester hasOpenElements)
			ifFalse: [^ self].

		self endElement: each].
]

{ #category : #'handling tokens' }
HTMLParserDriver >> handleEndDocument [
	self elementNester
		openElementsReverseDo: [:each | self endElement: each];
		endNesting.

	self saxHandler endDocument.
]

{ #category : #'handling tokens' }
HTMLParserDriver >> handleEndTag: anElementName [ 
	((self elementNester isVoidElement: anElementName)
		or: [(self elementNester hasOpenElement: anElementName) not])
		ifTrue: [^ self].

	self
		endElements: (self elementNester elementsToEndBeforeEnding: anElementName);
		endElement: anElementName.
]

{ #category : #'handling tokens' }
HTMLParserDriver >> handleNonHTMLSection: aString [
	self saxHandler characters: aString
]

{ #category : #'handling tokens' }
HTMLParserDriver >> handlePCData: aString [
	self
		endElements: self elementNester elementsToEndBeforePCData;
		startElements: self elementNester elementsToStartBeforePCData.

	self saxHandler characters: aString.
]

{ #category : #'handling tokens' }
HTMLParserDriver >> handleParseError: anError [
]

{ #category : #'handling tokens' }
HTMLParserDriver >> handleStartTag: anElementName attributes: anAttributeDictionary namespaces: aNamespaceDictionary [
	(self elementNester isOpenUniqueElement: anElementName)
		ifTrue: [^ self].

	self
		endElements: (self elementNester elementsToEndBeforeStarting: anElementName);
		startElements: (self elementNester elementsToStartBeforeStarting: anElementName);
		startElement: anElementName attributes: anAttributeDictionary.

	(self elementNester isVoidElement: anElementName)
		ifTrue: [self endElement: anElementName].
]

{ #category : #'handling tokens' }
HTMLParserDriver >> handleXMLVersion: aVersion encoding: anEncoding standalone: aYesOrNo [
	self saxHandler
		xmlVersion: (aVersion ifEmpty: '1.0')
		encoding: (anEncoding ifEmpty: 'UTF-8')
		standalone: false
]

{ #category : #testing }
HTMLParserDriver >> isValidating [
	^ false
]

{ #category : #testing }
HTMLParserDriver >> resolvesExternalEntities [
	^ false
]

{ #category : #private }
HTMLParserDriver >> startElement: anElementName attributes: anAttributeDictionary [
	| prefix |

	self elementNester startElement: anElementName.

	prefix := anElementName qualifiedNamePrefix.
	self saxHandler 
		startElement: anElementName
		prefix: prefix
		uri: ''
		localName: (anElementName qualifiedNameLocalPart: prefix)
		attributes: anAttributeDictionary
]

{ #category : #private }
HTMLParserDriver >> startElements: anElementCollection [
	anElementCollection do: [:each |
		self
			startElement: each
			attributes: (OrderPreservingDictionary new: 5 withDefaultValue: '')].
]

{ #category : #private }
HTMLParserDriver >> tokenizerClass [
	^ HTMLParserTokenizer
]

{ #category : #testing }
HTMLParserDriver >> usesNamespaces [
	^ false
]
