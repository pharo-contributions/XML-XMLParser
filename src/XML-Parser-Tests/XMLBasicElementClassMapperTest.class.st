Class {
	#name : 'XMLBasicElementClassMapperTest',
	#superclass : 'XMLElementClassMapperTest',
	#category : 'XML-Parser-Tests-Utils',
	#package : 'XML-Parser-Tests',
	#tag : 'Utils'
}

{ #category : 'acccessing' }
XMLBasicElementClassMapperTest >> mapperClass [
	^ XMLBasicElementClassMapper
]

{ #category : 'tests' }
XMLBasicElementClassMapperTest >> testClassForElement [

	| mapper |
	mapper := self newMapper.
	self
		assert: (mapper classForElement: 'test') isNil;
		assert: (mapper classForElement: 'prefix:test') isNil.

	mapper mapElement: 'test' toClass: self elementClass.
	self
		assert: (mapper classForElement: 'test')
		identicalTo: self elementClass;
		assert: (mapper classForElement: 'prefix:test')
		identicalTo: self elementClass.

	mapper
		mapElement: 'test'
		attributeSpec: self attributes asXMLAttributeSpec
		toClass: self otherElementClass.
	self
		assert: (mapper classForElement: 'test')
		identicalTo: self elementClass;
		assert: (mapper classForElement: 'prefix:test')
		identicalTo: self elementClass.

	mapper
		mapElement: 'test'
		namespaceURI: 'testNS'
		toClass: self otherElementClass.
	self
		assert: (mapper classForElement: 'test')
		identicalTo: self elementClass;
		assert: (mapper classForElement: 'prefix:test')
		identicalTo: self elementClass.

	mapper
		mapElement: 'test'
		namespaceURI: 'testNS'
		attributeSpec: self attributes asXMLAttributeSpec
		toClass: self otherElementClass.
	self
		assert: (mapper classForElement: 'test')
		identicalTo: self elementClass;
		assert: (mapper classForElement: 'prefix:test')
		identicalTo: self elementClass.

	"QName mappings should take precedence over NCName mappings"
	mapper mapElement: 'prefix:test' toClass: self otherElementClass.
	self
		assert: (mapper classForElement: 'test')
		identicalTo: self elementClass;
		assert: (mapper classForElement: 'prefix:test')
		identicalTo: self otherElementClass
]

{ #category : 'tests' }
XMLBasicElementClassMapperTest >> testClassForElementAttributes [

	| mapper |
	mapper := self newMapper.
	self assert:
		(mapper classForElement: 'test' attributes: self attributes) isNil.
	self assert:
		(mapper classForElement: 'prefix:test' attributes: self attributes)
			isNil.

	mapper mapElement: 'test' toClass: self otherElementClass.
	self
		assert: (mapper classForElement: 'test' attributes: self attributes)
		identicalTo: self otherElementClass.
	(mapper classForElement: 'prefix:test' attributes: self attributes)
	== self otherElementClass.

	mapper
		mapElement: 'test'
		attributeSpec: self attributes asXMLAttributeSpec
		toClass: self elementClass.
	self
		assert: (mapper classForElement: 'test' attributes: self attributes)
		identicalTo: self elementClass.
	self
		assert:
		(mapper classForElement: 'prefix:test' attributes: self attributes)
		identicalTo: self elementClass.

	mapper
		mapElement: 'test'
		namespaceURI: 'testNS'
		toClass: self otherElementClass.
	self
		assert: (mapper classForElement: 'test' attributes: self attributes)
		identicalTo: self elementClass.
	self
		assert:
		(mapper classForElement: 'prefix:test' attributes: self attributes)
		identicalTo: self elementClass.

	mapper
		mapElement: 'test'
		namespaceURI: 'testNS'
		attributeSpec: self attributes asXMLAttributeSpec
		toClass: self otherElementClass.
	self
		assert: (mapper classForElement: 'test' attributes: self attributes)
		identicalTo: self elementClass.
	self
		assert:
		(mapper classForElement: 'prefix:test' attributes: self attributes)
		identicalTo: self elementClass.
	mapper
		mapElement: 'prefix:test'
		attributeSpec: self attributes asXMLAttributeSpec
		toClass: self otherElementClass.
	self
		assert: (mapper classForElement: 'test' attributes: self attributes)
		identicalTo: self elementClass.
	self
		assert:
		(mapper classForElement: 'prefix:test' attributes: self attributes)
		identicalTo: self otherElementClass
]

{ #category : 'tests' }
XMLBasicElementClassMapperTest >> testClassForElementAttributesIfNone [

	| mapper |
	mapper := self newMapper.
	self
		assert: (mapper
				 classForElement: 'test'
				 attributes: self attributes
				 ifNone: [ #none ])
		identicalTo: #none.
	self
		assert: (mapper
				 classForElement: 'prefix:test'
				 attributes: self attributes
				 ifNone: [ #none ])
		identicalTo: #none.

	mapper mapElement: 'test' toClass: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'test'
				 attributes: self attributes
				 ifNone: [ self fail ])
		identicalTo: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'prefix:test'
				 attributes: self attributes
				 ifNone: [ self fail ])
		identicalTo: self otherElementClass.

	mapper
		mapElement: 'test'
		attributeSpec: self attributes asXMLAttributeSpec
		toClass: self elementClass.
	self
		assert: (mapper
				 classForElement: 'test'
				 attributes: self attributes
				 ifNone: [ self fail ])
		identicalTo: self elementClass.
	self
		assert: (mapper
				 classForElement: 'prefix:test'
				 attributes: self attributes
				 ifNone: [ self fail ])
		identicalTo: self elementClass.

	mapper
		mapElement: 'test'
		namespaceURI: 'testNS'
		toClass: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'test'
				 attributes: self attributes
				 ifNone: [ self fail ])
		identicalTo: self elementClass.
	self
		assert: (mapper
				 classForElement: 'prefix:test'
				 attributes: self attributes
				 ifNone: [ self fail ])
		identicalTo: self elementClass.

	mapper
		mapElement: 'test'
		namespaceURI: 'testNS'
		attributeSpec: self attributes asXMLAttributeSpec
		toClass: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'test'
				 attributes: self attributes
				 ifNone: [ self fail ])
		identicalTo: self elementClass.
	self
		assert: (mapper
				 classForElement: 'prefix:test'
				 attributes: self attributes
				 ifNone: [ self fail ])
		identicalTo: self elementClass.
	mapper
		mapElement: 'prefix:test'
		attributeSpec: self attributes asXMLAttributeSpec
		toClass: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'test'
				 attributes: self attributes
				 ifNone: [ self fail ])
		identicalTo: self elementClass.
	self
		assert: (mapper
				 classForElement: 'prefix:test'
				 attributes: self attributes
				 ifNone: [ self fail ])
		identicalTo: self otherElementClass
]

{ #category : 'tests' }
XMLBasicElementClassMapperTest >> testClassForElementIfNone [

	| mapper |
	mapper := self newMapper.
	self
		assert: (mapper classForElement: 'test' ifNone: [ #none ])
		identicalTo: #none.
	self
		assert: (mapper classForElement: 'prefix:test' ifNone: [ #none ])
		identicalTo: #none.

	mapper mapElement: 'test' toClass: self elementClass.
	self
		assert: (mapper classForElement: 'test' ifNone: [ self fail ])
		identicalTo: self elementClass.
	self
		assert:
		(mapper classForElement: 'prefix:test' ifNone: [ self fail ])
		identicalTo: self elementClass.

	mapper
		mapElement: 'test'
		attributeSpec: self attributes asXMLAttributeSpec
		toClass: self otherElementClass.
	self
		assert: (mapper classForElement: 'test' ifNone: [ self fail ])
		identicalTo: self elementClass.
	self
		assert:
		(mapper classForElement: 'prefix:test' ifNone: [ self fail ])
		identicalTo: self elementClass.

	mapper
		mapElement: 'test'
		namespaceURI: 'testNS'
		toClass: self otherElementClass.
	self
		assert: (mapper classForElement: 'test' ifNone: [ self fail ])
		identicalTo: self elementClass.
	self
		assert:
		(mapper classForElement: 'prefix:test' ifNone: [ self fail ])
		identicalTo: self elementClass.

	mapper
		mapElement: 'test'
		namespaceURI: 'testNS'
		attributeSpec: self attributes asXMLAttributeSpec
		toClass: self otherElementClass.
	self
		assert: (mapper classForElement: 'test' ifNone: [ self fail ])
		identicalTo: self elementClass.
	self
		assert:
		(mapper classForElement: 'prefix:test' ifNone: [ self fail ])
		identicalTo: self elementClass.
	mapper mapElement: 'prefix:test' toClass: self otherElementClass.
	self
		assert: (mapper classForElement: 'test' ifNone: [ self fail ])
		identicalTo: self elementClass.
	self
		assert:
		(mapper classForElement: 'prefix:test' ifNone: [ self fail ])
		identicalTo: self otherElementClass
]

{ #category : 'tests' }
XMLBasicElementClassMapperTest >> testClassForElementNamespaceURI [

	| mapper |
	mapper := self newMapper.
	self assert:
		(mapper classForElement: 'test' namespaceURI: 'testNS') isNil.
	self assert:
		(mapper classForElement: 'prefix:test' namespaceURI: 'testNS') isNil.

	mapper mapElement: 'test' toClass: self otherElementClass.
	self
		assert: (mapper classForElement: 'test' namespaceURI: 'testNS')
		identicalTo: self otherElementClass.
	self
		assert:
		(mapper classForElement: 'prefix:test' namespaceURI: 'testNS')
		identicalTo: self otherElementClass.

	mapper
		mapElement: 'test'
		attributeSpec: self attributes asXMLAttributeSpec
		toClass: self otherElementClass.
	self
		assert: (mapper classForElement: 'test' namespaceURI: 'testNS')
		identicalTo: self otherElementClass.
	self
		assert:
		(mapper classForElement: 'prefix:test' namespaceURI: 'testNS')
		identicalTo: self otherElementClass.

	mapper
		mapElement: 'test'
		namespaceURI: 'testNS'
		toClass: self elementClass.
	self
		assert: (mapper classForElement: 'test' namespaceURI: 'testNS')
		identicalTo: self elementClass.
	self
		assert:
		(mapper classForElement: 'prefix:test' namespaceURI: 'testNS')
		identicalTo: self elementClass.

	mapper
		mapElement: 'test'
		namespaceURI: 'testNS'
		attributeSpec: self attributes asXMLAttributeSpec
		toClass: self otherElementClass.
	self
		assert: (mapper classForElement: 'test' namespaceURI: 'testNS')
		identicalTo: self elementClass.
	self
		assert:
		(mapper classForElement: 'prefix:test' namespaceURI: 'testNS')
		identicalTo: self elementClass.
	mapper
		mapElement: 'prefix:test'
		namespaceURI: 'testNS'
		toClass: self otherElementClass.
	self
		assert: (mapper classForElement: 'test' namespaceURI: 'testNS')
		identicalTo: self elementClass.
	self
		assert:
		(mapper classForElement: 'prefix:test' namespaceURI: 'testNS')
		identicalTo: self otherElementClass
]

{ #category : 'tests' }
XMLBasicElementClassMapperTest >> testClassForElementNamespaceURIAttributes [

	| mapper |
	mapper := self newMapper.
	self assert: (mapper
			 classForElement: 'test'
			 namespaceURI: 'testNS'
			 attributes: self attributes) isNil.
	self assert: (mapper
			 classForElement: 'prefix:test'
			 namespaceURI: 'testNS'
			 attributes: self attributes) isNil.

	mapper mapElement: 'test' toClass: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'test'
				 namespaceURI: 'testNS'
				 attributes: self attributes)
		identicalTo: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'prefix:test'
				 namespaceURI: 'testNS'
				 attributes: self attributes)
		identicalTo: self otherElementClass.

	mapper
		mapElement: 'test'
		attributeSpec: self attributes asXMLAttributeSpec
		toClass: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'test'
				 namespaceURI: 'testNS'
				 attributes: self attributes)
		identicalTo: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'prefix:test'
				 namespaceURI: 'testNS'
				 attributes: self attributes)
		identicalTo: self otherElementClass.

	mapper
		mapElement: 'test'
		namespaceURI: 'testNS'
		toClass: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'test'
				 namespaceURI: 'testNS'
				 attributes: self attributes)
		identicalTo: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'prefix:test'
				 namespaceURI: 'testNS'
				 attributes: self attributes)
		identicalTo: self otherElementClass.

	mapper
		mapElement: 'test'
		namespaceURI: 'testNS'
		attributeSpec: self attributes asXMLAttributeSpec
		toClass: self elementClass.
	self
		assert: (mapper
				 classForElement: 'test'
				 namespaceURI: 'testNS'
				 attributes: self attributes)
		identicalTo: self elementClass.
	self
		assert: (mapper
				 classForElement: 'prefix:test'
				 namespaceURI: 'testNS'
				 attributes: self attributes)
		identicalTo: self elementClass.
	mapper
		mapElement: 'prefix:test'
		namespaceURI: 'testNS'
		attributeSpec: self attributes asXMLAttributeSpec
		toClass: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'test'
				 namespaceURI: 'testNS'
				 attributes: self attributes)
		identicalTo: self elementClass.
	self
		assert: (mapper
				 classForElement: 'prefix:test'
				 namespaceURI: 'testNS'
				 attributes: self attributes)
		identicalTo: self otherElementClass
]

{ #category : 'tests' }
XMLBasicElementClassMapperTest >> testClassForElementNamespaceURIAttributesIfNone [

	| mapper |
	mapper := self newMapper.
	self
		assert: (mapper
				 classForElement: 'test'
				 namespaceURI: 'testNS'
				 attributes: self attributes
				 ifNone: [ #none ])
		identicalTo: #none.
	self
		assert: (mapper
				 classForElement: 'prefix:test'
				 namespaceURI: 'testNS'
				 attributes: self attributes
				 ifNone: [ #none ])
		identicalTo: #none.

	mapper mapElement: 'test' toClass: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'test'
				 namespaceURI: 'testNS'
				 attributes: self attributes
				 ifNone: [ self fail ])
		identicalTo: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'prefix:test'
				 namespaceURI: 'testNS'
				 attributes: self attributes
				 ifNone: [ self fail ])
		identicalTo: self otherElementClass.

	mapper
		mapElement: 'test'
		attributeSpec: self attributes asXMLAttributeSpec
		toClass: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'test'
				 namespaceURI: 'testNS'
				 attributes: self attributes
				 ifNone: [ self fail ])
		identicalTo: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'prefix:test'
				 namespaceURI: 'testNS'
				 attributes: self attributes
				 ifNone: [ self fail ])
		identicalTo: self otherElementClass.

	mapper
		mapElement: 'test'
		namespaceURI: 'testNS'
		toClass: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'test'
				 namespaceURI: 'testNS'
				 attributes: self attributes
				 ifNone: [ self fail ])
		identicalTo: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'prefix:test'
				 namespaceURI: 'testNS'
				 attributes: self attributes
				 ifNone: [ self fail ])
		identicalTo: self otherElementClass.

	mapper
		mapElement: 'test'
		namespaceURI: 'testNS'
		attributeSpec: self attributes asXMLAttributeSpec
		toClass: self elementClass.
	self
		assert: (mapper
				 classForElement: 'test'
				 namespaceURI: 'testNS'
				 attributes: self attributes
				 ifNone: [ self fail ])
		identicalTo: self elementClass.
	self
		assert: (mapper
				 classForElement: 'prefix:test'
				 namespaceURI: 'testNS'
				 attributes: self attributes
				 ifNone: [ self fail ])
		identicalTo: self elementClass.
	mapper
		mapElement: 'prefix:test'
		namespaceURI: 'testNS'
		attributeSpec: self attributes asXMLAttributeSpec
		toClass: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'test'
				 namespaceURI: 'testNS'
				 attributes: self attributes
				 ifNone: [ self fail ])
		identicalTo: self elementClass.
	self
		assert: (mapper
				 classForElement: 'prefix:test'
				 namespaceURI: 'testNS'
				 attributes: self attributes
				 ifNone: [ self fail ])
		identicalTo: self otherElementClass
]

{ #category : 'tests' }
XMLBasicElementClassMapperTest >> testClassForElementNamespaceURIIfNone [

	| mapper |
	mapper := self newMapper.
	self
		assert: (mapper
				 classForElement: 'test'
				 namespaceURI: 'testNS'
				 ifNone: [ #none ])
		identicalTo: #none.
	self
		assert: (mapper
				 classForElement: 'prefix:test'
				 namespaceURI: 'testNS'
				 ifNone: [ #none ])
		identicalTo: #none.

	mapper mapElement: 'test' toClass: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'test'
				 namespaceURI: 'testNS'
				 ifNone: [ self fail ])
		identicalTo: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'prefix:test'
				 namespaceURI: 'testNS'
				 ifNone: [ self fail ])
		identicalTo: self otherElementClass.

	mapper
		mapElement: 'test'
		attributeSpec: self attributes asXMLAttributeSpec
		toClass: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'test'
				 namespaceURI: 'testNS'
				 ifNone: [ self fail ])
		identicalTo: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'prefix:test'
				 namespaceURI: 'testNS'
				 ifNone: [ self fail ])
		identicalTo: self otherElementClass.

	mapper
		mapElement: 'test'
		namespaceURI: 'testNS'
		toClass: self elementClass.
	self
		assert: (mapper
				 classForElement: 'test'
				 namespaceURI: 'testNS'
				 ifNone: [ self fail ])
		identicalTo: self elementClass.
	self
		assert: (mapper
				 classForElement: 'prefix:test'
				 namespaceURI: 'testNS'
				 ifNone: [ self fail ])
		identicalTo: self elementClass.

	mapper
		mapElement: 'test'
		namespaceURI: 'testNS'
		attributeSpec: self attributes asXMLAttributeSpec
		toClass: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'test'
				 namespaceURI: 'testNS'
				 ifNone: [ self fail ])
		identicalTo: self elementClass.
	self
		assert: (mapper
				 classForElement: 'prefix:test'
				 namespaceURI: 'testNS'
				 ifNone: [ self fail ])
		identicalTo: self elementClass.
	mapper
		mapElement: 'prefix:test'
		namespaceURI: 'testNS'
		toClass: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'test'
				 namespaceURI: 'testNS'
				 ifNone: [ self fail ])
		identicalTo: self elementClass.
	self
		assert: (mapper
				 classForElement: 'prefix:test'
				 namespaceURI: 'testNS'
				 ifNone: [ self fail ])
		identicalTo: self otherElementClass
]

