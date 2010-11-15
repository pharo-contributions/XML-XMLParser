"
This class tests the pluggable element factory.
"
Class {
	#name : #XMLParserElementFactoryTest,
	#superclass : #TestCase,
	#category : #'XML-Parser-Tests'
}

{ #category : #accessing }
XMLParserElementFactoryTest >> dateElementClass [
	^ self elementClassAt: #XMLTESTDateRegisteredElement
]

{ #category : #accessing }
XMLParserElementFactoryTest >> defaultElementClass [
	^ self elementClassAt: #XMLTESTDefaultElement
]

{ #category : #accessing }
XMLParserElementFactoryTest >> elementClassAt: aSymbol [
	^ Smalltalk at: aSymbol
]

{ #category : #accessing }
XMLParserElementFactoryTest >> elementClassNames [
	^ #(XMLTESTDefaultElement
		XMLTESTUserElement XMLTESTOtherUsernameElement XMLTESTDateRegisteredElement
		XMLTESTOtherDateRegisteredElement XMLTESTTableNameElement XMLTESTOtherTableNameElement)
]

{ #category : #accessing }
XMLParserElementFactoryTest >> otherDateElementClass [
	^ self elementClassAt: #XMLTESTOtherDateRegisteredElement
]

{ #category : #accessing }
XMLParserElementFactoryTest >> otherTableElementClass [
	^ self elementClassAt: #XMLTESTOtherTableNameElement
]

{ #category : #accessing }
XMLParserElementFactoryTest >> otherUsernameClass [
	^ self elementClassAt: #XMLTESTOtherUsernameElement
]

{ #category : #running }
XMLParserElementFactoryTest >> setUp [
	self elementClassNames do: [:each |
		XMLElement
			subclass: each
			instanceVariableNames: ''
			classVariableNames: ''
			poolDictionaries: ''
			category: self class category]
]

{ #category : #accessing }
XMLParserElementFactoryTest >> tableElementClass [
	^ self elementClassAt: #XMLTESTTableNameElement
]

{ #category : #running }
XMLParserElementFactoryTest >> tearDown [
	self elementClassNames do: [:each | (self elementClassAt: each) removeFromSystem]
]

{ #category : #tests }
XMLParserElementFactoryTest >> testElementFactory [
	| factory document userClass dateClass tableClass |

	(factory := XMLPluggableElementFactory new)
		elementClass: self defaultElementClass;
		handleElement: 'user:user' namespaceURI: 'urn:user' withClass: self userElementClass;
		handleElement: 'username' namespaceURI: 'urn:notuser' withClass: self otherUsernameClass;
		handleElement: 'date-registered' namespaceURI: 'urn:notuser' withClass: self otherDateElementClass;
		handleElement: 'date-registered' withClass: self dateElementClass;
		handleElement: 'notuser:table-name' namespaceURI: 'urn:user' withClass: self otherTableElementClass;
		handleElement: 'table-name' namespaceURI: 'urn:user' withClass: self otherTableElementClass;
		handleElementsMatchingClass: self tableElementClass.

	document :=
		(XMLDOMParser on: self userXML)
			nodeFactory: factory;
			parseDocument.
	self
		assert: (document root isMemberOf: self userElementClass);
		assert: ((document root elementAt: 'username') isMemberOf: self defaultElementClass);
		assert: ((document root elementAt: 'real-name') isMemberOf: self defaultElementClass);
		assert: ((document root elementAt: 'date-registered') isMemberOf: self dateElementClass);
		assert: ((document root elementAt: 'table-name') isMemberOf: self tableElementClass);
		assert: ((document root elementAt: 'tableName') isMemberOf: self tableElementClass).
]

{ #category : #accessing }
XMLParserElementFactoryTest >> userElementClass [
	^ self elementClassAt: #XMLTESTUserElement
]

{ #category : #source }
XMLParserElementFactoryTest >> userXML [
	"
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
							tag: 'user:date-registered' with: DateAndTime now asString;
							tag: 'table-name' with: 'users']]
	"

	^ ' <user:user xmlns:user="urn:user">
    <user:username>jsmith</user:username>
    <user:real-name>John Smith</user:real-name>
    <user:date-registered>2010-11-14T23:53:54-05:00</user:date-registered>
    <table-name>users</table-name>
    <tableName>users</tableName>
</user:user>'
]
