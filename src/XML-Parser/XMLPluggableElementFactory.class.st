"
This class is a pluggable factory that can map elements to different XMLElement subclasses based on the name and namespace information of those elements. You have to create an instance, configure it to handle certain elements with certain classes, and then inject your instance into a DOM parser using #nodeFactory: before parsing. Here is an example of its use:

	doc := (XMLDOMParser on: someXML)
		nodeFactory:
			(XMLPluggableElementFactory new
				elementClass: GenericElement;
				handleElement: 'user' withClass: UserElement;
				handleElement: 'report' withClass: ReportElement;
				handleElement: 'report' namespaceURI: 'urn:specialreprot' withClass: SpecialReportElement)
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

{ #category : #'element handling' }
XMLPluggableElementFactory >> handleElement: anElementName namespaceURI: aUri withClass: aClass [
	(self elementClassesByName
		at: anElementName
		ifAbsentPut: [Dictionary new])
			at: aUri put: aClass
]

{ #category : #'element handling' }
XMLPluggableElementFactory >> handleElement: anElementName withClass: aClass [
	self
		handleElement: anElementName
		namespaceURI: ''
		withClass: aClass
]

{ #category : #'element handling' }
XMLPluggableElementFactory >> handleElements: anElementNameCollection namespaceURI: aNamespaceURI withClass: aClass [
	anElementNameCollection do: [:each |
		self
			handleElement: each
			namespaceURI: aNamespaceURI
			withClass: aClass]
]

{ #category : #'element handling' }
XMLPluggableElementFactory >> handleElements: anElementNameCollection withClass: aClass [
	anElementNameCollection do: [:each | self handleElement: each withClass: aClass]
]

{ #category : #'element handling' }
XMLPluggableElementFactory >> handleElementsMatchingClass: aClass [
	| className |

	(className := self toNameWithoutPrefixAndElementSuffix: aClass name asString)
		ifEmpty: [^ self].

	self
		handleElement: (self toCamelCasedName: className)
		withClass: aClass.
	self
		handleElement: (self toHyphenatedName: className)
		withClass: aClass.
]

{ #category : #'element handling' }
XMLPluggableElementFactory >> handleElementsMatchingClasses: aClassCollection [
	aClassCollection do: [:each | self handleElementsMatchingClass: each]
]

{ #category : #private }
XMLPluggableElementFactory >> toCamelCasedName: aString [
	^ aString allButFirst copyWithFirst: aString first asLowercase
]

{ #category : #private }
XMLPluggableElementFactory >> toHyphenatedName: aString [
	| nameStream hyphenatedStream previousChar nextChar |

	nameStream := aString readStream.
	hyphenatedStream := (String new: nameStream size) writeStream.
	[nameStream atEnd]
		whileFalse: [
			((nextChar := nameStream next) isUppercase
				and: [previousChar notNil and: [previousChar isLowercase]])
				ifTrue: [hyphenatedStream nextPut: $-].
			hyphenatedStream nextPut: nextChar asLowercase.
			previousChar := nextChar].
	^ hyphenatedStream contents.
]

{ #category : #private }
XMLPluggableElementFactory >> toNameWithoutPrefixAndElementSuffix: aString [
	| nameStream |

	nameStream := aString readStream.
	[nameStream atEnd not and: [nameStream peek isUppercase]]
		whileTrue: [nameStream next].
	nameStream atEnd
		ifTrue: [^ ''].
	nameStream back.

	^ nameStream upToEnd copyReplaceAll: 'Element' with: ''.
]
