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
SAXHandlerTest >> testSAXEntityHandlers [
	| xml parser |

	xml := '<!DOCTYPE root [
		<!ENTITY % firstDeclaration "<!ENTITY first &#39; &second; &#39;>">
		%firstDeclaration;
		<!ENTITY second " replacement ">]>
	<root name="&second;">&first;</root>'.
	(parser :=SAXHandlerProxy saxHandler: (SAXHandler on: xml)) parseDocument.
	self assert:
		#(startDocument
			startDTD:publicID:systemID:
			parameterEntityDeclaration:replacement:
			generalEntityDeclaration:replacement: generalEntityDeclaration:replacement:
			endDTD
			startElement:prefix:uri:localName:attributes:
			startEntity: startEntity: endEntity: endEntity: characters:
			endElement:prefix:uri:localName:
			endDocument) = parser sentHandlerSelectors.
	self assert:
		((parser sentHandlerMessages select: [:each | #(startEntity: endEntity:) includes: each selector])
			collect: [:each | each arguments first]) asArray = #('first' 'second' 'second' 'first').
]

{ #category : #tests }
SAXHandlerTest >> testSAXIgnorableWhitespace [
	| xml parser whitespace |

	xml := '
	<one>
		<two>
			test
		</two>
	</one>
	'.
	(parser := SAXHandlerProxy saxHandler: (SAXHandler on: xml)) parseDocument.
	self assert:
		#(startDocument
			startElement:prefix:uri:localName:attributes:
			ignorableWhitespace:
			startElement:prefix:uri:localName:attributes: characters: endElement:prefix:uri:localName:
			ignorableWhitespace:
			endElement:prefix:uri:localName:
			ignorableWhitespace:
			endDocument) = parser sentHandlerSelectors.
	self assert:
		((parser sentHandlerMessages select: [:each | each selector == #ignorableWhitespace:])
			allSatisfy: [:each |
				(whitespace := each arguments first) notEmpty
					and: [whitespace allSatisfy: [:char | char isSeparator]]]).
]

{ #category : #tests }
SAXHandlerTest >> testSAXPrefixMappingHandlers [
	| parser |

	(parser := SAXHandlerProxy saxHandler: (SAXHandler on: self prefixedXMLSource)) parseDocument.
	self assert:
		#(startDocument
			startPrefixMapping:uri: startPrefixMapping:uri:
			startElement:prefix:uri:localName:attributes:
			characters:
			endElement:prefix:uri:localName:
			endPrefixMapping: endPrefixMapping:
			endDocument) = parser sentHandlerSelectors.
	self assert:
		((parser sentHandlerMessages select: [:each |
			#(startPrefixMapping:uri: endPrefixMapping:) includes: each selector])
				collect: [:each | each arguments asArray]) asArray =
					#(#('prefix' 'prefixNS') #('' 'defaultNS') #('prefix') #('')).
]

{ #category : #tests }
SAXHandlerTest >> testSAXPrefixMappingHandlersNamespacesDisabled [
	| parser |

	(parser := SAXHandlerProxy saxHandler: (SAXHandler on: self prefixedXMLSource))
		usesNamespaces: false;
		parseDocument.
	self assert:
		#(startDocument
			startElement:prefix:uri:localName:attributes:
			characters:
			endElement:prefix:uri:localName:
			endDocument) = parser sentHandlerSelectors.
]

{ #category : #tests }
SAXHandlerTest >> testSAXSkippedEntityHandler [
	| xml parser |

	xml := '<root>&undeclared;</root>'.
	(parser := SAXHandlerProxy saxHandler: (SAXHandler on: xml))
		isValidating: false;
		parseDocument.
	self assert:
		#(startDocument
			startElement:prefix:uri:localName:attributes:
			skippedEntity:
			endElement:prefix:uri:localName:
			endDocument) = parser sentHandlerSelectors.
	self assert:
		(parser sentHandlerMessages detect: [:each | each selector == #skippedEntity:])
			arguments first = 'undeclared'.
]

{ #category : #tests }
SAXHandlerTest >> testSAXStartElementEndElement [
	| parser startElementMessage endElementMessage |

	(parser := SAXHandlerProxy saxHandler: (SAXHandler on: self prefixedXMLSource))
		parseDocument.
	startElementMessage :=
		(parser sentHandlerMessages detect: [:each |
			each selector == #startElement:prefix:uri:localName:attributes:]).
	self assert:
		startElementMessage arguments asArray =
			((Array with: 'prefix:test' with: 'prefix' with: 'prefixNS' with: 'test')
				copyWith: (Dictionary with: 'name' -> 'value')).

	endElementMessage := 
		(parser sentHandlerMessages detect: [:each |
			each selector == #endElement:prefix:uri:localName:]).
	self assert:
		endElementMessage arguments asArray =
			(Array with: 'prefix:test' with: 'prefix' with: 'prefixNS' with: 'test').
]

{ #category : #tests }
SAXHandlerTest >> testSAXStartElementEndElementNamespacesDisabled [
	| parser startElementMessage endElementMessage |

	(parser := SAXHandlerProxy saxHandler: (SAXHandler on: self prefixedXMLSource))
		usesNamespaces: false;
		parseDocument.
	startElementMessage :=
		(parser sentHandlerMessages detect: [:each |
			each selector == #startElement:prefix:uri:localName:attributes:]).
	self assert:
		startElementMessage arguments asArray =
			((Array with: 'prefix:test' with: 'prefix' with: '' with: 'test')
				copyWith:
					(Dictionary
						with: 'xmlns:prefix' -> 'prefixNS'
						with: 'xmlns' -> 'defaultNS'
						with: 'name' -> 'value')).

	endElementMessage := 
		(parser sentHandlerMessages detect: [:each |
			each selector == #endElement:prefix:uri:localName:]).
	self assert:
		endElementMessage arguments asArray =
			(Array with: 'prefix:test' with: 'prefix' with: '' with: 'test').
]
