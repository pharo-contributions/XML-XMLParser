"
This class is the default node factory. Its accessor messages return the class objects used by the DOM parser to build a node tree. You can override these messages to return different class objects and inject an instance of your factory using the DOM parser's #nodeFactory: accessor before parsing.
"
Class {
	#name : #XMLNodeFactory,
	#superclass : #Object,
	#category : #'XML-Parser-DOM'
}

{ #category : #accessing }
XMLNodeFactory >> attributeDeclarationClass [
	^ XMLAttributeDeclaration
]

{ #category : #accessing }
XMLNodeFactory >> cdataClass [
	^ XMLCData
]

{ #category : #accessing }
XMLNodeFactory >> classForElement: aQualifiedName [
	^ self
		classForElement: aQualifiedName
		namespaceURI: ''
]

{ #category : #accessing }
XMLNodeFactory >> classForElement: aQualifiedName namespaceURI: aUri [
	| prefix |

	^ self
		classForElement: aQualifiedName
		prefix: (prefix := aQualifiedName prefixBeforeLocalName)
		uri: aUri
		localName: (aQualifiedName localNameAfterPrefix: prefix)
]

{ #category : #accessing }
XMLNodeFactory >> classForElement: aQualifiedName prefix: aPrefix uri: aNamespaceUri localName: aLocalName [
	^ self elementClass
]

{ #category : #accessing }
XMLNodeFactory >> commentClass [
	^ XMLComment
]

{ #category : #accessing }
XMLNodeFactory >> doctypeDeclarationClass [
	^ XMLDoctypeDeclaration
]

{ #category : #accessing }
XMLNodeFactory >> documentClass [
	^ XMLDocument
]

{ #category : #accessing }
XMLNodeFactory >> elementClass [
	^ XMLElement
]

{ #category : #accessing }
XMLNodeFactory >> elementDeclarationClass [
	^ XMLElementDeclaration
]

{ #category : #accessing }
XMLNodeFactory >> generalEntityDeclarationClass [
	^ XMLGeneralEntityDeclaration
]

{ #category : #'instance creation' }
XMLNodeFactory >> newCData: aString [
	^ self cdataClass string: aString
]

{ #category : #'instance creation' }
XMLNodeFactory >> newComment: aString [
	^ self commentClass string: aString
]

{ #category : #'instance creation' }
XMLNodeFactory >> newDocument [
	^ self documentClass new
]

{ #category : #'instance creation' }
XMLNodeFactory >> newElement [
	^ self elementClass new
]

{ #category : #'instance creation' }
XMLNodeFactory >> newElementNamed: aName [
	^ (self classForElement: aName)
		named: aName
]

{ #category : #'instance creation' }
XMLNodeFactory >> newElementNamed: aName namespaceURI: aUri [
	^ (self classForElement: aName namespaceURI: aUri)
		name: aName
		namespaceURI: aUri
]

{ #category : #'instance creation' }
XMLNodeFactory >> newPI [
	^ self piClass new
]

{ #category : #'instance creation' }
XMLNodeFactory >> newString: aString [
	^ self stringClass string: aString
]

{ #category : #accessing }
XMLNodeFactory >> notationDeclarationClass [
	^ XMLNotationDeclaration
]

{ #category : #accessing }
XMLNodeFactory >> parameterEntityDeclarationClass [
	^ XMLParameterEntityDeclaration
]

{ #category : #accessing }
XMLNodeFactory >> piClass [
	^ XMLPI
]

{ #category : #accessing }
XMLNodeFactory >> stringClass [
	^ XMLString
]
