"
This class is a pluggable factory that can map elements to different XMLElement subclasses based on the name and namespace information of those elements. You have to create an instance, configure it to handle certain named elements with certain classes, and then inject your instance into a DOM parser using #nodeFactory: before parsing. Here is an example of its use:

	doc := (XMLDOMParser on: aStringOrStream)
		nodeFactory:
			(XMLPluggableElementFactory new
				handleElement: 'user' withClass: MyUserElement;
				handleElement: 'report' withClass: MyReportElement);
		parseDocument.
"
Class {
	#name : #XMLPluggableElementFactory,
	#superclass : #XMLNodeFactory,
	#instVars : [
		'elementClassesByName'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #accessing }
XMLPluggableElementFactory >> classForElement: aName prefix: aPrefix uri: aUri localName: aLocalName [
	^ (self classForElement: aName uri: aUri)
		ifNil: [
			aPrefix
				ifEmpty: [self elementClass]
				ifNotEmpty: [
					(self classForElement: aLocalName uri: aUri)
						ifNil: [self elementClass]]]
]

{ #category : #accessing }
XMLPluggableElementFactory >> classForElement: aName uri: aUri [
	| classesForElement |

	classesForElement :=
		self elementClassesByName
			at: aName
			ifAbsent: [^ nil].

	^ classesForElement
		at: aUri
		ifAbsent: [
			classesForElement
				at: ''
				ifAbsent: [nil]].
]

{ #category : #accessing }
XMLPluggableElementFactory >> elementClassesByName [
	^ elementClassesByName ifNil: [elementClassesByName := Dictionary new]
]

{ #category : #accessing }
XMLPluggableElementFactory >> handleElement: anElementName namespaceURI: aUri withClass: aClass [
	(self elementClassesByName
		at: anElementName
		ifAbsentPut: [Dictionary new])
			at: aUri put: aClass
]

{ #category : #accessing }
XMLPluggableElementFactory >> handleElement: anElementName withClass: aClass [
	self
		handleElement: anElementName
		namespaceURI: ''
		withClass: aClass
]
