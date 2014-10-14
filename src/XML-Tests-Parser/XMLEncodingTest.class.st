Class {
	#name : #XMLEncodingTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser'
}

{ #category : #private }
XMLEncodingTest >> convertableStreamOn: aString [
	^ (MultiByteBinaryOrTextStream on: aString from: 1 to: aString size)
		text;
		yourself
]

{ #category : #tests }
XMLEncodingTest >> testDecodingCharacters [
	| xml document  |

	xml := '<?xml version="1.0" encoding="UTF-8"?>
			<test-data>&#{1};</test-data>'.

	document := XMLDOMParser parse: (xml format: (Array with: '8230')).
	self assert: document root contentString first charCode = 8230.

	self
		should: [XMLDOMParser parse: (xml format: (Array with: ''))]
		raise: XMLWellFormednessException.
	self
		should: [XMLDOMParser parse: (xml format: (Array with: '0'))]
		raise: XMLWellFormednessException.
	self
		should: [XMLDOMParser parse: (xml format: (Array with: '-1'))]
		raise: XMLWellFormednessException.
]

{ #category : #tests }
XMLEncodingTest >> testEncodingDeclaration [
	| xml utf8Xml latin1Xml |

	xml :=
		'<?xml version="1.0" encoding="{1}"?><root>',
		(Character value: 128) asString,
		'</root>'.
	utf8Xml := xml format: (Array with: 'UTF-8').
	latin1Xml := xml format: (Array with: 'ISO-8859-1').
	self
		should: [SAXHandler parse: (self convertableStreamOn: utf8Xml)]
		raise: Error.
	self
		shouldnt: [SAXHandler parse: (self convertableStreamOn: latin1Xml)]
		raise: Error.
]
