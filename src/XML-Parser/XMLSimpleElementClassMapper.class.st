"
This class can match elements to classes based on their names, namespace URIs, and attributes.

The precedence of mapping goes:
-Qualified name, namespace URI, and attributes
-Qualified name and namespace URI
-Qualified name and attributes
-Qualified name
-Non-qualified name, namespace URI, and attributes
-Non-qualified name and namespace URI
-Non-qualified name and attributes
-Non-qualified name
"
Class {
	#name : #XMLSimpleElementClassMapper,
	#superclass : #XMLElementClassMapper,
	#instVars : [
		'elementClassMap'
	],
	#category : #'XML-Parser-Utils'
}

{ #category : #accessing }
XMLSimpleElementClassMapper >> classForElement: aQualifiedName attributes: anAssociationCollection ifNone: aBlock [
	^ self
		classForElement: aQualifiedName
		namespaceURI: ''
		attributes: anAssociationCollection
		ifNone: aBlock
]

{ #category : #accessing }
XMLSimpleElementClassMapper >> classForElement: aQualifiedName ifNone: aBlock [
	^ self
		classForElement: aQualifiedName
		namespaceURI: ''
		attributes: #()
		ifNone: aBlock
]

{ #category : #accessing }
XMLSimpleElementClassMapper >> classForElement: aQualifiedName namespaceURI: aURI attributes: anAssociationCollection ifNone: aBlock [
	| localName |

	aURI size > 0 "optimization"
		ifTrue: [
			(self
				elementClassMapAt: aQualifiedName -> aURI
				attributes: anAssociationCollection)
				ifNotNil: [:class | ^ class].
			(self
				elementClassMapAt: aQualifiedName
				attributes: anAssociationCollection)
				ifNotNil: [:class | ^ class].
			(localName := aQualifiedName xmlLocalNameAfterPrefix) size < aQualifiedName size
				ifTrue: [
					(self
						elementClassMapAt: localName -> aURI
						attributes: anAssociationCollection)
						ifNotNil: [:class | ^ class].
					(self
						elementClassMapAt: localName
						attributes: anAssociationCollection)
						ifNotNil: [:class | ^ class]]]
		ifFalse: [
			(self
				elementClassMapAt: aQualifiedName
				attributes: anAssociationCollection)
				ifNotNil: [:class | ^ class].
			(localName := aQualifiedName xmlLocalNameAfterPrefix) size < aQualifiedName size
				ifTrue: [
					(self
						elementClassMapAt: localName
						attributes: anAssociationCollection)
						ifNotNil: [:class | ^ class]]].

	^ aBlock value.
]

{ #category : #accessing }
XMLSimpleElementClassMapper >> classForElement: aQualifiedName namespaceURI: aURI ifNone: aBlock [
	^ self
		classForElement: aQualifiedName
		namespaceURI: aURI
		attributes: #()
		ifNone: aBlock
]

{ #category : #accessing }
XMLSimpleElementClassMapper >> classForElement: aQualifiedName namespaceURI: aURI localName: aLocalName attributes: anAssociationCollection ifNone: aBlock [
	aURI size > 0 "optimization"
		ifTrue: [
			(self
				elementClassMapAt: aQualifiedName -> aURI
				attributes: anAssociationCollection)
				ifNotNil: [:class | ^ class].
			(self
				elementClassMapAt: aQualifiedName
				attributes: anAssociationCollection)
				ifNotNil: [:class | ^ class].
			aLocalName size < aQualifiedName size
				ifTrue: [
					(self
						elementClassMapAt: aLocalName -> aURI
						attributes: anAssociationCollection)
						ifNotNil: [:class | ^ class].
					(self
						elementClassMapAt: aLocalName
						attributes: anAssociationCollection)
						ifNotNil: [:class | ^ class]]]
		ifFalse: [
			(self
				elementClassMapAt: aQualifiedName
				attributes: anAssociationCollection)
				ifNotNil: [:class | ^ class].
			aLocalName size < aQualifiedName size
				ifTrue: [
					(self
						elementClassMapAt: aLocalName
						attributes: anAssociationCollection)
						ifNotNil: [:class | ^ class]]].

	^ aBlock value.
]

{ #category : #private }
XMLSimpleElementClassMapper >> elementClassMap [
	^ elementClassMap
]

{ #category : #private }
XMLSimpleElementClassMapper >> elementClassMapAt: aKey attributes: anAssociationCollection [
	| classOrCollection |

	classOrCollection :=
		elementClassMap
			at: aKey
			ifAbsent: [^ nil].

	classOrCollection isCollection
		ifTrue: [
			"to:do: for speed"
			1 to: classOrCollection size - 1 do: [:i |
				((classOrCollection at: i) key
					matchesAttributeAssociations: anAssociationCollection)
					ifTrue: [^ (classOrCollection at: i) value]].
			^ classOrCollection last]
		ifFalse: [^ classOrCollection].
]

{ #category : #initialization }
XMLSimpleElementClassMapper >> initialize [
	super initialize.

	elementClassMap := Dictionary new.
]

{ #category : #mapping }
XMLSimpleElementClassMapper >> mapElement: anElement attributeSpec: anAttributeSpec toClass: aClass [
	| classOrCollection |

	classOrCollection :=
		elementClassMap
			at: anElement
			ifAbsent: [nil].

	classOrCollection isCollection
		ifTrue: [
			"new mappings have precedence over old"
			classOrCollection addFirst: anAttributeSpec -> aClass]
		ifFalse: [
			elementClassMap
				at: anElement
				put:
					(OrderedCollection
						with: anAttributeSpec -> aClass
						with: classOrCollection)].
]

{ #category : #mapping }
XMLSimpleElementClassMapper >> mapElement: anElement namespaceURI: aURI attributeSpec: anAttributeSpec toClass: aClass [
	self
		mapElement:
			(aURI size > 0
				ifTrue: [anElement -> aURI]
				ifFalse: [anElement])
		attributeSpec: anAttributeSpec
		toClass: aClass
]

{ #category : #mapping }
XMLSimpleElementClassMapper >> mapElement: anElement namespaceURI: aURI toClass: aClass [
	self
		mapElement:
			(aURI size > 0
				ifTrue: [anElement -> aURI]
				ifFalse: [anElement])
		toClass: aClass
]

{ #category : #mapping }
XMLSimpleElementClassMapper >> mapElement: anElement toClass: aClass [
	| classOrCollection |

	classOrCollection :=
		elementClassMap
			at: anElement
			ifAbsent: [nil].

	classOrCollection isCollection
		ifTrue: [
			classOrCollection
				at: classOrCollection size
				put: aClass]
		ifFalse: [
			elementClassMap
				at: anElement
				put: aClass].
]

{ #category : #copying }
XMLSimpleElementClassMapper >> postCopy [
	super postCopy.

	elementClassMap := elementClassMap copy.

	"each val is either a class or an OrderedCollection, which needs
	to be copied so new mappings in either the copy or original don't
	effect the other"
	elementClassMap associationsDo: [:each |
		each value isCollection
			ifTrue: [each value: each value copy]].
]
