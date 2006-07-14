Class {
	#name : #SAXDriver,
	#superclass : #XMLTokenizer,
	#instVars : [
		'saxHandler',
		'scope',
		'useNamespaces',
		'validateAttributes',
		'languageEnvironment'
	],
	#category : #'XML-Parser'
}

{ #category : #'handling tokens' }
SAXDriver >> handleCData: aString [
	self saxHandler
		checkEOD; 
		characters: aString
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
	| namespace localName namespaceURI qualifiedName |

	self usesNamespaces
		ifTrue: [
			self splitName: elementName into: [:ns :ln |
				namespace _ ns.
				localName _ ln].

			"ensure our namespace is defined"
			namespace
				ifNil: [
					namespace := self scope defaultNamespace.
					qualifiedName := namespace , ':' , elementName]
				ifNotNil: [
					namespaceURI := self scope namespaceURIOf: namespace.
					namespaceURI
						ifNil: [self parseError: 'Start tag ' , elementName , ' refers to undefined namespace ' , namespace asString].
					qualifiedName := elementName].

			"call the handler"
			self saxHandler
				checkEOD; 
				endElement: localName namespace: namespace namespaceURI: namespaceURI qualifiedName: qualifiedName.
			self scope leaveScope]
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
		ifTrue: [languageEnvironment := LanguageEnvironment localeID: (LocaleID isoString: (attributeList at: 'xml:lang'))].
	self usesNamespaces
		ifTrue: [
			self scope enterScope.
				"declare any namespaces"	
				namespaces keysAndValuesDo: [:ns :uri |
					self scope declareNamespace: ns uri: uri].

			self splitName: elementName into: [:ns :ln |
				namespace _ ns.
				localName _ ln].

			"ensure our namespace is defined"
			namespace
				ifNil: [namespace := self scope defaultNamespace]
				ifNotNil: [
					namespaceURI := self scope namespaceURIOf: namespace.
					namespaceURI
						ifNil: [self parseError: 'Start tag ' , elementName , ' refers to undefined namespace ' , namespace asString]].

			self validatesAttributes
				ifTrue: [self scope validateAttributes: attributeList].
			"call the handler"
			self saxHandler
				checkEOD; 
				startElement: localName namespaceURI: namespaceURI namespace: namespace attributeList: attributeList]
		ifFalse: [
			"call the handler"
			self saxHandler
				checkEOD; 
				startElement: elementName namespaceURI: nil namespace: nil attributeList: attributeList]
]

{ #category : #'handling tokens' }
SAXDriver >> handleWhitespace: aString [
	self saxHandler
		checkEOD; 
		ignorableWhitespace: aString
]

{ #category : #'handling tokens' }
SAXDriver >> handleXMLDecl: attributes namespaces: namespaces [
	self saxHandler
		checkEOD; 
		documentAttributes: attributes.
	self usesNamespaces
		ifTrue: [
			namespaces keysAndValuesDo: [:ns :uri |
				self scope declareNamespace: ns uri: uri]]
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
SAXDriver >> saxHandler [
	^saxHandler
]

{ #category : #accessing }
SAXDriver >> saxHandler: aHandler [
	saxHandler _ aHandler
]

{ #category : #namespaces }
SAXDriver >> scope [
	scope ifNil: [scope := XMLNamespaceScope new].
	^scope
]

{ #category : #namespaces }
SAXDriver >> splitName: aName into: twoArgsBlock [
	"Split the name into namespace and local name (the block arguments).
	Handle both qualified and unqualified names using the default name space"

	| i ns ln |
	i _ aName lastIndexOf: $:.
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
