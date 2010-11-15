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
		'elementClass',
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

{ #category : #private }
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
XMLPluggableElementFactory >> elementClass [
	^ elementClass ifNil: [elementClass := super elementClass]
]

{ #category : #accessing }
XMLPluggableElementFactory >> elementClass: anElementClass [
	elementClass := anElementClass
]

{ #category : #private }
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

{ #category : #accessing }
XMLPluggableElementFactory >> handleElementsMatchingClass: aClass [
	| className camelCaseName camelCaseStream hyphenatedStream |

	(className := self removePrefixAndElementSuffixFrom: aClass name asString)
		ifEmpty: [^ self].

	camelCaseName := className allButFirst copyWithFirst: className first asLowercase.
	self handleElement: camelCaseName withClass: aClass.

	camelCaseStream := camelCaseName readStream.
	hyphenatedStream := (String new: camelCaseName size) writeStream.
	[camelCaseStream atEnd]
		whileFalse: [
			camelCaseStream peek isUppercase
				ifTrue: [hyphenatedStream nextPut: $-].
			hyphenatedStream nextPut: camelCaseStream next asLowercase].
	self handleElement: hyphenatedStream contents withClass: aClass.
]

{ #category : #private }
XMLPluggableElementFactory >> removePrefixAndElementSuffixFrom: aString [
	| nameStream |

	nameStream := aString readStream.
	[nameStream atEnd not and: [nameStream peek isUppercase]]
		whileTrue: [nameStream next].
	nameStream atEnd
		ifTrue: [^ ''].
	nameStream back.

	^ nameStream upToEnd copyReplaceAll: 'Element' with: ''.
]
