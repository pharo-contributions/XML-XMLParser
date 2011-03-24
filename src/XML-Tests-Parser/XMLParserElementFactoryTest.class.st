"
This class tests the pluggable element factory. To do this it creates a number of dummy subclasses of XMLElement in its #setUp message that should be removed from the system by its #tearDown message. Since these classes only exist during testing, special accessor messages are used to reference them. These accessors are also generated automatically, whenever you send the class #createDummyElementAccessors. The names for the classes and accessors are taken from the class-side #dummyElementNames message and some supporting messages that specify a prefix and suffix (so the created classes don't collide with other, possibly pre-existing classes in the sytem).

Browse the class side for more information.
"
Class {
	#name : #XMLParserElementFactoryTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser'
}

{ #category : #utility }
XMLParserElementFactoryTest class >> createDummyElementAccessors [
	"self createDummyElementAccessors"

	| sourceStream |

	self removeDummyElementAccessors.
	self dummyElementNames
		do: [:each |
			(sourceStream := String new writeStream)
				nextPut: each first asLowercase;
				nextPutAll: each allButFirst, self dummyElementClassSuffix, 'Class';
				cr;
				tab;
				nextPutAll: '^ Smalltalk at: #';
				nextPutAll: (self toDummyElementClassName: each) asString.

			self
				compile: sourceStream contents
				classified: self dummyElementAccessorCategory].
]

{ #category : #running }
XMLParserElementFactoryTest class >> createDummyElementClasses [
	self dummyElementClassNames do: [:each |
		XMLElement
			subclass: each
			instanceVariableNames: ''
			classVariableNames: ''
			poolDictionaries: ''
			category: self category]
]

{ #category : #accessing }
XMLParserElementFactoryTest class >> dummyElementAccessorCategory [
	^ #'dummy element classes'
]

{ #category : #accessing }
XMLParserElementFactoryTest class >> dummyElementClassNames [
	^ self dummyElementNames collect: [:each | self toDummyElementClassName: each]
]

{ #category : #accessing }
XMLParserElementFactoryTest class >> dummyElementClassPrefix [
	^ 'XMLTEST'
]

{ #category : #accessing }
XMLParserElementFactoryTest class >> dummyElementClassSuffix [
	^ 'Element'
]

{ #category : #accessing }
XMLParserElementFactoryTest class >> dummyElementNames [
	"Dummy element class names will be formed from the following base names plus a prefix and suffix.
	
	self createDummyElementAccessors."

	^ #('Default' 'User' 'Username' 'RealName' 'Date' 'Table' 'SerializationFormat' 'Wrong')
]

{ #category : #utility }
XMLParserElementFactoryTest class >> removeDummyElementAccessors [
	(self methodsInCategory: self dummyElementAccessorCategory)
		do: [:each | self removeSelector: each].
]

{ #category : #running }
XMLParserElementFactoryTest class >> removeDummyElementClasses [
	self dummyElementClassNames do: [:each | (Smalltalk at: each) removeFromSystem]
]

{ #category : #accessing }
XMLParserElementFactoryTest class >> toDummyElementClassName: aName [
	^ (self dummyElementClassPrefix,
		aName,
		self dummyElementClassSuffix) asSymbol
]

{ #category : #'dummy element classes' }
XMLParserElementFactoryTest >> dateElementClass [
	^ Smalltalk at: #XMLTESTDateElement
]

{ #category : #'dummy element classes' }
XMLParserElementFactoryTest >> defaultElementClass [
	^ Smalltalk at: #XMLTESTDefaultElement
]

{ #category : #'dummy element classes' }
XMLParserElementFactoryTest >> realNameElementClass [
	^ Smalltalk at: #XMLTESTRealNameElement
]

{ #category : #'source XML' }
XMLParserElementFactoryTest >> sampleUserXML [
	^
	XMLWriter new
		enablePrettyPrinting;
		writeWith: [:writer |
			writer tag
				name: 'user:user';
				xmlnsAt: 'user' put: 'urn:user';
				with: [
					writer
						tag: 'user:username' with: 'jsmith';
						tag: 'user:real-name' with: 'John Smith';
						tag: 'user:date-registered' with: (DateAndTime now - 1 week) printString;
						tag: 'user:date-last-active' with: DateAndTime now printString;
						tag: 'table-name' with: 'users';
						tag: 'row-id' with: (Random new next * 100) asInteger printString;
						tag: 'serializationFormat' with: 'XML']];
		contents
]

{ #category : #'dummy element classes' }
XMLParserElementFactoryTest >> serializationFormatElementClass [
	^ Smalltalk at: #XMLTESTSerializationFormatElement
]

{ #category : #running }
XMLParserElementFactoryTest >> setUp [
	self class createDummyElementClasses
]

{ #category : #'dummy element classes' }
XMLParserElementFactoryTest >> tableElementClass [
	^ Smalltalk at: #XMLTESTTableElement
]

{ #category : #running }
XMLParserElementFactoryTest >> tearDown [
	self class removeDummyElementClasses
]

{ #category : #tests }
XMLParserElementFactoryTest >> testElementClassAccessor [
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
XMLParserElementFactoryTest >> testElementClassNameMatching [
	| document |

	document :=
		(XMLDOMParser on: self sampleUserXML)
			nodeFactory:
				(XMLPluggableElementFactory new
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
XMLParserElementFactoryTest >> testElementNameAndNamespaceMatching [
	| factory document root |

	(factory := XMLPluggableElementFactory new)
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
XMLParserElementFactoryTest >> testElementsNameAndNamespaceMatching [
	| factory document root |

	factory := XMLPluggableElementFactory new.
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

{ #category : #'dummy element classes' }
XMLParserElementFactoryTest >> userElementClass [
	^ Smalltalk at: #XMLTESTUserElement
]

{ #category : #'dummy element classes' }
XMLParserElementFactoryTest >> usernameElementClass [
	^ Smalltalk at: #XMLTESTUsernameElement
]

{ #category : #'dummy element classes' }
XMLParserElementFactoryTest >> wrongElementClass [
	^ Smalltalk at: #XMLTESTWrongElement
]