{ #category : 'tests' }
XMLBasicElementClassMapperTest >> testClassForElementNamespaceURILocalNameAttributes [

	| mapper |
	mapper := self newMapper.
	self assert: (mapper
			 classForElement: 'test'
			 namespaceURI: 'testNS'
			 localName: 'test'
			 attributes: self attributes) isNil.
	self assert: (mapper
			 classForElement: 'prefix:test'
			 namespaceURI: 'testNS'
			 localName: 'test'
			 attributes: self attributes) isNil.

	mapper mapElement: 'test' toClass: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'test'
				 namespaceURI: 'testNS'
				 localName: 'test'
				 attributes: self attributes)
		identicalTo: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'prefix:test'
				 namespaceURI: 'testNS'
				 localName: 'test'
				 attributes: self attributes)
		identicalTo: self otherElementClass.

	mapper
		mapElement: 'test'
		attributeSpec: self attributes asXMLAttributeSpec
		toClass: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'test'
				 namespaceURI: 'testNS'
				 localName: 'test'
				 attributes: self attributes)
		identicalTo: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'prefix:test'
				 namespaceURI: 'testNS'
				 localName: 'test'
				 attributes: self attributes)
		identicalTo: self otherElementClass.

	mapper
		mapElement: 'test'
		namespaceURI: 'testNS'
		toClass: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'test'
				 namespaceURI: 'testNS'
				 localName: 'test'
				 attributes: self attributes)
		identicalTo: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'prefix:test'
				 namespaceURI: 'testNS'
				 localName: 'test'
				 attributes: self attributes)
		identicalTo: self otherElementClass.

	mapper
		mapElement: 'test'
		namespaceURI: 'testNS'
		attributeSpec: self attributes asXMLAttributeSpec
		toClass: self elementClass.
	self
		assert: (mapper
				 classForElement: 'test'
				 namespaceURI: 'testNS'
				 localName: 'test'
				 attributes: self attributes)
		identicalTo: self elementClass.
	self
		assert: (mapper
				 classForElement: 'prefix:test'
				 namespaceURI: 'testNS'
				 localName: 'test'
				 attributes: self attributes)
		identicalTo: self elementClass.
	mapper
		mapElement: 'prefix:test'
		namespaceURI: 'testNS'
		attributeSpec: self attributes asXMLAttributeSpec
		toClass: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'test'
				 namespaceURI: 'testNS'
				 localName: 'test'
				 attributes: self attributes)
		identicalTo: self elementClass.
	self
		assert: (mapper
				 classForElement: 'prefix:test'
				 namespaceURI: 'testNS'
				 localName: 'test'
				 attributes: self attributes)
		identicalTo: self otherElementClass
]

