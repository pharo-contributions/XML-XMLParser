Class {
	#name : #XMLFileHandleTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser-Files'
}

{ #category : #testing }
XMLFileHandleTest >> hasSupportedImplementation [
	^ XMLFileHandle hasSupportedImplementation
]

{ #category : #tests }
XMLFileHandleTest >> testExtension [
	self hasSupportedImplementation
		ifFalse: [^ self].

	self
		assert: '' asXMLFileHandle extension = '';
		assert: 'one' asXMLFileHandle extension = '';
		assert: 'one.two' asXMLFileHandle extension = 'two';
		assert: 'one.two.three' asXMLFileHandle extension = 'two.three';
		assert: '/' asXMLFileHandle extension = '';
		assert: '/one' asXMLFileHandle extension = '';
		assert: '/one.two' asXMLFileHandle extension = 'two';
		assert: '/one.two.three' asXMLFileHandle extension = 'two.three';
		assert: 'one/' asXMLFileHandle extension = '';
		assert: 'one/two' asXMLFileHandle extension = '';
		assert: 'one/two.three' asXMLFileHandle extension = 'three';
		assert: 'one/two.three.four' asXMLFileHandle extension = 'three.four';
		assert: 'one/two/' asXMLFileHandle extension = '';
		assert: 'one/two.three/' asXMLFileHandle extension = '';
		assert: 'one/two.three.four/' asXMLFileHandle extension = ''.
]

{ #category : #tests }
XMLFileHandleTest >> testIsXMLDocumentFile [
	self hasSupportedImplementation
		ifFalse: [^ self].

	#('atom' 'dbk' 'docm' 'docx' 'pptm' 'pptx' 'rdf' 'rss' 'svg' 'xbel'
		'xfd' 'xfdl' 'xhtml' 'xlsm' 'xlsx' 'xml' 'xsd' 'xspf' 'xul')
		do: [:each |
			self assert:
				('test.', each) asXMLFileHandle isXMLDocumentFile.
			self assert:
				('test.', each asUppercase) asXMLFileHandle isXMLDocumentFile].

	#('txt' 'html' 'jpeg' 'jpg' 'gif' 'dtd' 'ent')
		do: [:each |
			self deny:
				('test.', each) asXMLFileHandle isXMLDocumentFile].
]
