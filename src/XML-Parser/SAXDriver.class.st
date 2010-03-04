"
SAXDriver together with SAXHandler provides a SAX-like API for XML parsing. A SAXDriver processes XML tokens and signals SAX events to a SAXHandler. To use it, create a subclass of SAXHandler and override messages to handle SAX events of interest. See ""instance creation"" on the class-side of SAXHandler for ways to instantiate such a parser.
"
Class {
	#name : #SAXDriver,
	#superclass : #XMLTokenizer,
	#instVars : [
		'saxHandler',
		'scoping',
		'useNamespaces',
		'validateAttributes',
		'languageEnvironment'
	],
	#category : #'XML-Parser-Parser'
}

{ #category : #errors }
SAXDriver >> errorBadNamespace: aNamespace inEndTag: anElementName [
	self parseError:
		('End tag ', anElementName,
		' refers to undefined namespace ', aNamespace asString)
]

{ #category : #errors }
SAXDriver >> errorBadNamespace: aNamespace inStartTag: anElementName [
	self parseError:
		('Start tag ', anElementName,
		' refers to undefined namespace ', aNamespace asString)
]

{ #category : #'handling tokens' }
SAXDriver >> handleCData: aString [
	self saxHandler
		checkEOD;
		startCData;
		characters: aString;
		endCData
]

{ #category : #'handling tokens' }
SAXDriver >> handleComment: aString [
	self saxHandler
		checkEOD; 
		comment: aString
]

{ #category : #'handling tokens' }
SAXDriver >> handleEndDocument [
	self saxHandler endDocument
]

{ #category : #'handling tokens' }
SAXDriver >> handleEndTag: elementName [
	| namespace localName namespaceURI |

	self usesNamespaces
		ifTrue: [
			elementName splitQualifiedNameInto: [:ns :ln |
				namespace := ns.
				localName := ln].

			(namespace isNil or: [self scoping isBoundNamespace: namespace])
				ifFalse: [self errorBadNamespace: namespace inEndTag: elementName].

			"call the handler"
			self saxHandler
				checkEOD; 
				endElement: localName
				namespace: namespace
				qualifiedName: elementName
				scope: self scoping currentScope.
			self scoping leaveScope]
		ifFalse: [
			"call the handler"
			self saxHandler
				checkEOD; 
				endElement: elementName namespace: nil namespaceURI: nil qualifiedName: elementName]
]

{ #category : #'handling tokens' }
SAXDriver >> handlePCData: aString [
	self languageEnvironment
		ifNotNil: [aString applyLanguageInfomation: self languageEnvironment].
	self saxHandler
		checkEOD; 
		characters: aString
]

{ #category : #'handling tokens' }
SAXDriver >> handlePI: piTarget data: piData [
	self saxHandler
		checkEOD; 
		processingInstruction: piTarget data: piData
]

{ #category : #'handling tokens' }
SAXDriver >> handleStartDocument [
	self saxHandler startDocument
]

{ #category : #'handling tokens' }
SAXDriver >> handleStartTag: elementName attributes: attributeList namespaces: namespaces [
	| localName namespace namespaceURI |

	(attributeList includesKey: 'xml:lang')
		ifTrue: [self languageEnvironment: (attributeList at: 'xml:lang')].
	self usesNamespaces
		ifTrue: [
			self scoping enterScope.
				"declare any namespaces"	
				namespaces keysAndValuesDo: [:ns :uri |
					self scoping declareNamespace: ns uri: uri].

			elementName splitQualifiedNameInto: [:ns :ln |
				namespace := ns.
				localName := ln].

			"ensure our namespace is defined"
			(namespace isNil or: [self scoping isBoundNamespace: namespace])
				ifFalse: [self errorBadNamespace: namespace inStartTag: elementName].
			self validatesAttributes
				ifTrue: [self scoping validateAttributes: attributeList].

			"call the handler"
			self saxHandler
				checkEOD; 
				startElement: localName
				namespace: namespace
				attributeList: attributeList
				scope: self scoping currentScope]
		ifFalse: [
			"call the handler"
			self saxHandler
				checkEOD; 
				startElement: elementName
				namespace: nil
				namespaceURI: nil
				attributeList: attributeList]
]

{ #category : #'handling tokens' }
SAXDriver >> handleWhitespace: aString [
	self saxHandler
		checkEOD; 
		ignorableWhitespace: aString
]

{ #category : #'handling tokens' }
SAXDriver >> handleXMLDecl: attributes [
	self saxHandler
		checkEOD; 
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
	^languageEnvironment
]

{ #category : #accessing }
SAXDriver >> languageEnvironment: anIsoString [
	languageEnvironment := LanguageEnvironment localeID: (LocaleID isoString: anIsoString)
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
SAXDriver >> scoping [
	^ scoping ifNil: [scoping := XMLNamespaceScopeStack new]
]

{ #category : #namespaces }
SAXDriver >> splitName: aName into: twoArgsBlock [
	"Split the name into namespace and local name (the block arguments).
	Handle both qualified and unqualified names using the default name space"

	| i ns ln |
	i := aName lastIndexOf: $:.
	i = 0
		ifTrue: [
			ns := nil.
			ln := aName]
		ifFalse: [
			ns := aName copyFrom: 1 to: (i - 1).
			ln := aName copyFrom: i+1 to: aName size].
	twoArgsBlock value: ns value: ln
]

{ #category : #accessing }
SAXDriver >> useNamespaces: aBoolean [
	useNamespaces := aBoolean
]

{ #category : #testing }
SAXDriver >> usesNamespaces [
	^useNamespaces
]

{ #category : #testing }
SAXDriver >> validatesAttributes [
	^validateAttributes
]
