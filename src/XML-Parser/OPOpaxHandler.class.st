"
The goal of Opax is to combine DOM and SAX such that:
- we get a tree of objects, like in a DOM
- but these are explicit objects and not strings.

This is achieved by transforming SAX events into objects based on the types of the XML tags.

The OpaxHandler is the key class that takes care of this transformation. Being a subclass of SAXHandler, it intercepts the SAX events and then instantiates either an OPGenericElement or a subclass based on matching the results of the xmlTags methods from the OPGenericElement hierarchy.
"
Class {
	#name : #OPOpaxHandler,
	#superclass : #SAXHandler,
	#instVars : [
		'stack'
	],
	#category : #'XML-Parser-Opax'
}

{ #category : #'instance creation' }
OPOpaxHandler class >> on: aStream [
	| driver parser |
	driver := SAXDriver on: aStream.
	"driver validating: false."
	parser := self new driver: driver.
	^parser
]

{ #category : #'public interface' }
OPOpaxHandler >> characters: aString [
	self stack last characters: aString.
]

{ #category : #'public interface' }
OPOpaxHandler >> endDocument [
	^super endDocument
]

{ #category : #'public interface' }
OPOpaxHandler >> endElement: qualifiedName prefix: prefix uri: namespaceURI localName: localName [ 
	"indicates the end of an element. See startElement"
	((stack last class xmlTags includes: localName) or: [stack last isMemberOf: OPGenericElement]) ifTrue: [stack removeLast: 1].
]

{ #category : #initialize }
OPOpaxHandler >> initialize [
	super initialize.
]

{ #category : #accessing }
OPOpaxHandler >> stack [
	^stack
]

{ #category : #accessing }
OPOpaxHandler >> stack: anObject [
	stack := anObject
]

{ #category : #'public interface' }
OPOpaxHandler >> startDocument [
	stack := OrderedCollection with: (OPRootElement new).

]

{ #category : #'public interface' }
OPOpaxHandler >> startElement: localName prefix: prefix uri: namespaceUri attributes: attributes [
"	localName = 'Class' ifTrue: [self halt.]."
"	(ElementManager uniqueInstance elementNamesWithoutPrefix includes: localName) ifTrue: [ |currentElement|
		pName := (attributes select: [ :each | each key type = 'name']) first.
		id := (attributes select: [ :each | each key type = 'xmi.id']) first value.
		currentElement := (ElementManager uniqueInstance elementNamedWithoutPrefix: localName) named: pName in: stack last withId: id."
	| currentElement |
	currentElement := OPGenericElement newElementWithTag: localName.
	currentElement attributes: attributes.
	stack last addChildLast: currentElement.
	stack addLast: currentElement.
"	]."
]

{ #category : #'public interface' }
OPOpaxHandler >> startElement: aQualifiedName prefix: prefix uri: namespaceUri localName: localName attributes: attributes [
"	localName = 'Class' ifTrue: [self halt.]."
"	(ElementManager uniqueInstance elementNamesWithoutPrefix includes: localName) ifTrue: [ |currentElement|
		pName := (attributes select: [ :each | each key type = 'name']) first.
		id := (attributes select: [ :each | each key type = 'xmi.id']) first value.
		currentElement := (ElementManager uniqueInstance elementNamedWithoutPrefix: localName) named: pName in: stack last withId: id."
	| currentElement |
	currentElement := OPGenericElement newElementWithTag: localName.
	currentElement attributes: attributes.
	stack last addChildLast: currentElement.
	stack addLast: currentElement.
"	]."
]
