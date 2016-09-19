Class {
	#name : #XMLAttributeListTest,
	#superclass : #XMLObservableListTest,
	#instVars : [
		'attributes',
		'newAttribute',
		'absentAttribute',
		'changedAttributes',
		'prefixedAttribute'
	],
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #accessing }
XMLAttributeListTest >> absentListItem [
	^ absentAttribute
		ifNil: [
			absentAttribute :=
				self attributeClass
					name: 'absentName'
					value: 'absentValue']
]

{ #category : #accessing }
XMLAttributeListTest >> afterAddingToNotifications [
	^ #(addedAttribute:)
]

{ #category : #accessing }
XMLAttributeListTest >> afterRemovingFromNotifications [
	^ #(removedAttribute:)
]

{ #category : #testing }
XMLAttributeListTest >> allowsDuplicates [
	^ false
]

{ #category : #accessing }
XMLAttributeListTest >> attributeAssociations [
	^ self listItems collect: [:each | each name -> each value]
]

{ #category : #accessing }
XMLAttributeListTest >> attributeClass [
	^ XMLAttribute
]

{ #category : #accessing }
XMLAttributeListTest >> attributeNames [
	^ self listItems collect: [:each | each name]
]

{ #category : #accessing }
XMLAttributeListTest >> attributeValues [
	^ self listItems collect: [:each | each value]
]

{ #category : #accessing }
XMLAttributeListTest >> attributesClass [
	^ OrderPreservingStringDictionary
]

{ #category : #accessing }
XMLAttributeListTest >> changedListItem: anAttribute [
	^ (changedAttributes ifNil: [changedAttributes := IdentityDictionary new])
		at: anAttribute
		ifAbsentPut: [
			self attributeClass
				name: 'new', anAttribute name
				value: 'new', anAttribute value]
]

{ #category : #accessing }
XMLAttributeListTest >> listClass [
	^ XMLAttributeList
]

{ #category : #accessing }
XMLAttributeListTest >> listItems [
	attributes ifNil: [
		attributes :=
			super listItems collect: [:each |
				self attributeClass
					name: each
					value: each]].
	^ attributes copy.
]

{ #category : #accessing }
XMLAttributeListTest >> newListItem [
	^ newAttribute
		ifNil: [
			newAttribute :=
				self attributeClass
					name: 'newName'
					value: 'newValue']
]

{ #category : #accessing }
XMLAttributeListTest >> observerClass [
	^ XMLRecordingAttributeListObserver
]

{ #category : #accessing }
XMLAttributeListTest >> prefixedAttribute [
	^ prefixedAttribute
		ifNil: [prefixedAttribute := self newListItem copy prefix: 'prefix']
]

{ #category : #accessing }
XMLAttributeListTest >> reverseSortBlock [
	^ [:a :b | a sortKey > b sortKey]
]

{ #category : #accessing }
XMLAttributeListTest >> sortBlock [
	^ [:a :b | a sortKey <= b sortKey]
]

{ #category : #tests }
XMLAttributeListTest >> testAddAttributeAssociation [
	| list |

	list := self emptyList.
	self listItems do: [:each | | attribute |
		self assert: (list attributeNodeAt: each name) = self defaultValue.
		attribute := list addAttributeAssociation: each name -> each value.
		self
			assert: attribute class == self attributeClass;
			assert: attribute name = each name;
			assert: attribute value = each value;
			assert: (list attributeNodeAt: each name) = attribute].
]

{ #category : #tests }
XMLAttributeListTest >> testAddAttributeNameValue [
	| list |

	list := self emptyList.
	self listItems do: [:each | | attribute |
		self assert: (list attributeNodeAt: each name)  = self defaultValue.
		attribute :=
			list
				addAttributeName: each name
				value: each value.
		self
			assert: attribute class == self attributeClass;
			assert: attribute name = each name;
			assert: attribute value = each value;
			assert: (list attributeNodeAt: each name) = attribute].
]

{ #category : #tests }
XMLAttributeListTest >> testAsDictionary [
	| list dictionary |

	list := self listWithItems.
	dictionary := list asDictionary.
	self
		assert: dictionary class == self attributesClass;
		assert:
			dictionary =
				(self attributesClass newFrom: self attributeAssociations).
]

{ #category : #tests }
XMLAttributeListTest >> testAttributeAssociations [
	| list |

	list := self listWithItems.
	self
		assertList: list attributeAssociations
		collectedFrom: list
		equals: (self listSpecies newFrom: self attributeAssociations).
]

{ #category : #tests }
XMLAttributeListTest >> testAttributeAt [
	| list |

	list := self emptyList.
	self listItems do: [:each |
		self assert: (list attributeAt: each name) = ''.
	
		list add: each.
		self assert: (list attributeAt: each name) = each value].

	self
		assert: (list attributeAt: self prefixedAttribute name) = '';
		assert: (list attributeAt: self prefixedAttribute localName) = ''.

	list add: self prefixedAttribute.
	self assert:
		(list attributeAt: self prefixedAttribute name) =
			self prefixedAttribute value.
	self assert:
		(list attributeAt: self prefixedAttribute localName) =
			''.
]

{ #category : #tests }
XMLAttributeListTest >> testAttributeAtIfAbsent [
	| list |

	list := self emptyList.
	self listItems do: [:each |
		self assert:
			(list
				attributeAt: each name
				ifAbsent: [self absentListItem value]) = self absentListItem value.
	
		list add: each.
		self assert:
			(list
				attributeAt: each name
				ifAbsent: [self fail]) = each value].

	self assert:
		(list
			attributeAt: self prefixedAttribute name
			ifAbsent: [self absentListItem value]) = self absentListItem value.
	self assert:
		(list
			attributeAt: self prefixedAttribute localName
			ifAbsent: [self absentListItem value]) = self absentListItem value.

	list add: self prefixedAttribute.
	self assert:
		(list
			attributeAt: self prefixedAttribute name
			ifAbsent: [self fail]) = self prefixedAttribute value.
	self assert:
		(list
			attributeAt: self prefixedAttribute localName
			ifAbsent: [self absentListItem value]) = self absentListItem value.
]

{ #category : #tests }
XMLAttributeListTest >> testAttributeAtIfAbsentPut [
	| list |

	list := self emptyList.
	self listItems do: [:each |
		self assert:
			(list
				attributeAt: each name
				ifAbsentPut: [each value]) = each value.
		self assert: (list attributeAt: each name) = each value.

		self assert:
			(list
				attributeAt: each name
				ifAbsentPut: [self fail]) = each value.
		self assert: (list attributeAt: each name) = each value].

	self assert:
		(list
			attributeAt: self prefixedAttribute name
			ifAbsentPut: [self prefixedAttribute value]) = self prefixedAttribute value.
	self assert:
		(list
			attributeAt: self prefixedAttribute localName
			ifAbsentPut: [self newListItem value]) = self newListItem value.
	self assert:
		(list attributeAt: self prefixedAttribute name) =
			self prefixedAttribute value.
	self assert:
		(list attributeAt: self prefixedAttribute localName) =
			self newListItem value.

	self assert:
		(list
			attributeAt: self prefixedAttribute name
			ifAbsentPut: [self fail]) = self prefixedAttribute value.
	self assert:
		(list
			attributeAt: self prefixedAttribute localName
			ifAbsentPut: [self fail]) = self newListItem value.
	self assert:
		(list attributeAt: self prefixedAttribute name) =
			self prefixedAttribute value.
	self assert:
		(list attributeAt: self prefixedAttribute localName) =
			self newListItem value.
]

{ #category : #tests }
XMLAttributeListTest >> testAttributeAtPut [
	| list |

	list := self emptyList.
	self listItems do: [:each |
		self assert:
			(list
				attributeAt: each name
				put: each value) = each value.
		self assert: (list attributeAt: each name) = each value].

	self assert:
		(list
			attributeAt: self prefixedAttribute name
			put: self prefixedAttribute value) = self prefixedAttribute value.
	self assert:
		(list
			attributeAt: self prefixedAttribute localName
			put: self newListItem value) = self newListItem value.
	self assert:
		(list attributeAt: self prefixedAttribute name) =
			self prefixedAttribute value.
	self assert:
		(list attributeAt: self prefixedAttribute localName) =
			self newListItem value.
]

{ #category : #tests }
XMLAttributeListTest >> testAttributeNames [
	| list |

	list := self listWithItems.
	self
		assertList: list attributeNames
		collectedFrom: list
		equals: (self listSpecies newFrom: self attributeNames).
]

{ #category : #tests }
XMLAttributeListTest >> testAttributeNamesAndValuesDo [
	| list |

	list := self emptyList.
	self
		should: [:twoArgumentBlock |
			list attributeNamesAndValuesDo: twoArgumentBlock]
		enumerate: #()
		and: #().

	list := self listWithItems.
	self
		should: [:twoArgumentBlock |
			list attributeNamesAndValuesDo: twoArgumentBlock]
		enumerate: self attributeNames
		and: self attributeValues.
]

{ #category : #tests }
XMLAttributeListTest >> testAttributeNamesDo [
	| list |

	list := self emptyList.
	self
		should: [:block | list attributeNamesDo: block]
		enumerate: #().

	list := self listWithItems.
	self
		should: [:each | list attributeNamesDo: each]
		enumerate: self attributeNames.
]

{ #category : #tests }
XMLAttributeListTest >> testAttributeNodeAt [
	| list |

	list := self emptyList.
	self listItems do: [:each |
		self assert: (list attributeNodeAt: each name) = self defaultValue.
	
		list add: each.
		self assert: (list attributeNodeAt: each name) = each].

	self
		assert: (list attributeNodeAt: self prefixedAttribute name) = self defaultValue;
		assert: (list attributeNodeAt: self prefixedAttribute localName) = self defaultValue.

	list add: self prefixedAttribute.
	self
		assert: (list attributeNodeAt: self prefixedAttribute name) = self prefixedAttribute;
		assert: (list attributeNodeAt: self prefixedAttribute localName) = self prefixedAttribute.
]

{ #category : #tests }
XMLAttributeListTest >> testAttributeNodeAtIfAbsent [
	| list |

	list := self emptyList.
	self listItems do: [:each |
		self assert:
			(list
				attributeNodeAt: each name
				ifAbsent: [self absentListItem]) = self absentListItem.
	
		list add: each.
		self assert:
			(list
				attributeNodeAt: each name
				ifAbsent: [self fail]) = each].

	self assert:
		(list
			attributeNodeAt: self prefixedAttribute name
			ifAbsent: [self absentListItem]) = self absentListItem.
	self assert:
		(list
			attributeNodeAt: self prefixedAttribute localName
			ifAbsent: [self absentListItem]) = self absentListItem.

	list add: self prefixedAttribute.
	self assert:
		(list
			attributeNodeAt: self prefixedAttribute name
			ifAbsent: [self fail]) = self prefixedAttribute.
	self assert:
		(list
			attributeNodeAt: self prefixedAttribute localName
			ifAbsent: [self fail]) = self prefixedAttribute.
]

{ #category : #tests }
XMLAttributeListTest >> testAttributeValueAt [
	| list |

	list := self emptyList.
	self listItems do: [:each |
		self assert: (list attributeValueAt: each name) = ''.
	
		list add: each.
		self assert: (list attributeValueAt: each name) = each value].

	self
		assert: (list attributeValueAt: self prefixedAttribute name) = '';
		assert: (list attributeValueAt: self prefixedAttribute localName) = ''.

	list add: self prefixedAttribute.
	self assert:
		(list attributeValueAt: self prefixedAttribute name) =
			self prefixedAttribute value.
	self assert:
		(list attributeValueAt: self prefixedAttribute localName) =
			''.
]

{ #category : #tests }
XMLAttributeListTest >> testAttributeValueAtIfAbsent [
	| list |

	list := self emptyList.
	self listItems do: [:each |
		self assert:
			(list
				attributeValueAt: each name
				ifAbsent: [self absentListItem value]) = self absentListItem value.
	
		list add: each.
		self assert:
			(list
				attributeValueAt: each name
				ifAbsent: [self fail]) = each value].

	self assert:
		(list
			attributeValueAt: self prefixedAttribute name
			ifAbsent: [self absentListItem value]) = self absentListItem value.
	self assert:
		(list
			attributeValueAt: self prefixedAttribute localName
			ifAbsent: [self absentListItem value]) = self absentListItem value.

	list add: self prefixedAttribute.
	self assert:
		(list
			attributeValueAt: self prefixedAttribute name
			ifAbsent: [self fail]) = self prefixedAttribute value.
	self assert:
		(list
			attributeValueAt: self prefixedAttribute localName
			ifAbsent: [self absentListItem value]) = self absentListItem value.
]

{ #category : #tests }
XMLAttributeListTest >> testAttributeValueAtIfAbsentPut [
	| list |

	list := self emptyList.
	self listItems do: [:each |
		self assert:
			(list
				attributeValueAt: each name
				ifAbsentPut: [each value]) = each value.
		self assert: (list attributeValueAt: each name) = each value.

		self assert:
			(list
				attributeValueAt: each name
				ifAbsentPut: [self fail]) = each value.
		self assert: (list attributeValueAt: each name) = each value].

	self assert:
		(list
			attributeValueAt: self prefixedAttribute name
			ifAbsentPut: [self prefixedAttribute value]) = self prefixedAttribute value.
	self assert:
		(list
			attributeValueAt: self prefixedAttribute localName
			ifAbsentPut: [self newListItem value]) = self newListItem value.
	self assert:
		(list attributeValueAt: self prefixedAttribute name) =
			self prefixedAttribute value.
	self assert:
		(list attributeValueAt: self prefixedAttribute localName) =
			self newListItem value.

	self assert:
		(list
			attributeValueAt: self prefixedAttribute name
			ifAbsentPut: [self fail]) = self prefixedAttribute value.
	self assert:
		(list
			attributeValueAt: self prefixedAttribute localName
			ifAbsentPut: [self fail]) = self newListItem value.
	self assert:
		(list attributeValueAt: self prefixedAttribute name) =
			self prefixedAttribute value.
	self assert:
		(list attributeValueAt: self prefixedAttribute localName) =
			self newListItem value.
]

{ #category : #tests }
XMLAttributeListTest >> testAttributeValueAtPut [
	| list |

	list := self emptyList.
	self listItems do: [:each |
		self assert:
			(list
				attributeValueAt: each name
				put: each value) = each value.
		self assert: (list attributeValueAt: each name) = each value].

	self assert:
		(list
			attributeValueAt: self prefixedAttribute name
			put: self prefixedAttribute value) = self prefixedAttribute value.
	self assert:
		(list
			attributeValueAt: self prefixedAttribute localName
			put: self newListItem value) = self newListItem value.
	self assert:
		(list attributeValueAt: self prefixedAttribute name) =
			self prefixedAttribute value.
	self assert:
		(list attributeValueAt: self prefixedAttribute localName) =
			self newListItem value.
]

{ #category : #tests }
XMLAttributeListTest >> testAttributes [
	| list dictionary |

	list := self listWithItems.
	dictionary := list attributes.
	self
		assert: dictionary class == self attributesClass;
		assert:
			dictionary =
				(self attributesClass newFrom: self attributeAssociations).
]

{ #category : #tests }
XMLAttributeListTest >> testIncludesAttribute [
	| list |

	list := self emptyList.
	self listItems do: [:each |
		self deny: (list includesAttribute: each name).

		list add: each.
		self assert: (list includesAttribute: each name)].

	self
		deny: (list includesAttribute: self prefixedAttribute name);
		deny: (list includesAttribute: self prefixedAttribute localName).

	list add: self prefixedAttribute.
	self
		assert: (list includesAttribute: self prefixedAttribute name);
		deny: (list includesAttribute: self prefixedAttribute localName).
]

{ #category : #tests }
XMLAttributeListTest >> testIncludesAttributeNode [
	| list |

	list := self emptyList.
	self listItems do: [:each |
		self deny: (list includesAttributeNode: each name).

		list add: each.
		self assert: (list includesAttributeNode: each name)].

	self
		deny: (list includesAttributeNode: self prefixedAttribute name);
		deny: (list includesAttributeNode: self prefixedAttribute localName).

	list add: self prefixedAttribute.
	self
		assert: (list includesAttributeNode: self prefixedAttribute name);
		assert: (list includesAttributeNode: self prefixedAttribute localName).
]

{ #category : #tests }
XMLAttributeListTest >> testIncludesAttributeNodeNamespaceURI [
	| list |

	list := self emptyList.
	self listItems do: [:each |
		self deny:
			(list
				includesAttributeNode: each name
				namespaceURI: 'defaultNS').

		list add: each.
		self deny:
			(list
				includesAttributeNode: each name
				namespaceURI: 'defaultNS').
		self assert:
			(list
				includesAttributeNode: each name
				namespaceURI: '')].

	self deny:
		(list
			includesAttributeNode: self prefixedAttribute name
			namespaceURI: 'defaultNS').
	self deny:
		(list
			includesAttributeNode: self prefixedAttribute localName
			namespaceURI: 'defaultNS').
	self deny:
		(list
			includesAttributeNode: self prefixedAttribute name
			namespaceURI: '').
	self deny:
		(list
			includesAttributeNode: self prefixedAttribute localName
			namespaceURI: '').

	list add: self prefixedAttribute.
	self deny:
		(list
			includesAttributeNode: self prefixedAttribute name
			namespaceURI: 'defaultNS').
	self deny:
		(list
			includesAttributeNode: self prefixedAttribute localName
			namespaceURI: 'defaultNS').
	self assert:
		(list
			includesAttributeNode: self prefixedAttribute name
			namespaceURI: '').
	self assert:
		(list
			includesAttributeNode: self prefixedAttribute localName
			namespaceURI: '').
]

{ #category : #tests }
XMLAttributeListTest >> testRemoveAttribute [
	| list |

	list := self listWithItems.
	self listItems do: [:each |
		self
			assert: (list removeAttribute: each name) = each value;
			deny: (list includes: each).
	
		self
			should: [list removeAttribute: each name]
			raise: Error].

	list add: self prefixedAttribute.
	self
		should: [list removeAttribute: self prefixedAttribute localName]
		raise: Error.
	self assert: (list includes: self prefixedAttribute).
	self assert:
		(list removeAttribute: self prefixedAttribute name) =
			self prefixedAttribute value.
	self deny: (list includes: self prefixedAttribute).
]

{ #category : #tests }
XMLAttributeListTest >> testRemoveAttributeIfAbsent [
	| list |

	list := self listWithItems.
	self listItems do: [:each |
		self assert:
			(list
				removeAttribute: each name
				ifAbsent: [self fail]) = each value.
		self deny: (list includes: each).
	
		self assert:
			(list
				removeAttribute: each name
				ifAbsent: [self absentListItem value]) = self absentListItem value].

	list add: self prefixedAttribute.
	self assert:
		(list
			removeAttribute: self prefixedAttribute localName
			ifAbsent: [self absentListItem value]) = self absentListItem value.
	self assert: (list includes: self prefixedAttribute).
	self assert:
		(list
			removeAttribute: self prefixedAttribute name
			ifAbsent: [self fail]) = self prefixedAttribute value.
	self deny: (list includes: self prefixedAttribute).
]

{ #category : #tests }
XMLAttributeListTest >> testSetAttributes [
	| list associations |

	list := self emptyList.
	associations := self attributeAssociations.
	self
		assert: (list setAttributes: associations) == list;
		assert: list attributeAssociations asArray = associations asArray.

	associations :=
		self changedListItems collect: [:each | each name -> each value].
	self
		assert: (list setAttributes: associations) == list;
		assert: list attributeAssociations asArray = associations asArray.
]

{ #category : #tests }
XMLAttributeListTest >> testSetAttributesFromOrderPreservingDictionary [
	| element list dictionary |

	element := XMLElement new.
	list := self listClass observer: element.
	dictionary := OrderPreservingDictionary newFrom: self attributeAssociations.
	self assert:
		(list setAttributesFromOrderPreservingDictionary: dictionary) == list.
	self assert:
		list attributeAssociations asArray =
			self attributeAssociations asArray.
	list do: [:each |
		self
			assert: each class == self attributeClass;
			assert: each parent == element;
			assert: each element == element]
]
