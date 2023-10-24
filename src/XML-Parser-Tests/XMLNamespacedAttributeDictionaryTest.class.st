Class {
	#name : #XMLNamespacedAttributeDictionaryTest,
	#superclass : #XMLAttributeDictionaryTest,
	#category : #'XML-Parser-Tests-Base'
}

{ #category : #accessing }
XMLNamespacedAttributeDictionaryTest >> dictionaryClass [
	^ XMLNamespacedAttributeDictionary
]

{ #category : #tests }
XMLNamespacedAttributeDictionaryTest >> testAssociationAtNameNamespaceURI [
	| dictionary |

	dictionary := self prefixedAttributeDictionary.
	self assert:
		(dictionary
			associationAtName: 'id'
			namespaceURI: XMLNamespaceScope xmlNamespaceURI) equals: ('xml:id' -> 'id').
	self assert:
		(dictionary
			associationAtName: 'id'
			namespaceURI: 'defaultNS') isNil.
	self assert:
		(dictionary
			associationAtName: 'xml:id'
			namespaceURI: XMLNamespaceScope xmlNamespaceURI) equals: ('xml:id' -> 'id').
	self assert:
		(dictionary
			associationAtName: 'xml:id'
			namespaceURI: 'defaultNS') isNil.

	self assert:
		(dictionary
			associationAtName: 'name'
			namespaceURI: 'prefixNS') equals: ('prefix:name' -> 'prefixValue').
	self assert:
		(dictionary
			associationAtName: 'prefix:name'
			namespaceURI: 'prefixNS') equals: ('prefix:name' -> 'prefixValue').
	self assert:
		(dictionary
			associationAtName: 'prefix:name'
			namespaceURI: 'defaultNS') isNil.

	self assert:
		(dictionary
			associationAtName: 'name'
			namespaceURI: 'otherPrefixNS') equals: ('otherPrefix:name' -> 'otherPrefixValue').
	self assert:
		(dictionary
			associationAtName: 'otherPrefix:name'
			namespaceURI: 'otherPrefixNS') equals: ('otherPrefix:name' -> 'otherPrefixValue').
	self assert:
		(dictionary
			associationAtName: 'otherPrefix:name'
			namespaceURI: 'defaultNS') isNil.

	self assert:
		(dictionary
			associationAtName: 'name'
			namespaceURI: '') equals: ('name' -> 'value').
	self assert:
		(dictionary
			associationAtName: 'name'
			namespaceURI: 'defaultNS') isNil
]

{ #category : #tests }
XMLNamespacedAttributeDictionaryTest >> testAssociationAtNameNamespaceURIIfAbsent [
	| dictionary |

	dictionary := self prefixedAttributeDictionary.
	self assert:
		(dictionary
			associationAtName: 'id'
			namespaceURI: XMLNamespaceScope xmlNamespaceURI
			ifAbsent: [self fail]) equals: ('xml:id' -> 'id').
	self assert:
		(dictionary
			associationAtName: 'id'
			namespaceURI: 'defaultNS'
			ifAbsent: [#absent]) equals: #absent.
	self assert:
		(dictionary
			associationAtName: 'xml:id'
			namespaceURI: XMLNamespaceScope xmlNamespaceURI
			ifAbsent: [self fail]) equals: ('xml:id' -> 'id').
	self assert:
		(dictionary
			associationAtName: 'xml:id'
			namespaceURI: 'defaultNS'
			ifAbsent: [#absent]) equals: #absent.

	self assert:
		(dictionary
			associationAtName: 'name'
			namespaceURI: 'prefixNS'
			ifAbsent: [self fail]) equals: ('prefix:name' -> 'prefixValue').
	self assert:
		(dictionary
			associationAtName: 'prefix:name'
			namespaceURI: 'prefixNS'
			ifAbsent: [self fail]) equals: ('prefix:name' -> 'prefixValue').
	self assert:
		(dictionary
			associationAtName: 'prefix:name'
			namespaceURI: 'defaultNS'
			ifAbsent: [#absent]) equals: #absent.

	self assert:
		(dictionary
			associationAtName: 'name'
			namespaceURI: 'otherPrefixNS'
			ifAbsent: [self fail]) equals: ('otherPrefix:name' -> 'otherPrefixValue').
	self assert:
		(dictionary
			associationAtName: 'otherPrefix:name'
			namespaceURI: 'otherPrefixNS'
			ifAbsent: [self fail]) equals: ('otherPrefix:name' -> 'otherPrefixValue').
	self assert:
		(dictionary
			associationAtName: 'otherPrefix:name'
			namespaceURI: 'defaultNS'
			ifAbsent: [#absent]) equals: #absent.

	self assert:
		(dictionary
			associationAtName: 'name'
			namespaceURI: ''
			ifAbsent: [self fail]) equals: ('name' -> 'value').
	self assert:
		(dictionary
			associationAtName: 'name'
			namespaceURI: 'defaultNS'
			ifAbsent: [#absent]) equals: #absent
]

{ #category : #tests }
XMLNamespacedAttributeDictionaryTest >> testAtNameNamespaceURI [

	| dictionary |
	dictionary := self prefixedAttributeDictionary.
	self
		assert: (dictionary
				 atName: 'id'
				 namespaceURI: XMLNamespaceScope xmlNamespaceURI)
		equals: 'id'.
	self
		assert: (dictionary atName: 'id' namespaceURI: 'defaultNS')
		equals: ''.
	self
		assert: (dictionary
				 atName: 'xml:id'
				 namespaceURI: XMLNamespaceScope xmlNamespaceURI)
		equals: 'id'.
	self
		assert: (dictionary atName: 'xml:id' namespaceURI: 'defaultNS')
		equals: ''.

	self
		assert: (dictionary atName: 'name' namespaceURI: 'prefixNS')
		equals: 'prefixValue'.
	self
		assert: (dictionary atName: 'prefix:name' namespaceURI: 'prefixNS')
		equals: 'prefixValue'.
	self
		assert: (dictionary atName: 'prefix:name' namespaceURI: 'defaultNS')
		equals: ''.

	self
		assert: (dictionary atName: 'name' namespaceURI: 'otherPrefixNS')
		equals: 'otherPrefixValue'.
	self
		assert:
		(dictionary atName: 'otherPrefix:name' namespaceURI: 'otherPrefixNS')
		equals: 'otherPrefixValue'.
	self
		assert:
		(dictionary atName: 'otherPrefix:name' namespaceURI: 'defaultNS')
		equals: ''.

	self
		assert: (dictionary atName: 'name' namespaceURI: '')
		equals: 'value'.
	self
		assert: (dictionary atName: 'name' namespaceURI: 'defaultNS')
		equals: ''
]

{ #category : #tests }
XMLNamespacedAttributeDictionaryTest >> testAtNameNamespaceURIIfAbsent [
	| dictionary |

	dictionary := self prefixedAttributeDictionary.
	self assert:
		(dictionary
			atName: 'id'
			namespaceURI: XMLNamespaceScope xmlNamespaceURI
			ifAbsent: [self fail]) equals: 'id'.
	self assert:
		(dictionary
			atName: 'id'
			namespaceURI: 'defaultNS'
			ifAbsent: ['absent']) equals: 'absent'.
	self assert:
		(dictionary
			atName: 'xml:id'
			namespaceURI: XMLNamespaceScope xmlNamespaceURI
			ifAbsent: [self fail]) equals: 'id'.
	self assert:
		(dictionary
			atName: 'xml:id'
			namespaceURI: 'defaultNS'
			ifAbsent: ['absent']) equals: 'absent'.

	self assert:
		(dictionary
			atName: 'name'
			namespaceURI: 'prefixNS'
			ifAbsent: [self fail]) equals: 'prefixValue'.
	self assert:
		(dictionary
			atName: 'prefix:name'
			namespaceURI: 'prefixNS'
			ifAbsent: [self fail]) equals: 'prefixValue'.
	self assert:
		(dictionary
			atName: 'prefix:name'
			namespaceURI: 'defaultNS'
			ifAbsent: ['absent']) equals: 'absent'.

	self assert:
		(dictionary
			atName: 'name'
			namespaceURI: 'otherPrefixNS'
			ifAbsent: [self fail]) equals: 'otherPrefixValue'.
	self assert:
		(dictionary
			atName: 'otherPrefix:name'
			namespaceURI: 'otherPrefixNS'
			ifAbsent: [self fail]) equals: 'otherPrefixValue'.
	self assert:
		(dictionary
			atName: 'otherPrefix:name'
			namespaceURI: 'defaultNS'
			ifAbsent: ['absent']) equals: 'absent'.

	self assert:
		(dictionary
			atName: 'name'
			namespaceURI: ''
			ifAbsent: [self fail]) equals: 'value'.
	self assert:
		(dictionary
			atName: 'name'
			namespaceURI: 'defaultNS'
			ifAbsent: ['absent']) equals: 'absent'
]

{ #category : #tests }
XMLNamespacedAttributeDictionaryTest >> testCopy [

	| dictionary copy |
	super testCopy.
	dictionary := self prefixedAttributeDictionary.
	copy := dictionary copy.
	self
		assert: dictionary namespaceScope
		identicalTo: copy namespaceScope
]

{ #category : #tests }
XMLNamespacedAttributeDictionaryTest >> testNamespaceURIOf [
	| dictionary |

	dictionary := self prefixedAttributeDictionary.
	self assert:
		(dictionary namespaceURIOf: 'xml:id') equals:
			XMLNamespaceScope xmlNamespaceURI.
	self
		assert: (dictionary namespaceURIOf: 'prefix:name') equals: 'prefixNS';
		assert: (dictionary namespaceURIOf: 'otherPrefix:name') equals: 'otherPrefixNS';
		assert: (dictionary namespaceURIOf: 'name') equals: ''
]

{ #category : #tests }
XMLNamespacedAttributeDictionaryTest >> testUsesNamespaces [
	self assert: self emptyDictionary usesNamespaces
]
