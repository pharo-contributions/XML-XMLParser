Class {
	#name : 'XMLAttributeDictionaryTest',
	#superclass : 'OrderPreservingStringDictionaryTest',
	#category : 'XML-Parser-Tests-Base',
	#package : 'XML-Parser-Tests',
	#tag : 'Base'
}

{ #category : 'accessing' }
XMLAttributeDictionaryTest >> dictionaryClass [
	^ XMLAttributeDictionary
]

{ #category : 'testing' }
XMLAttributeDictionaryTest >> isTestingLazyDictionary [
	^ false
]

{ #category : 'accessing' }
XMLAttributeDictionaryTest >> namespaceScope [
	^ XMLNamespaceScope new
		mapPrefix: '' to: 'defaultNS';
		mapPrefix: 'prefix' to: 'prefixNS';
		mapPrefix: 'otherPrefix' to: 'otherPrefixNS';
		yourself
]

{ #category : 'accessing' }
XMLAttributeDictionaryTest >> prefixedAttributeDictionary [
	^ (self dictionaryClass new setNamespaceScope: self namespaceScope)
		at: 'name' put: 'value';
		at: 'xml:id' put: 'id';
		at: 'prefix:name' put: 'prefixValue';
		at: 'otherPrefix:name' put: 'otherPrefixValue';
		yourself
]

{ #category : 'tests' }
XMLAttributeDictionaryTest >> testAsXMLAttributeDictionary [

	| dictionary |
	dictionary := self emptyDictionary.
	self
		assert: dictionary asXMLAttributeDictionary
		identicalTo: dictionary
]

{ #category : 'tests' }
XMLAttributeDictionaryTest >> testAssociationAtName [
	| dictionary |
	dictionary := self prefixedAttributeDictionary.
	self
		assert: (dictionary associationAtName: 'id')
		equals: 'xml:id' -> 'id'.
	self
		assert: (dictionary associationAtName: 'xml:id')
		equals: 'xml:id' -> 'id'.
	self
		assert: (dictionary associationAtName: 'name')
		equals: 'name' -> 'value'.
	self
		assert: (dictionary associationAtName: 'prefix:name')
		equals: 'prefix:name' -> 'prefixValue'.
	self
		assert: (dictionary associationAtName: 'otherPrefix:name')
		equals: 'otherPrefix:name' -> 'otherPrefixValue'.
	self assert: (dictionary associationAtName: self absentKey) isNil
]

{ #category : 'tests' }
XMLAttributeDictionaryTest >> testAssociationAtNameIfAbsent [
	| dictionary |
	dictionary := self prefixedAttributeDictionary.
	self
		assert: (dictionary associationAtName: 'id' ifAbsent: [ self fail ])
		equals: 'xml:id' -> 'id'.
	self
		assert: (dictionary associationAtName: 'xml:id' ifAbsent: [ self fail ])
		equals: 'xml:id' -> 'id'.
	self
		assert: (dictionary associationAtName: 'name' ifAbsent: [ self fail ])
		equals: 'name' -> 'value'.
	self
		assert: (dictionary associationAtName: 'prefix:name' ifAbsent: [ self fail ])
		equals: 'prefix:name' -> 'prefixValue'.
	self
		assert:
			(dictionary
				associationAtName: 'otherPrefix:name'
				ifAbsent: [ self fail ])
		equals: 'otherPrefix:name' -> 'otherPrefixValue'.
	self
		assert:
			(dictionary
				associationAtName: self absentKey
				ifAbsent: [ self absentValue ])
		equals: self absentValue
]

{ #category : 'tests' }
XMLAttributeDictionaryTest >> testAssociationAtNameNamespaceURI [
	| dictionary |
	dictionary := self prefixedAttributeDictionary.
	self
		assert:
			(dictionary
				associationAtName: 'id'
				namespaceURI: XMLNamespaceScope xmlNamespaceURI) isNil.
	self
		assert: (dictionary associationAtName: 'id' namespaceURI: 'defaultNS') isNil.
	self
		assert: (dictionary associationAtName: 'id' namespaceURI: '')
		equals: 'xml:id' -> 'id'.
	self
		assert:
			(dictionary
				associationAtName: 'xml:id'
				namespaceURI: XMLNamespaceScope xmlNamespaceURI) isNil.
	self
		assert:
			(dictionary associationAtName: 'xml:id' namespaceURI: 'defaultNS')
				isNil.
	self
		assert: (dictionary associationAtName: 'xml:id' namespaceURI: '')
		equals: 'xml:id' -> 'id'.
	self
		assert: (dictionary associationAtName: 'name' namespaceURI: 'prefixNS') isNil.
	self
		assert:
			(dictionary associationAtName: 'prefix:name' namespaceURI: 'prefixNS')
				isNil.
	self
		assert:
			(dictionary associationAtName: 'prefix:name' namespaceURI: 'defaultNS')
				isNil.
	self
		assert:
			(dictionary associationAtName: 'name' namespaceURI: 'otherPrefixNS')
				isNil.
	self
		assert:
			(dictionary
				associationAtName: 'otherPrefix:name'
				namespaceURI: 'otherPrefixNS') isNil.
	self
		assert:
			(dictionary
				associationAtName: 'otherPrefix:name'
				namespaceURI: 'defaultNS') isNil.
	self
		assert: (dictionary associationAtName: 'name' namespaceURI: '')
		equals: 'name' -> 'value'.
	self
		assert: (dictionary associationAtName: 'name' namespaceURI: 'defaultNS') isNil
]

{ #category : 'tests' }
XMLAttributeDictionaryTest >> testAssociationAtNameNamespaceURIIfAbsent [
	| dictionary |
	dictionary := self prefixedAttributeDictionary.
	self
		assert:
			(dictionary
				associationAtName: 'id'
				namespaceURI: XMLNamespaceScope xmlNamespaceURI
				ifAbsent: [ self absentValue ])
		equals: self absentValue.
	self
		assert:
			(dictionary
				associationAtName: 'id'
				namespaceURI: 'defaultNS'
				ifAbsent: [ self absentValue ])
		equals: self absentValue.
	self
		assert:
			(dictionary
				associationAtName: 'id'
				namespaceURI: ''
				ifAbsent: [ self fail ])
		equals: 'xml:id' -> 'id'.
	self
		assert:
			(dictionary
				associationAtName: 'xml:id'
				namespaceURI: XMLNamespaceScope xmlNamespaceURI
				ifAbsent: [ self absentValue ])
		equals: self absentValue.
	self
		assert:
			(dictionary
				associationAtName: 'xml:id'
				namespaceURI: 'defaultNS'
				ifAbsent: [ self absentValue ])
		equals: self absentValue.
	self
		assert:
			(dictionary
				associationAtName: 'xml:id'
				namespaceURI: ''
				ifAbsent: [ self fail ])
		equals: 'xml:id' -> 'id'.
	self
		assert:
			(dictionary
				associationAtName: 'name'
				namespaceURI: 'prefixNS'
				ifAbsent: [ self absentValue ])
		equals: self absentValue.
	self
		assert:
			(dictionary
				associationAtName: 'prefix:name'
				namespaceURI: 'prefixNS'
				ifAbsent: [ self absentValue ])
		equals: self absentValue.
	self
		assert:
			(dictionary
				associationAtName: 'prefix:name'
				namespaceURI: 'defaultNS'
				ifAbsent: [ self absentValue ])
		equals: self absentValue.
	self
		assert:
			(dictionary
				associationAtName: 'name'
				namespaceURI: 'otherPrefixNS'
				ifAbsent: [ self absentValue ])
		equals: self absentValue.
	self
		assert:
			(dictionary
				associationAtName: 'otherPrefix:name'
				namespaceURI: 'otherPrefixNS'
				ifAbsent: [ self absentValue ])
		equals: self absentValue.
	self
		assert:
			(dictionary
				associationAtName: 'otherPrefix:name'
				namespaceURI: 'defaultNS'
				ifAbsent: [ self absentValue ])
		equals: self absentValue.
	self
		assert:
			(dictionary
				associationAtName: 'name'
				namespaceURI: ''
				ifAbsent: [ self fail ])
		equals: 'name' -> 'value'.
	self
		assert:
			(dictionary
				associationAtName: 'name'
				namespaceURI: 'defaultNS'
				ifAbsent: [ self absentValue ])
		equals: self absentValue
]

{ #category : 'tests' }
XMLAttributeDictionaryTest >> testAtName [
	| dictionary |

	dictionary := self prefixedAttributeDictionary.
	self
		assert: (dictionary atName: 'id') equals: 'id';
		assert: (dictionary atName: 'xml:id') equals: 'id';
		assert: (dictionary atName: 'name') equals: 'value';
		assert: (dictionary atName: 'prefix:name') equals: 'prefixValue';
		assert: (dictionary atName: 'otherPrefix:name') equals: 'otherPrefixValue';
		assert: (dictionary atName: self absentKey) equals: ''
]

{ #category : 'tests' }
XMLAttributeDictionaryTest >> testAtNameIfAbsent [
	| dictionary |

	dictionary := self prefixedAttributeDictionary.
	self assert:
		(dictionary
			atName: 'id'
			ifAbsent: [self fail]) equals: 'id'.
	self assert:
		(dictionary
			atName: 'xml:id'
			ifAbsent: [self fail]) equals: 'id'.
	self assert:
		(dictionary
			atName: 'name'
			ifAbsent: [self fail]) equals: 'value'.
	self assert:
		(dictionary
			atName: 'prefix:name'
			ifAbsent: [self fail]) equals: 'prefixValue'.
	self assert:
		(dictionary
			atName: 'otherPrefix:name'
			ifAbsent: [self fail]) equals: 'otherPrefixValue'.
	self assert:
		(dictionary
			atName: self absentKey
			ifAbsent: [self absentValue]) equals: self absentValue
]

{ #category : 'tests' }
XMLAttributeDictionaryTest >> testAtNameNamespaceURI [
	| dictionary |

	dictionary := self prefixedAttributeDictionary.
	self assert:
		(dictionary
			atName: 'id'
			namespaceURI: XMLNamespaceScope xmlNamespaceURI) equals: ''.
	self assert:
		(dictionary
			atName: 'id'
			namespaceURI: 'defaultNS') equals: ''.
	self assert:
		(dictionary
			atName: 'id'
			namespaceURI: '') equals: 'id'.
	self assert:
		(dictionary
			atName: 'xml:id'
			namespaceURI: XMLNamespaceScope xmlNamespaceURI) equals: ''.
	self assert:
		(dictionary
			atName: 'xml:id'
			namespaceURI: 'defaultNS') equals: ''.
	self assert:
		(dictionary
			atName: 'xml:id'
			namespaceURI: '') equals: 'id'.

	self assert:
		(dictionary
			atName: 'name'
			namespaceURI: 'prefixNS') equals: ''.
	self assert:
		(dictionary
			atName: 'prefix:name'
			namespaceURI: 'prefixNS') equals: ''.
	self assert:
		(dictionary
			atName: 'prefix:name'
			namespaceURI: 'defaultNS') equals: ''.

	self assert:
		(dictionary
			atName: 'name'
			namespaceURI: 'otherPrefixNS') equals: ''.
	self assert:
		(dictionary
			atName: 'otherPrefix:name'
			namespaceURI: 'otherPrefixNS') equals: ''.
	self assert:
		(dictionary
			atName: 'otherPrefix:name'
			namespaceURI: 'defaultNS') equals: ''.

	self assert:
		(dictionary
			atName: 'name'
			namespaceURI: '') equals: 'value'.
	self assert:
		(dictionary
			atName: 'name'
			namespaceURI: 'defaultNS') equals: ''
]

{ #category : 'tests' }
XMLAttributeDictionaryTest >> testAtNameNamespaceURIIfAbsent [

	| dictionary |
	dictionary := self prefixedAttributeDictionary.
	self
		assert: (dictionary
				 atName: 'id'
				 namespaceURI: XMLNamespaceScope xmlNamespaceURI
				 ifAbsent: [ self absentValue ])
		equals: self absentValue.
	self
		assert: (dictionary
				 atName: 'id'
				 namespaceURI: 'defaultNS'
				 ifAbsent: [ self absentValue ])
		equals: self absentValue.
	self
		assert:
		(dictionary atName: 'id' namespaceURI: '' ifAbsent: [ self fail ])
		equals: 'id'.
	self
		assert: (dictionary
				 atName: 'xml:id'
				 namespaceURI: XMLNamespaceScope xmlNamespaceURI
				 ifAbsent: [ self absentValue ])
		equals: self absentValue.
	self
		assert: (dictionary
				 atName: 'xml:id'
				 namespaceURI: 'defaultNS'
				 ifAbsent: [ self absentValue ])
		equals: self absentValue.
	self
		assert:
		(dictionary
			 atName: 'xml:id'
			 namespaceURI: ''
			 ifAbsent: [ self fail ])
		equals: 'id'.

	self
		assert: (dictionary
				 atName: 'name'
				 namespaceURI: 'prefixNS'
				 ifAbsent: [ self absentValue ])
		equals: self absentValue.
	self
		assert: (dictionary
				 atName: 'prefix:name'
				 namespaceURI: 'prefixNS'
				 ifAbsent: [ self absentValue ])
		equals: self absentValue.
	self
		assert: (dictionary
				 atName: 'prefix:name'
				 namespaceURI: 'defaultNS'
				 ifAbsent: [ self absentValue ])
		equals: self absentValue.

	self
		assert: (dictionary
				 atName: 'name'
				 namespaceURI: 'otherPrefixNS'
				 ifAbsent: [ self absentValue ])
		equals: self absentValue.
	self
		assert: (dictionary
				 atName: 'otherPrefix:name'
				 namespaceURI: 'otherPrefixNS'
				 ifAbsent: [ self absentValue ])
		equals: self absentValue.
	self
		assert: (dictionary
				 atName: 'otherPrefix:name'
				 namespaceURI: 'defaultNS'
				 ifAbsent: [ self absentValue ])
		equals: self absentValue.
	self
		assert:
		(dictionary atName: 'name' namespaceURI: '' ifAbsent: [ self fail ])
		equals: 'value'.
	self
		assert: (dictionary
				 atName: 'name'
				 namespaceURI: 'defaultNS'
				 ifAbsent: [ self absentValue ])
		equals: self absentValue
]

{ #category : 'tests' }
XMLAttributeDictionaryTest >> testLazyDictionaryEmptyAttributeDictionary [

	self isTestingLazyDictionary ifFalse: [ ^ self ].
	self
		assert: self emptyDictionary attributeDictionary
		identicalTo: self dictionaryClass emptyAttributeDictionary.
	self assert: self dictionaryClass emptyAttributeDictionary isEmpty
]

{ #category : 'tests' }
XMLAttributeDictionaryTest >> testLazyDictionaryInterfaceCompatibility [
	| dictionary |

	self isTestingLazyDictionary
		ifFalse: [^ self].

	"protocols must be the same as the non-lazy dictionaries"
	dictionary := self emptyDictionary.
	XMLAttributeDictionary selectors do: [:each |
		self assert: (dictionary respondsTo: each)]
]

{ #category : 'tests' }
XMLAttributeDictionaryTest >> testNamespaceURIOf [
	| dictionary |

	dictionary := self prefixedAttributeDictionary.
	self
		assert: (dictionary namespaceURIOf: 'xml:id') equals: '';
		assert: (dictionary namespaceURIOf: 'prefix:name') equals: '';
		assert: (dictionary namespaceURIOf: 'otherPrefix:name') equals: '';
		assert: (dictionary namespaceURIOf: 'name') equals: ''
]

{ #category : 'tests' }
XMLAttributeDictionaryTest >> testUsesNamespaces [
	self deny: self emptyDictionary usesNamespaces
]
