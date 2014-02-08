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

	self elementNester
		elementsToEndBeforeEnding: anElementName
		do: [:each | self endElement: each].
	self endElement: anElementName.
]

{ #category : #'handling tokens' }
HTMLParserDriver >> handleNonHTMLSection: aString [
	self saxHandler characters: aString
]

{ #category : #'handling tokens' }
HTMLParserDriver >> handlePCData: aString [
	self elementNester
		elementsToEndBeforePCDataDo: [:each | self endElement: each ];
		elementsToStartBeforePCDataDo: [:each | self startElement: each].

	self saxHandler characters: aString.
]

{ #category : #'handling tokens' }
HTMLParserDriver >> handleParseError: anError [
]

{ #category : #'handling tokens' }
HTMLParserDriver >> handleStartTag: anElementName attributes: anAttributeDictionary namespaces: aNamespaceDictionary [
	(self elementNester isOpenUniqueElement: anElementName)
		ifTrue: [^ self].

	self elementNester
		elementsToEndBeforeStarting: anElementName
		do: [:each | self endElement: each];
		elementsToStartBeforeStarting: anElementName
		do: [:each | self startElement: each].
	self startElement: anElementName attributes: anAttributeDictionary.

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

{ #category : #private }
HTMLParserDriver >> startElement: anElementName [
	self
		startElement: anElementName
		attributes: (OrderPreservingDictionary new: 5 withDefaultValue: '')
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
HTMLParserDriver >> tokenizerClass [
	^ HTMLParserTokenizer
]

{ #category : #testing }
HTMLParserDriver >> usesNamespaces [
	^ false
]
