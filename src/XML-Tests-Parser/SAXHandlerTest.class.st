Class {
	#name : #SAXHandlerTest,
	#superclass : #XMLParserTest,
	#category : #'XML-Tests-Parser'
}

{ #category : #source }
SAXHandlerTest >> prefixedXMLSource [
	^ '<prefix:test xmlns:prefix="prefixNS" xmlns="defaultNS" name="value">test</prefix:test>'
]

{ #category : #tests }
SAXHandlerTest >> prefixedXMLSourceSelectors [
	^ #(startDocument
		startPrefixMapping:uri: startPrefixMapping:uri:
		startElement:prefix:uri:localName:attributes:
		characters:
		endElement:prefix:uri:localName:
		endPrefixMapping: endPrefixMapping:
		endDocument)
]

{ #category : #tests }
SAXHandlerTest >> prefixedXMLSourceSelectorsNamespacesDisabled [
	^ self prefixedXMLSourceSelectors reject: [:each |
		#(startPrefixMapping:uri: endPrefixMapping:) includes: each].

]

{ #category : #tests }
SAXHandlerTest >> testSAXEndElemenNamespacesDisabled [
	| parser arguments |

	(parser := SAXHandlerProxy on: self prefixedXMLSource)
		usesNamespaces: false;
		parseDocument.
	self assert: (parser wasSentSelectors: self prefixedXMLSourceSelectorsNamespacesDisabled).

	arguments := parser argumentsSentWith: #endElement:prefix:uri:localName:.
	self
		assert: arguments first = 'prefix:test';
		assert: arguments second = 'prefix';
		assert: arguments third isEmpty;
		assert: arguments fourth = 'test'.
]

{ #category : #tests }
SAXHandlerTest >> testSAXEndElement [
	| parser arguments |

	(parser := SAXHandlerProxy on: self prefixedXMLSource)
		parseDocument.
	self assert: (parser wasSentSelectors: self prefixedXMLSourceSelectors).

	arguments := parser argumentsSentWith: #endElement:prefix:uri:localName:.
	self
		assert: arguments first = 'prefix:test';
		assert: arguments second = 'prefix';
		assert: arguments third =  'prefixNS';
		assert: arguments fourth = 'test'.
]

{ #category : #tests }
SAXHandlerTest >> testSAXEntityHandlers [
	| xml parser messages |

	xml := '<!DOCTYPE root [
		<!ENTITY % firstDeclaration "<!ENTITY first &#39; &second; &#39;>">
		%firstDeclaration;
		<!ENTITY second " replacement ">]>
	<root name="&second;">&first;</root>'.
	(parser :=SAXHandlerProxy on: xml) parseDocument.
	self assert:
		(parser wasSentSelectors: 
			#(startDocument
				startDTD:publicID:systemID:
				parameterEntityDeclaration:replacement:
				generalEntityDeclaration:replacement: generalEntityDeclaration:replacement:
				endDTD
				startElement:prefix:uri:localName:attributes:
				startEntity: startEntity: endEntity: endEntity: characters:
				endElement:prefix:uri:localName:
				endDocument)).
	messages := parser allSentMessagesNamed: #startEntity:.
	self
		assert: messages first arguments = #('first');
		assert: messages second arguments = #('second').
	messages := parser allSentMessagesNamed: #endEntity:.
	self
		assert: messages first arguments = #('second');
		assert: messages second arguments = #('first').
]

{ #category : #tests }
SAXHandlerTest >> testSAXIgnorableWhitespace [
	| xml parser |

	xml := '
	<one>
		<two>
			test
		</two>
	</one>
	'.
	(parser := SAXHandlerProxy on: xml) parseDocument.
	self assert:
		(parser wasSentSelectors: 
			#(startDocument
				startElement:prefix:uri:localName:attributes:
				ignorableWhitespace:
				startElement:prefix:uri:localName:attributes: characters: endElement:prefix:uri:localName:
				ignorableWhitespace:
				endElement:prefix:uri:localName:
				ignorableWhitespace:
				endDocument)).
	(parser allSentMessagesNamed: #ignorableWhitespace:) do: [:each |
		self assert:
			((each arguments first) notEmpty
				and: [each arguments first allSatisfy: [:char | char isSeparator]])].
]

{ #category : #tests }
SAXHandlerTest >> testSAXParsingInterrupt [
	| uniqueSelectors parser |

	uniqueSelectors := OrderedCollection new.
	self prefixedXMLSourceSelectors do: [:each |
		(uniqueSelectors includes: each)
			ifFalse: [uniqueSelectors addLast: each]].
	uniqueSelectors do: [:each |
		(parser := SAXHandlerPluggableProxy on: self prefixedXMLSource)
			handle: each with: [:message | parser interruptParsing];
			parseDocument.
		self assert:
			(parser wasSentSelectors:
				((self prefixedXMLSourceSelectors copyUpTo: each) copyWith: each))].
		
	
]

{ #category : #tests }
SAXHandlerTest >> testSAXPrefixMappingHandlers [
	| parser messages |

	(parser := SAXHandlerProxy on: self prefixedXMLSource) parseDocument.
	self assert: (parser wasSentSelectors: self prefixedXMLSourceSelectors).

	messages := parser allSentMessagesNamed: #startPrefixMapping:uri:.
	self
		assert: messages first arguments = #('prefix' 'prefixNS');
		assert: messages second arguments = #('' 'defaultNS').

	messages := parser allSentMessagesNamed: #endPrefixMapping:.
	self
		assert: messages first arguments = #('prefix');
		assert: messages second arguments = #('').
]

{ #category : #tests }
SAXHandlerTest >> testSAXSkippedEntityHandler [
	| xml parser |

	xml := '<root>&undeclared;</root>'.
	(parser := SAXHandlerProxy on: xml)
		isValidating: false;
		parseDocument.
	self assert:
		(parser wasSentSelectors: 
			#(startDocument
				startElement:prefix:uri:localName:attributes:
				skippedEntity:
				endElement:prefix:uri:localName:
				endDocument)).
	self assert: (parser argumentsSentWith: #skippedEntity:) first =  'undeclared'.
]

{ #category : #tests }
SAXHandlerTest >> testSAXStartElemenNamespacesDisabled [
	| parser arguments |

	(parser := SAXHandlerProxy on: self prefixedXMLSource)
		usesNamespaces: false;
		parseDocument.
	self assert: (parser wasSentSelectors: self prefixedXMLSourceSelectorsNamespacesDisabled).

	arguments := parser argumentsSentWith: #startElement:prefix:uri:localName:attributes:.
	self
		assert: arguments first = 'prefix:test';
		assert: arguments second = 'prefix';
		assert: arguments third isEmpty;
		assert: arguments fourth = 'test'.
	self assert:
		arguments fifth =
			(OrderPreservingDictionary
				with: 'xmlns:prefix' -> 'prefixNS'
				with: 'xmlns' -> 'defaultNS'
				with: 'name' -> 'value').
]

{ #category : #tests }
SAXHandlerTest >> testSAXStartElement [
	| parser arguments |

	(parser := SAXHandlerProxy on: self prefixedXMLSource)
		parseDocument.
	self assert: (parser wasSentSelectors: self prefixedXMLSourceSelectors).

	arguments := parser argumentsSentWith: #startElement:prefix:uri:localName:attributes:.
	self
		assert: arguments first = 'prefix:test';
		assert: arguments second = 'prefix';
		assert: arguments third =  'prefixNS';
		assert: arguments fourth = 'test';
		assert: arguments fifth = (OrderPreservingStringDictionary with: 'name' -> 'value').
]

{ #category : #tests }
SAXHandlerTest >> testSAXXMLDeclaration [
	| parser selectors arguments |

	(parser := SAXHandlerProxy on: '<?xml version="1.0" encoding="UTF-8"?>')
		parseDocument.
	selectors := #(startDocument xmlVersion:encoding:standalone: endDocument).
	self assert: (parser wasSentSelectors: selectors).

	arguments := parser argumentsSentWith: #xmlVersion:encoding:standalone:.
	self
		assert: arguments first = 1.0;
		assert: arguments second = 'UTF-8';
		deny: arguments third.

	(parser :=
		SAXHandlerProxy on:
			'<?xml version="1.1" encoding="utf-8" standalone="yes"?>')
		parseDocument.
	self assert: (parser wasSentSelectors: selectors).

	arguments := (parser argumentsSentWith: #xmlVersion:encoding:standalone:).
	self
		assert: arguments first = 1.1;
		assert: arguments second = 'utf-8';
		assert: arguments third.
]
