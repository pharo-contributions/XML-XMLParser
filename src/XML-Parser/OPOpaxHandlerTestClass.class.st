Class {
	#name : #OPOpaxHandlerTestClass,
	#superclass : #OPOpaxHandler,
	#instVars : [
		'cStackGet',
		'cStackSet',
		'cStartDocument',
		'cEndDocument',
		'cEndElement',
		'cStartElement',
		'cChar'
	],
	#category : #'XML-Parser-Opax-Test'
}

{ #category : #accessing }
OPOpaxHandlerTestClass >> cChar [
	^cChar	
]

{ #category : #accessing }
OPOpaxHandlerTestClass >> cEndDocument [
	^cEndDocument 
]

{ #category : #accessing }
OPOpaxHandlerTestClass >> cEndElement [
	^cEndElement 
]

{ #category : #accessing }
OPOpaxHandlerTestClass >> cStackGet [ 
	^cStackGet
]

{ #category : #accessing }
OPOpaxHandlerTestClass >> cStackSet [ 
	^cStackSet 
]

{ #category : #accessing }
OPOpaxHandlerTestClass >> cStartDocument [ 
	^cStartDocument 
]

{ #category : #accessing }
OPOpaxHandlerTestClass >> cStartElement [
	^cStartElement 
]

{ #category : #'public interface' }
OPOpaxHandlerTestClass >> characters: aString [
	self stack last characters: aString.
	cChar := cChar + 1.
]

{ #category : #'public interface' }
OPOpaxHandlerTestClass >> endDocument [
	cEndDocument := cEndDocument + 1.
	^super endDocument.
]

{ #category : #'public interface' }
OPOpaxHandlerTestClass >> endElement: qualifiedName prefix: prefix uri: namespaceURI localName: localName [ 
	"indicates the end of an element. See startElement"
	((stack last class xmlTags includes: localName) or: [stack last isMemberOf: OPGenericElement]) ifTrue: [stack removeLast: 1].
	cEndElement := cEndElement + 1.
]

{ #category : #initialize }
OPOpaxHandlerTestClass >> initialize [
	super initialize.
	cStackGet := 0.
	cStackSet := 0.
	cStartDocument := 0.
	cEndDocument := 0.
	cEndElement := 0.
	cStartElement := 0.
	cChar:= 0.
]

{ #category : #accessing }
OPOpaxHandlerTestClass >> stack [
	cStackGet := cStackGet + 1.
	^stack
	
	
]

{ #category : #accessing }
OPOpaxHandlerTestClass >> stack: anObject [
	stack := anObject.
	cStackSet := cStackSet + 1.
	
]

{ #category : #'public interface' }
OPOpaxHandlerTestClass >> startDocument [
	stack := OrderedCollection with: (OPRootElement new).
	cStartDocument := cStartDocument + 1.
]

{ #category : #'public interface' }
OPOpaxHandlerTestClass >> startElement: localName prefix: prefix uri: namespaceUri attributes: attributes [
	| currentElement |
	currentElement := OPGenericElement newElementWithTag: localName.
	currentElement attributes: attributes.
	stack last addChildLast: currentElement.
	stack addLast: currentElement.
	cStartElement := cStartElement + 1.
]

{ #category : #'public interface' }
OPOpaxHandlerTestClass >> startElement: aQualifiedName prefix: prefix uri: namespaceUri localName: localName attributes: attributes [
	| currentElement |
	currentElement := OPGenericElement newElementWithTag: localName.
	currentElement attributes: attributes.
	stack last addChildLast: currentElement.
	stack addLast: currentElement.
	cStartElement := cStartElement + 1.
]