{ #category : 'tests' }
XMLBasicElementClassMapperTest >> testClassForElementNamespaceURILocalNameAttributesIfNone [

	| mapper |
	mapper := self newMapper.
	self
		assert: (mapper
				 classForElement: 'test'
				 namespaceURI: 'testNS'
				 localName: 'test'
				 attributes: self attributes
				 ifNone: [ #none ])
		identicalTo: #none.
	self
		assert: (mapper
				 classForElement: 'prefix:test'
				 namespaceURI: 'testNS'
				 localName: 'test'
				 attributes: self attributes
				 ifNone: [ #none ])
		identicalTo: #none.

	mapper mapElement: 'test' toClass: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'test'
				 namespaceURI: 'testNS'
				 localName: 'test'
				 attributes: self attributes
				 ifNone: [ self fail ])
		identicalTo: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'prefix:test'
				 namespaceURI: 'testNS'
				 localName: 'test'
				 attributes: self attributes
				 ifNone: [ self fail ])
		identicalTo: self otherElementClass.

	mapper
		mapElement: 'test'
		attributeSpec: self attributes asXMLAttributeSpec
		toClass: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'test'
				 namespaceURI: 'testNS'
				 localName: 'test'
				 attributes: self attributes
				 ifNone: [ self fail ])
		identicalTo: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'prefix:test'
				 namespaceURI: 'testNS'
				 localName: 'test'
				 attributes: self attributes
				 ifNone: [ self fail ])
		identicalTo: self otherElementClass.

	mapper
		mapElement: 'test'
		namespaceURI: 'testNS'
		toClass: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'test'
				 namespaceURI: 'testNS'
				 localName: 'test'
				 attributes: self attributes
				 ifNone: [ self fail ])
		identicalTo: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'prefix:test'
				 namespaceURI: 'testNS'
				 localName: 'test'
				 attributes: self attributes
				 ifNone: [ self fail ])
		identicalTo: self otherElementClass.

	mapper
		mapElement: 'test'
		namespaceURI: 'testNS'
		attributeSpec: self attributes asXMLAttributeSpec
		toClass: self elementClass.
	self
		assert: (mapper
				 classForElement: 'test'
				 namespaceURI: 'testNS'
				 localName: 'test'
				 attributes: self attributes
				 ifNone: [ self fail ])
		identicalTo: self elementClass.
	self
		assert: (mapper
				 classForElement: 'prefix:test'
				 namespaceURI: 'testNS'
				 localName: 'test'
				 attributes: self attributes
				 ifNone: [ self fail ])
		identicalTo: self elementClass.
	mapper
		mapElement: 'prefix:test'
		namespaceURI: 'testNS'
		attributeSpec: self attributes asXMLAttributeSpec
		toClass: self otherElementClass.
	self
		assert: (mapper
				 classForElement: 'test'
				 namespaceURI: 'testNS'
				 localName: 'test'
				 attributes: self attributes
				 ifNone: [ self fail ])
		identicalTo: self elementClass.
	self
		assert: (mapper
				 classForElement: 'prefix:test'
				 namespaceURI: 'testNS'
				 localName: 'test'
				 attributes: self attributes
				 ifNone: [ self fail ])
		identicalTo: self otherElementClass
]

