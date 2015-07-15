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
		
The #handleElementsMatchingClass*: forms try to match elements to the specified classes based on the names of those classes when stripped of any prefix (like XML) and ""Element"" suffix and converted to both camel case and a hyphenated form. So this:
	XMLPluggableElementFactory new
		handleElementsMatchingClass: MYRootUserElement
		....
will handle 'rootUser' and 'root-user' elements with the MYRootUserElement class.
"
Class {
	#name : #XMLPluggableElementFactory,
	#superclass : #XMLPluggableNodeFactory,
	#instVars : [
		'elementClasses'
	],
	#category : #'XML-Parser-DOM'
}

{ #category : #accessing }
XMLPluggableElementFactory >> classForElement: aName prefix: aPrefix uri: aURI localName: aLocalName [
	^ (self elementClassAtName: aName uri: aURI)
		ifNil: [
			aPrefix size > 0
				ifTrue: [
					(self elementClassAtName: aLocalName uri: aURI)
						ifNil: [self elementClass]]
				ifFalse: [self elementClass]]
]

{ #category : #private }
XMLPluggableElementFactory >> elementClassAtName: aName uri: aURI [
	aURI size > 0
		ifTrue: [
			^ self elementClasses
				at: aName -> aURI
				ifAbsent: [
					self elementClasses
						at: aName 
						ifAbsent: [nil]]]
		ifFalse: [
			^ self elementClasses
				at: aName
				ifAbsent: [nil]]
]

{ #category : #private }
XMLPluggableElementFactory >> elementClasses [
	^ elementClasses
]

{ #category : #'element handling' }
XMLPluggableElementFactory >> handleElement: anElementName namespaceURI: aURI withClass: aClass [
	self elementClasses
		at:
			(aURI isEmpty
				ifTrue: [anElementName]
				ifFalse: [anElementName -> aURI])
		put: aClass
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

{ #category : #initialization }
XMLPluggableElementFactory >> initialize [
	super initialize.

	elementClasses := Dictionary new.
]

{ #category : #copying }
XMLPluggableElementFactory >> postCopy [
	super postCopy.

	elementClasses
		ifNotNil: [elementClasses := elementClasses copy].
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
	nameStream position: nameStream position - 1.

	^ nameStream upToEnd copyReplaceAll: 'Element' with: ''.
]
