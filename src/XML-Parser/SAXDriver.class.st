"
SAXDriver together with SAXHandler provides a SAX-like API for XML parsing. A SAXDriver processes XML tokens and signals SAX events to a SAXHandler. To use it, create a subclass of SAXHandler and override messages to handle SAX events of interest. See ""instance creation"" on the class-side of SAXHandler for ways to instantiate such a parser.
"
Class {
	#name : #SAXDriver,
	#superclass : #XMLTokenizer,
	#instVars : [
		'saxHandler',
		'nestedScopes',
		'useNamespaces',
		'validateAttributes',
		'languageEnvironment'
	],
	#category : #'XML-Parser-Parser'
}

{ #category : #content }
SAXDriver >> activeSaxHandler [
	saxHandler eod
		ifTrue: [self errorExpected: 'No more data expected.'].
	^ saxHandler.
]

{ #category : #accessing }
SAXDriver >> currentScope [
	^ self usesNamespaces
		ifTrue: [self nestedScopes currentScope]
		ifFalse: [XMLNamespaceScope isValidating: false]
]

{ #category : #namespaces }
SAXDriver >> declareNamespaces: namespaces [
	namespaces keysAndValuesDo: [:ns :uri |
		self nestedScopes declareNamespace: ns uri: uri.
		self activeSaxHandler startPrefixMapping: ns uri: uri].
]

{ #category : #errors }
SAXDriver >> errorBadPrefix: aPrefix inEndTag: anElementName [
	self parseError:
		('End tag ', anElementName,
		' refers to unmapped prefix ', aPrefix asString)
]

{ #category : #errors }
SAXDriver >> errorBadPrefix: aPrefix inStartTag: anElementName [
	self parseError:
		('Start tag ', anElementName,
		' refers to unmapped prefix ', aPrefix asString)
]

{ #category : #'handling tokens' }
SAXDriver >> handleCData: aString [
	self activeSaxHandler
		startCData;
		characters: aString;
		endCData
]

{ #category : #'handling tokens' }
SAXDriver >> handleComment: aString [
	self activeSaxHandler 
		comment: aString
]

{ #category : #'handling tokens' }
SAXDriver >> handleEndDocument [
	self saxHandler endDocument
]

{ #category : #'handling tokens' }
SAXDriver >> handleEndTag: elementName [
	| prefix localName namespaceURI |

	elementName splitQualifiedNameInto: [:prefixPart :localPart |
		prefix := prefixPart.
		localName := localPart].
	self usesNamespaces
		ifTrue: [
			namespaceURI := self nestedScopes resolvePrefix: prefix.
			self validateEndTag: localName prefix: prefix]
		ifFalse: [namespaceURI := nil].

	self activeSaxHandler 
		endElement: localName
		qualifiedName: elementName
		prefix: prefix
		uri: namespaceURI.

	self usesNamespaces
		ifTrue: [
			self undeclareNamespaces: self currentScope prefixMappings.
			self nestedScopes leaveScope.].
]

{ #category : #'handling tokens' }
SAXDriver >> handlePCData: aString [
	self languageEnvironment
		ifNotNil: [aString applyLanguageInfomation: self languageEnvironment].
	self activeSaxHandler 
		characters: aString
]

{ #category : #'handling tokens' }
SAXDriver >> handlePI: piTarget data: piData [
	self activeSaxHandler 
		processingInstruction: piTarget data: piData
]

{ #category : #'handling tokens' }
SAXDriver >> handleStartDocument [
	self saxHandler startDocument
]

{ #category : #'handling tokens' }
SAXDriver >> handleStartTag: elementName attributes: attributes namespaces: namespaces [
	| localName prefix namespaceURI |

	(attributes includesKey: 'xml:lang')
		ifTrue: [self languageEnvironment: (attributes at: 'xml:lang')].

	elementName splitQualifiedNameInto: [:ns :ln |
		prefix := ns.
		localName := ln].
	self usesNamespaces
		ifTrue: [
			self nestedScopes enterScope.
			self declareNamespaces: namespaces.
			namespaceURI := self nestedScopes resolvePrefix: prefix.

			self validateStartTag: localName prefix: prefix attributes: attributes]
		ifFalse: [namespaceURI := nil].

	self activeSaxHandler 
		startElement: localName
		qualifiedName: elementName
		prefix: prefix
		uri: namespaceURI
		attributes: attributes
]

{ #category : #'handling tokens' }
SAXDriver >> handleWhitespace: aString [
	self activeSaxHandler 
		ignorableWhitespace: aString
]

{ #category : #'handling tokens' }
SAXDriver >> handleXMLDecl: attributes [
	self activeSaxHandler 
		documentAttributes: attributes
]

{ #category : #initialization }
SAXDriver >> initialize [
	super initialize.
	useNamespaces := false.
	validateAttributes := false
]

{ #category : #accessing }
SAXDriver >> languageEnvironment [
	^ languageEnvironment
]

{ #category : #accessing }
SAXDriver >> languageEnvironment: anIsoString [
	languageEnvironment := LanguageEnvironment localeID: (LocaleID isoString: anIsoString)
]

{ #category : #namespaces }
SAXDriver >> nestedScopes [
	^ nestedScopes ifNil: [nestedScopes := XMLNestedNamespaceScopes new]
]

{ #category : #accessing }
SAXDriver >> saxHandler [
	^saxHandler
]

{ #category : #accessing }
SAXDriver >> saxHandler: aHandler [
	saxHandler := aHandler
]

{ #category : #namespaces }
SAXDriver >> undeclareNamespaces: aDictionary [
	aDictionary keysAndValuesDo: [:prefix :uri |
		self activeSaxHandler startPrefixMapping: prefix uri: uri].
]

{ #category : #accessing }
SAXDriver >> useNamespaces: aBoolean [
	useNamespaces := aBoolean.
	self nestedScopes isValidating: aBoolean.
]

{ #category : #testing }
SAXDriver >> usesNamespaces [
	^ useNamespaces
]

{ #category : #namespaces }
SAXDriver >> validateEndTag: localName prefix: prefix [
	(prefix isNil or: [self nestedScopes isMappedPrefix: prefix])
		ifFalse: [self errorBadPrefix: prefix inEndTag: localName].
]

{ #category : #namespaces }
SAXDriver >> validateStartTag: aLocalName prefix: aPrefix attributes: attributeList [
	(aPrefix isNil or: [self nestedScopes isMappedPrefix: aPrefix])
		ifFalse: [self errorBadPrefix: aPrefix inStartTag: aLocalName].

	self validatesAttributes
		ifTrue: [self nestedScopes validateAttributes: attributeList].
]

{ #category : #testing }
SAXDriver >> validatesAttributes [
	^validateAttributes
]