{ #category : 'tests' }
XMLBasicElementClassMapperTest >> testCopy [

	| mapper copy |
	mapper := self newMapperWithMappings.
	copy := mapper copy.
	self
		deny: mapper identicalTo: copy;
		deny: mapper elementClassMap identicalTo: copy elementClassMap;
		assert: mapper elementClassMap equals: copy elementClassMap.

	mapper elementClassMap values
		with: copy elementClassMap values
		do: [ :classOrCollection :classOrCollectionCopy | "the collection values need to be copied so any new mappings
			in either the copy or original don't affect the other"
			classOrCollection isCollection
				ifTrue: [
					self
						deny: classOrCollection identicalTo: classOrCollectionCopy;
						assert: classOrCollection equals: classOrCollectionCopy ]
				ifFalse: [
				self deny: classOrCollection identicalTo: classOrCollectionCopy ] ].

	mapper mapElement: 'test' toClass: self otherElementClass.
	self deny: mapper elementClassMap equals: copy elementClassMap
]

{ #category : 'tests' }
XMLBasicElementClassMapperTest >> testMapElementAttributeSpecToClass [

	| mapper |
	mapper := self newMapper.
	self
		assert: (mapper
				 mapElement: 'test'
				 attributeSpec: self attributes asXMLAttributeSpec
				 toClass: self elementClass)
		identicalTo: mapper.
	self
		assert: (mapper classForElement: 'test' attributes: self attributes)
		identicalTo: self elementClass.
	self
		assert: (mapper
				 mapElement: 'test'
				 attributeSpec: self attributes asXMLAttributeSpec
				 toClass: self otherElementClass)
		identicalTo: mapper.
	self
		assert: (mapper classForElement: 'test' attributes: self attributes)
		identicalTo: self otherElementClass
]

{ #category : 'tests' }
XMLBasicElementClassMapperTest >> testMapElementNamespaceURIAttributeSpecToClass [

	| mapper |
	mapper := self newMapper.
	self
		assert: (mapper
				 mapElement: 'test'
				 namespaceURI: 'testNS'
				 attributeSpec: self attributes asXMLAttributeSpec
				 toClass: self elementClass)
		identicalTo: mapper.
	self
		assert: (mapper
				 classForElement: 'test'
				 namespaceURI: 'testNS'
				 attributes: self attributes)
		identicalTo: self elementClass.
	self
		assert: (mapper
				 mapElement: 'test'
				 namespaceURI: 'testNS'
				 attributeSpec: self attributes asXMLAttributeSpec
				 toClass: self otherElementClass)
		identicalTo: mapper.
	self
		assert: (mapper
				 classForElement: 'test'
				 namespaceURI: 'testNS'
				 attributes: self attributes)
		identicalTo: self otherElementClass
]

{ #category : 'tests' }
XMLBasicElementClassMapperTest >> testMapElementNamespaceURIToClass [

	| mapper |
	mapper := self newMapper.
	self
		assert: (mapper
				 mapElement: 'test'
				 namespaceURI: 'testNS'
				 toClass: self elementClass)
		identicalTo: mapper.
	self
		assert: (mapper classForElement: 'test' namespaceURI: 'testNS')
		identicalTo: self elementClass.
	self
		assert: (mapper
				 mapElement: 'test'
				 namespaceURI: 'testNS'
				 toClass: self otherElementClass)
		identicalTo: mapper.
	self
		assert: (mapper classForElement: 'test' namespaceURI: 'testNS')
		identicalTo: self otherElementClass
]

{ #category : 'tests' }
XMLBasicElementClassMapperTest >> testMapElementToClass [

	| mapper |
	mapper := self newMapper.
	self
		assert: (mapper mapElement: 'test' toClass: self elementClass)
		identicalTo: mapper.
	self
		assert: (mapper classForElement: 'test')
		identicalTo: self elementClass.
	self
		assert: (mapper mapElement: 'test' toClass: self otherElementClass)
		identicalTo: mapper.
	self
		assert: (mapper classForElement: 'test')
		identicalTo: self otherElementClass
]
