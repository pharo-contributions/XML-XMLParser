"
This class tests the pluggable element factory. To do this it creates a number of dummy subclasses of XMLElement in its #setUp message that should be removed from the system by its #tearDown message. Since these classes only exist during testing, special accessor messages are used to reference them. These accessors are also generated automatically, whenever you send the class #createDummyElementAccessors. The names for the classes and accessors are taken from the class-side #dummyElementNames message and some supporting messages that specify a prefix and suffix (so the created classes don't collide with other, possibly pre-existing classes in the sytem).

Browse the class side for more information.
"
Class {
	#name : #XMLPluggableElementFactoryTest,
	#superclass : #XMLPluggableNodeFactoryTest,
	#category : #'XML-Tests-Parser-Factories'
}

{ #category : #running }
XMLPluggableElementFactoryTest class >> createDummyClasses [
	super createDummyClasses.

	self createDummyElementClasses.
]

{ #category : #running }
XMLPluggableElementFactoryTest class >> createDummyElementClasses [
	self dummyElementClassNames do: [:each |
		self
			createDummySubclassOf: XMLElement
			named: each]
]

{ #category : #accessing }
XMLPluggableElementFactoryTest class >> dummyElementClassNames [
	^ self dummyElementNames collect: [:each |
		(self dummyClassPrefix,
			each,
			'Element') asSymbol]
]

{ #category : #accessing }
XMLPluggableElementFactoryTest class >> dummyElementNames [
	^ #('User' 'Username' 'RealName' 'Date' 'Table' 'SerializationFormat' 'Wrong')
]

{ #category : #running }
XMLPluggableElementFactoryTest class >> removeDummyClasses [
	super removeDummyClasses.

	self removeDummyElementClasses.
]

{ #category : #running }
XMLPluggableElementFactoryTest class >> removeDummyElementClasses [
	self dummyElementClassNames do: [:each |
		self removeDummySubclassNamed: each]
]

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
XMLPluggableElementFactoryTest >> testElementClassNameMatching [
	| document |

	document :=
		(XMLDOMParser on: self sampleUserXML)
			nodeFactory:
				(self newFactory
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

	(factory := self newFactory)
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

	factory := self newFactory.
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
