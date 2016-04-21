Class {
	#name : #SAXHandlerTest,
	#superclass : #XMLParserTest,
	#category : #'XML-Tests-Parser'
}

{ #category : #asserting }
SAXHandlerTest >> assertIgnorableWhitespace: aString [
	self assert: aString isXMLWhitespace
]

{ #category : #accessing }
SAXHandlerTest >> prefixedXMLAttributes [
	^ OrderPreservingDictionary with: 'name' -> 'value'
]

{ #category : #accessing }
SAXHandlerTest >> prefixedXMLAttributesNamespacesDisabled [
	^ OrderPreservingStringDictionary
		with: 'xmlns:prefix' -> 'prefixNS'
		with: 'xmlns' -> 'defaultNS'
		with: 'name' -> 'value'
]

{ #category : #source }
SAXHandlerTest >> prefixedXMLSource [
	^ '<prefix:test xmlns:prefix="prefixNS" xmlns="defaultNS" name="value">test</prefix:test>'
]

{ #category : #accessing }
SAXHandlerTest >> prefixedXMLSourceSelectors [
	^ #(startDocument
		startPrefixMapping:uri: startPrefixMapping:uri:
		startElement:prefix:uri:localName:attributes:
		characters:
		endElement:prefix:uri:localName:
		endPrefixMapping: endPrefixMapping:
		endDocument)
]

{ #category : #accessing }
SAXHandlerTest >> prefixedXMLSourceSelectorsNamespacesDisabled [
	^ self prefixedXMLSourceSelectors reject: [:each |
		#(startPrefixMapping:uri: endPrefixMapping:) includes: each].

]

{ #category : #tests }
SAXHandlerTest >> testSAXEndElementForwarding [
	| messageRecorder message |

	messageRecorder :=
		(SAXElementEventRecordingHandler on: self prefixedXMLSource)
			parseDocument;
			messageRecorder.

	message :=
		messageRecorder
			nextMessage;
			nextMessage.
	self
		assert: message selector == #endElement:;
		assert: message arguments = #('prefix:test').
]

{ #category : #tests }
SAXHandlerTest >> testSAXEndElementForwardingNamespacesDisabled [
	| messageRecorder message |

	messageRecorder :=
		(SAXElementEventRecordingHandler on: self prefixedXMLSource)
			usesNamespaces: false;
			parseDocument;
			messageRecorder.

	message :=
		messageRecorder
			nextMessage;
			nextMessage.
	self
		assert: message selector == #endElement:;
		assert: message arguments = #('prefix:test').
]

{ #category : #tests }
SAXHandlerTest >> testSAXEndElementPrefixURIForwarding [
	| messageRecorder message |

	messageRecorder :=
		(SAXElementPrefixURIEventRecordingHandler on: self prefixedXMLSource)
			parseDocument;
			messageRecorder.

	message :=
		messageRecorder
			nextMessage;
			nextMessage.
	self
		assert: message selector == #endElement:prefix:uri:;
		assert: message arguments = #('prefix:test' 'prefix' 'prefixNS').
]

{ #category : #tests }
SAXHandlerTest >> testSAXEndElementPrefixURIForwardingNamespacesDisabled [
	| messageRecorder message |

	messageRecorder :=
		(SAXElementPrefixURIEventRecordingHandler on: self prefixedXMLSource)
			usesNamespaces: false;
			parseDocument;
			messageRecorder.

	message :=
		messageRecorder
			nextMessage;
			nextMessage.
	self
		assert: message selector == #endElement:prefix:uri:;
		assert: message arguments = #('prefix:test' 'prefix' '').
]

{ #category : #tests }
SAXHandlerTest >> testSAXEndElementPrefixURILocalName [
	| messageRecorder message |

	messageRecorder :=
		(SAXElementPrefixURILocalNameEventRecordingHandler on: self prefixedXMLSource)
			parseDocument;
			messageRecorder.

	message :=
		messageRecorder
			nextMessage;
			nextMessage.
	self
		assert: message selector == #endElement:prefix:uri:localName:;
		assert: message arguments = #('prefix:test' 'prefix' 'prefixNS' 'test').
]

{ #category : #tests }
SAXHandlerTest >> testSAXEndElementPrefixURILocalNameNamespacesDisabled [
	| messageRecorder message |

	messageRecorder :=
		(SAXElementPrefixURILocalNameEventRecordingHandler on: self prefixedXMLSource)
			usesNamespaces: false;
			parseDocument;
			messageRecorder.

	message :=
		messageRecorder
			nextMessage;
			nextMessage.
	self
		assert: message selector == #endElement:prefix:uri:localName:;
		assert: message arguments = #('prefix:test' 'prefix' '' 'test').
]

{ #category : #tests }
SAXHandlerTest >> testSAXEndPrefixMapping [
	| parser messages |

	(parser := SAXHandlerProxy on: self prefixedXMLSource)
		parseDocument.
	self assert: (parser wasSentSelectors: self prefixedXMLSourceSelectors).
	messages := parser allSentMessagesNamed: #endPrefixMapping:.
	self
		assert: messages size = 2;
		assert: messages first arguments = #('prefix');
		assert: messages second arguments = #('').

	(parser :=
		SAXHandlerProxy on:
			'<one xmlns="defaultNS"><two xmlns="defaultNS"/></one>')
		parseDocument.
	messages := parser allSentMessagesNamed: #endPrefixMapping:.
	self
		assert: messages size = 1;
		assert: messages first arguments = #('').

	(parser :=
		SAXHandlerProxy on:
			'<one xmlns="defaultNS"><two xmlns="newDefaultNS"/></one>')
		parseDocument.
	messages := parser allSentMessagesNamed: #endPrefixMapping:.
	self
		assert: messages size = 2;
		assert: messages first arguments = #('');
		assert: messages second arguments = #('').

	(parser :=
		SAXHandlerProxy on:
			'<one xmlns:xml="', XMLNamespaceScope xmlNamespaceURI, '"/>')
		parseDocument.
	self assert:
		(parser allSentMessagesNamed: #endPrefixMapping:) isEmpty.
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
	| dtd xml parser |

	dtd := '
		<!DOCTYPE one [ 
			<!ELEMENT one (two)>
			<!ELEMENT two (#PCDATA|three)*>
			<!ELEMENT three ANY>
		]>'.
	xml := '
		<one>
			<two>
				test
				<three>
					test
				</three>
				test
			</two>
		</one>
	'.

	(parser := SAXHandlerProxy on: dtd, xml) parseDocument.
	self assert:
		(parser wasSentSelectors: 
			#(startDocument
				startDTD:publicID:systemID:
				elementDeclaration:contentModel:
				elementDeclaration:contentModel:
				elementDeclaration:contentModel:
				endDTD
				startElement:prefix:uri:localName:attributes:
				ignorableWhitespace:
				startElement:prefix:uri:localName:attributes:
				characters:
				startElement:prefix:uri:localName:attributes:
				characters:
				endElement:prefix:uri:localName:
				characters:
				endElement:prefix:uri:localName:
				ignorableWhitespace:
				endElement:prefix:uri:localName:
				endDocument)).
	(parser allSentMessagesNamed: #ignorableWhitespace:) do: [:each |
		self assertIgnorableWhitespace: each arguments first].

	(parser := SAXHandlerProxy on: xml) parseDocument.
	self assert:
		(parser wasSentSelectors: 
			#(startDocument
				startElement:prefix:uri:localName:attributes:
				characters:
				startElement:prefix:uri:localName:attributes:
				characters:
				startElement:prefix:uri:localName:attributes:
				characters:
				endElement:prefix:uri:localName:
				characters:
				endElement:prefix:uri:localName:
				characters:
				endElement:prefix:uri:localName:
				endDocument)).

	self assertIgnorableWhitespace:
		(parser allSentMessagesNamed: #characters:) first arguments first.
	self assertIgnorableWhitespace:
		(parser allSentMessagesNamed: #characters:) last arguments first.
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
SAXHandlerTest >> testSAXSkippedEntityUndeclared [
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
	self assert: (parser argumentsSentWith: #skippedEntity:) = #('undeclared').
]

{ #category : #tests }
SAXHandlerTest >> testSAXSkippedEntityUndeclaredPreserved [
	| xml parser |

	xml := '<root>&undeclared;</root>'.
	(parser := SAXHandlerProxy on: xml)
		isValidating: false;
		preservesUndeclaredEntityReferences: true;
		parseDocument.
	self assert:
		(parser wasSentSelectors:
			#(startDocument
				startElement:prefix:uri:localName:attributes:
				skippedEntity:
				characters:
				endElement:prefix:uri:localName:
				endDocument)).
	self
		assert: (parser argumentsSentWith: #skippedEntity:) = #('undeclared');
		assert: (parser argumentsSentWith: #characters:) = #('&undeclared;').
]

{ #category : #tests }
SAXHandlerTest >> testSAXSkippedEntityUnreplaced [
	| xml parser |

	xml := '<!DOCTYPE root [<!ENTITY declared "replacement">]><root>&declared;</root>'.
	(parser := SAXHandlerProxy on: xml)
		isValidating: true;
		replacesContentEntityReferences: false;
		parseDocument.
	self assert:
		(parser wasSentSelectors:
			#(startDocument
				startDTD:publicID:systemID:
				generalEntityDeclaration:replacement:
				endDTD
				startElement:prefix:uri:localName:attributes:
				skippedEntity:
				characters:
				endElement:prefix:uri:localName:
				endDocument)).
	self
		assert: (parser argumentsSentWith: #skippedEntity:) = #('declared');
		assert: (parser argumentsSentWith: #characters:) = #('&declared;').
]

{ #category : #tests }
SAXHandlerTest >> testSAXStartElementForwarding [
	| messageRecorder message arguments |

	messageRecorder :=
		(SAXElementEventRecordingHandler on: self prefixedXMLSource)
			parseDocument;
			messageRecorder.

	message := messageRecorder nextMessage.
	self assert: message selector == #startElement:attributes:.

	arguments := message arguments.
	self
		assert: arguments first = 'prefix:test';
		assert: arguments second = self prefixedXMLAttributes.
]

{ #category : #tests }
SAXHandlerTest >> testSAXStartElementForwardingNamespacesDisabled [
	| messageRecorder message arguments |

	messageRecorder :=
		(SAXElementEventRecordingHandler on: self prefixedXMLSource)
			usesNamespaces: false;
			parseDocument;
			messageRecorder.
	
	message := messageRecorder nextMessage.
	self assert: message selector == #startElement:attributes:.

	arguments := message arguments.
	self
		assert: arguments first = 'prefix:test';
		assert: arguments second = self prefixedXMLAttributesNamespacesDisabled.
]

{ #category : #tests }
SAXHandlerTest >> testSAXStartElementPrefixURIForwarding [
	| messageRecorder message arguments |

	messageRecorder :=
		(SAXElementPrefixURIEventRecordingHandler on: self prefixedXMLSource)
			parseDocument;
			messageRecorder.

	message := messageRecorder nextMessage.
	self assert: message selector == #startElement:prefix:uri:attributes:.

	arguments := message arguments.
	self
		assert: arguments first = 'prefix:test';
		assert: arguments second = 'prefix';
		assert: arguments third = 'prefixNS';
		assert: arguments fourth = self prefixedXMLAttributes.
]

{ #category : #tests }
SAXHandlerTest >> testSAXStartElementPrefixURIForwardingNamespacesDisabled [
	| messageRecorder message arguments |

	messageRecorder :=
		(SAXElementPrefixURIEventRecordingHandler on: self prefixedXMLSource)
			usesNamespaces: false;
			parseDocument;
			messageRecorder.

	message := messageRecorder nextMessage.
	self assert: message selector == #startElement:prefix:uri:attributes:.

	arguments := message arguments.
	self
		assert: arguments first = 'prefix:test';
		assert: arguments second = 'prefix';
		assert: arguments third isEmpty;
		assert: arguments fourth = self prefixedXMLAttributesNamespacesDisabled.
]

{ #category : #tests }
SAXHandlerTest >> testSAXStartElementPrefixURILocalName [
	| messageRecorder message arguments |

	messageRecorder :=
		(SAXElementPrefixURILocalNameEventRecordingHandler on: self prefixedXMLSource)
			parseDocument;
			messageRecorder.

	message := messageRecorder nextMessage.
	self assert: message selector == #startElement:prefix:uri:localName:attributes:.

	arguments := message arguments.
	self
		assert: arguments first = 'prefix:test';
		assert: arguments second = 'prefix';
		assert: arguments third = 'prefixNS';
		assert: arguments fourth = 'test';
		assert: arguments fifth = self prefixedXMLAttributes.
]

{ #category : #tests }
SAXHandlerTest >> testSAXStartElementPrefixURILocalNameNamespacesDisabled [
	| messageRecorder message arguments |

	messageRecorder :=
		(SAXElementPrefixURILocalNameEventRecordingHandler on: self prefixedXMLSource)
			usesNamespaces: false;
			parseDocument;
			messageRecorder.

	message := messageRecorder nextMessage.
	self assert: message selector == #startElement:prefix:uri:localName:attributes:.

	arguments := message arguments.
	self
		assert: arguments first = 'prefix:test';
		assert: arguments second = 'prefix';
		assert: arguments third = '';
		assert: arguments fourth = 'test';
		assert: arguments fifth = self prefixedXMLAttributesNamespacesDisabled.
]

{ #category : #tests }
SAXHandlerTest >> testSAXStartPrefixMapping [
	| parser messages |

	(parser := SAXHandlerProxy on: self prefixedXMLSource)
		parseDocument.
	self assert: (parser wasSentSelectors: self prefixedXMLSourceSelectors).
	messages := parser allSentMessagesNamed: #startPrefixMapping:uri:.
	self
		assert: messages size = 2;
		assert: messages first arguments = #('prefix' 'prefixNS');
		assert: messages second arguments = #('' 'defaultNS').

	(parser :=
		SAXHandlerProxy on:
			'<one xmlns="defaultNS"><two xmlns="defaultNS"/></one>')
		parseDocument.
	messages := parser allSentMessagesNamed: #startPrefixMapping:uri:.
	self
		assert: messages size = 1;
		assert: messages first arguments = #('' 'defaultNS').

	(parser :=
		SAXHandlerProxy on:
			'<one xmlns="defaultNS"><two xmlns="newDefaultNS"/></one>')
		parseDocument.
	messages := parser allSentMessagesNamed: #startPrefixMapping:uri:.
	self
		assert: messages size = 2;
		assert: messages first arguments = #('' 'defaultNS');
		assert: messages second arguments = #('' 'newDefaultNS').

	(parser :=
		SAXHandlerProxy on:
			'<one xmlns:xml="', XMLNamespaceScope xmlNamespaceURI, '"/>')
		parseDocument.
	self assert:
		(parser allSentMessagesNamed: #startPrefixMapping:uri:) isEmpty.
]

{ #category : #tests }
SAXHandlerTest >> testSAXXMLDeclaration [
	| parser selectors arguments |

	(parser :=
		SAXHandlerProxy on:
			'<?xml version="1.0" encoding="UTF-8"?><test/>')
		parseDocument.
	selectors :=
		#(startDocument
			xmlVersion:encoding:standalone:
			startElement:prefix:uri:localName:attributes:
			endElement:prefix:uri:localName:
			endDocument).
	self assert: (parser wasSentSelectors: selectors).

	arguments := parser argumentsSentWith: #xmlVersion:encoding:standalone:.
	self
		assert: arguments first = 1.0;
		assert: arguments second = 'UTF-8';
		deny: arguments third.

	(parser :=
		SAXHandlerProxy on:
			'<?xml version="1.1" encoding="utf-8" standalone="yes"?><test/>')
		parseDocument.
	self assert: (parser wasSentSelectors: selectors).

	arguments := (parser argumentsSentWith: #xmlVersion:encoding:standalone:).
	self
		assert: arguments first = 1.1;
		assert: arguments second = 'utf-8';
		assert: arguments third.
]
