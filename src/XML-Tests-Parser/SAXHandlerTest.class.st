Class {
	#name : #SAXHandlerTest,
	#superclass : #XMLParserTest,
	#category : #'XML-Tests-Parser'
}

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
	<root>
		<child>
			test
		</child>
	</root>
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
	| xml parser |

	xml := '<prefix:root xmlns:prefix="prefixNS" xmlns="defaultNS"></prefix:root>'.
	(parser := SAXHandlerProxy saxHandler: (SAXHandler on: xml)) parseDocument.
	self assert:
		#(startDocument
			startPrefixMapping:uri: startPrefixMapping:uri:
			startElement:prefix:uri:localName:attributes: endElement:prefix:uri:localName:
			endPrefixMapping: endPrefixMapping:
			endDocument) = parser sentHandlerSelectors.
	self assert:
		((parser sentHandlerMessages select: [:each |
			#(startPrefixMapping:uri: endPrefixMapping:) includes: each selector])
				collect: [:each | each arguments asArray]) asArray =
					#(#('prefix' 'prefixNS') #('' 'defaultNS') #('prefix') #('')).
]

{ #category : #tests }
SAXHandlerTest >> testSAXPrefixMappingHandlersDisabled [
	| xml parser |

	xml := '<prefix:root xmlns:prefix="prefixNS" xmlns="defaultNS"></prefix:root>'.
	(parser := SAXHandlerProxy saxHandler: (SAXHandler on: xml))
		usesNamespaces: false;
		parseDocument.
	self assert:
		#(startDocument
			startElement:prefix:uri:localName:attributes: endElement:prefix:uri:localName:
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
