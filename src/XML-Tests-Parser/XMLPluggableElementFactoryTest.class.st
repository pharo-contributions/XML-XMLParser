Class {
	#name : #XMLPluggableElementFactoryTest,
	#superclass : #XMLPluggableNodeFactoryTest,
	#category : #'XML-Tests-Parser-DOM-Factories'
}

{ #category : #accessing }
XMLPluggableElementFactoryTest >> dateElementClass [
	^ XMLFDateElement
]

{ #category : #accessing }
XMLPluggableElementFactoryTest >> defaultElementClass [
	^ self elementClass
]

{ #category : #accessing }
XMLPluggableElementFactoryTest >> factoryClass [
	^ XMLPluggableElementFactory
]

{ #category : #accessing }
XMLPluggableElementFactoryTest >> realNameElementClass [
	^ XMLFRealNameElement
]

{ #category : #accessing }
XMLPluggableElementFactoryTest >> serializationFormatElementClass [
	^ XMLFSerializationFormatElement
]

{ #category : #accessing }
XMLPluggableElementFactoryTest >> tableElementClass [
	^ XMLFTableElement
]

{ #category : #tests }
XMLPluggableElementFactoryTest >> testAddElementNamed [
	| element userElement dataElement |

	element := XMLElement name: 'root'.
	element
		defaultNamespace: 'dataNS';
		declarePrefix: 'prefix' uri: 'prefixNS'.
	element nodeFactory:
		(XMLPluggableElementFactory new
			handleElement: 'data'
			namespaceURI: 'dataNS'
			withClass: XMLFElement;
			handleElement: 'user'
			namespaceURI: 'prefixNS'
			withClass: XMLFUserElement).

	userElement := element addElementNamed: 'prefix:user'.
	self
		assert: userElement class == XMLFUserElement;
		assert: (userElement isNamed: 'prefix:user');
		assert: userElement namespaceURI = 'prefixNS'.

	dataElement := element addElementNamed: 'data'.
	self
		assert: dataElement class == XMLFElement;
		assert: (dataElement isNamed: 'data');
		assert: dataElement namespaceURI = 'dataNS'.

	self assert: (element addElementNamed: 'default') class == XMLElement.
]

{ #category : #tests }
XMLPluggableElementFactoryTest >> testClassForElement [
	| factory |

	(factory := self newFactoryWithClasses)
		handleElement: 'user'
		withClass: self userElementClass.
	self
		assert: (factory classForElement: 'user') == self userElementClass;
		assert: (factory classForElement: 'prefix:user') == self userElementClass;
		assert: (factory classForElement: 'absent') == self elementClass.

	factory
		handleElement: 'prefix:user'
		withClass: self usernameElementClass.
	self
		assert: (factory classForElement: 'user') == self userElementClass;
		assert: (factory classForElement: 'prefix:user') == self usernameElementClass;
		assert: (factory classForElement: 'prefix:absent') == self elementClass.
]

{ #category : #tests }
XMLPluggableElementFactoryTest >> testClassForElementNamespaceURI [
	| factory |

	(factory := self newFactoryWithClasses)
		handleElement: 'user'
		namespaceURI: 'userNS'
		withClass: self userElementClass.
	self assert:
		(factory
			classForElement: 'user'
			namespaceURI: 'userNS') == self userElementClass.
	self assert:
		(factory
			classForElement: 'prefix:user'
			namespaceURI: 'userNS') == self userElementClass.
	self assert:
		(factory
			classForElement: 'user'
			namespaceURI: 'absentNS') == self elementClass.

	factory
		handleElement: 'prefix:user'
		namespaceURI: 'userNS'
		withClass: self usernameElementClass.
	self assert:
		(factory
			classForElement: 'user'
			namespaceURI: 'userNS') == self userElementClass.
	self assert:
		(factory
			classForElement: 'prefix:user'
			namespaceURI: 'userNS') == self usernameElementClass.
	self assert:
		(factory
			classForElement: 'prefix:user'
			namespaceURI: 'absentNS') == self elementClass.
]

{ #category : #tests }
XMLPluggableElementFactoryTest >> testCopy [
	| factory copy |

	factory := self newFactoryWithClasses.
	factory handleElement: 'user' withClass: XMLFUserElement.
	copy := factory copy.
	self
		deny: copy == factory;
		deny: copy elementClassMapper == factory elementClassMapper.
]

{ #category : #tests }
XMLPluggableElementFactoryTest >> testElementClassAccessor [
	| document |

	document :=
		(XMLDOMParser on: self sampleUserXML)
			nodeFactory: XMLPluggableElementFactory new;
			parseDocument.
	self assert: (document allElementsDetect: [:each | (each isMemberOf: XMLElement) not]) isNil.

	document :=
		(XMLDOMParser on: self sampleUserXML)
			nodeFactory: (XMLPluggableElementFactory new elementClass: self defaultElementClass);
			parseDocument.
	self assert: (document allElementsDetect: [:each | (each isMemberOf: self defaultElementClass) not]) isNil.
]

{ #category : #tests }
XMLPluggableElementFactoryTest >> testElementClassMapper [
	| factory newMapper |

	factory := self newFactoryWithClasses.
	self assert: (factory elementClassMapper isKindOf: XMLElementClassMapper).

	newMapper := XMLSimpleElementClassMapper.
	self
		assert: (factory elementClassMapper: newMapper) == factory;
		assert: factory elementClassMapper == newMapper.
]

{ #category : #tests }
XMLPluggableElementFactoryTest >> testElementClassNameMatching [
	| document |

	document :=
		(XMLDOMParser on: self sampleUserXML)
			nodeFactory:
				(self newFactoryWithClasses
					handleElementsMatchingClass: self userElementClass;
					handleElementsMatchingClasses:
						(Array
							with: self realNameElementClass
							with: self serializationFormatElementClass));
			parseDocument.

	self
		assert: ((document root) isMemberOf: self userElementClass);
		assert: ((document root elementAt: 'real-name') isMemberOf: self realNameElementClass);
		assert:
			((document root elementAt: 'serializationFormat')
				isMemberOf: self serializationFormatElementClass).
]

{ #category : #tests }
XMLPluggableElementFactoryTest >> testElementNameAndNamespaceMatching [
	| factory document root |

	(factory := self newFactoryWithClasses)
		elementClass: self defaultElementClass;
		handleElement: 'user:user' namespaceURI: 'urn:user' withClass: self userElementClass;
		handleElement: 'user:user' withClass: self wrongElementClass;
		handleElement: 'user' namespaceURI: 'urn:user' withClass: self wrongElementClass;
		handleElement: 'user' withClass: self wrongElementClass;
		handleElement: 'user:username' withClass: self usernameElementClass;
		handleElement: 'username' namespaceURI: 'urn:user' withClass: self wrongElementClass;
		handleElement: 'username' withClass: self wrongElementClass;
		handleElement: 'real-name' namespaceURI: 'urn:user' withClass: self realNameElementClass;
		handleElement: 'real-name' withClass: self wrongElementClass;
		handleElement: 'date-registered' withClass: self dateElementClass;
		handleElement: 'user:date-last-active' namespaceURI: 'urn:notuser' withClass: self wrongElementClass;
		handleElement: 'notuser:date-last-active' namespaceURI: 'urn:user' withClass: self wrongElementClass;
		handleElement: 'date-last-active' namespaceURI: 'urn:notuser' withClass: self wrongElementClass;
		handleElement: 'notuser:date-last-active' withClass: self wrongElementClass.

	document :=
		(XMLDOMParser on: self sampleUserXML)
			nodeFactory: factory;
			parseDocument.
	self
		assert: ((root := document root) isMemberOf: self userElementClass);
		assert: ((root elementAt: 'username') isMemberOf: self usernameElementClass);
		assert: ((root elementAt: 'real-name') isMemberOf: self realNameElementClass);
		assert: ((root elementAt: 'date-registered') isMemberOf: self dateElementClass);
		assert:
			((root elements copyAfter: (root elementAt: 'date-registered'))
				allSatisfy: [:each | each isMemberOf: self defaultElementClass]).
]

{ #category : #tests }
XMLPluggableElementFactoryTest >> testElementsNameAndNamespaceMatching [
	| factory document root |

	factory := self newFactoryWithClasses.
	factory
		handleElements: #('date-registered' 'date-last-active')
		namespaceURI: 'urn:user'
		withClass: self dateElementClass.
	factory
		handleElements: #('date-registered' 'date-last-active')
		withClass: self wrongElementClass.
	factory
		handleElements: #('table-name' 'not-table-name')
		withClass: self tableElementClass.

	document :=
		(XMLDOMParser on: self sampleUserXML)
			nodeFactory: factory;
			parseDocument.
	root := document root.
	self
		assert: ((root elementAt: 'date-registered') isMemberOf: self dateElementClass);
		assert: ((root elementAt: 'date-last-active') isMemberOf: self dateElementClass);
		assert: ((root elementAt: 'table-name') isMemberOf: self tableElementClass).
]

{ #category : #accessing }
XMLPluggableElementFactoryTest >> userElementClass [
	^ XMLFUserElement
]

{ #category : #accessing }
XMLPluggableElementFactoryTest >> usernameElementClass [
	^ XMLFUsernameElement
]

{ #category : #accessing }
XMLPluggableElementFactoryTest >> wrongElementClass [
	^ XMLFWrongElement
]
