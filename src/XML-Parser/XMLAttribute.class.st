"
The class represents an attribute node, to be stored in an attribute node list. You generally won't need to interact with these objects directly; the various #attribute- messages element nodes respond to will normally suffice. The name of an attribute node can be namespaced using prefixes; however, the prefix must be mapped to a namespace URI in the containing element node. Unprefixed attributes have no namespace, not even a default namespace URI if one is in scope, per the XML namespace standard.
"
Class {
	#name : #XMLAttribute,
	#superclass : #XMLNode,
	#instVars : [
		'name',
		'value'
	],
	#category : #'XML-Parser-DOM'
}

{ #category : #'instance creation' }
XMLAttribute class >> name: aName value: aValue [
	^ self new	
		setName: aName
		value: aValue
		element: nil
]

{ #category : #accessing }
XMLAttribute >> configuration [
	^ self element ifNotNil: [:element | element configuration]
]

{ #category : #accessing }
XMLAttribute >> document [
	^ self element ifNotNil: [:element | element document]
]

{ #category : #accessing }
XMLAttribute >> element [
	"reuse instance variable to save memory"
	^ parent
]

{ #category : #accessing }
XMLAttribute >> element: anElement [
	"reuse instance variable to save memory"
	parent := anElement
]

{ #category : #namespaces }
XMLAttribute >> expandedName [
	^ self localName expandWithNamespaceURI: self namespaceURI
]

{ #category : #testing }
XMLAttribute >> hasLanguage: aLanguage [
	| language xmlLang |

	language := aLanguage asLowercase.
	^ (xmlLang := self value asLowercase) = language
		or: [(xmlLang copyUpTo: $-) = language].
]

{ #category : #testing }
XMLAttribute >> hasPrefix [
	^ self name hasPrefixBeforeLocalName
]

{ #category : #testing }
XMLAttribute >> isInLanguage: aLanguage [
	self name = 'xml:lang'
		ifTrue: [^ self hasLanguage: aLanguage].
	^ self element notNil
		and: [self element isInLanguage: aLanguage]
]

{ #category : #testing }
XMLAttribute >> isNamed: aName [
	^ aName
		isQualifiedName: self name
		orLocalName: self localName
]

{ #category : #testing }
XMLAttribute >> isNamedAny: aNameCollection [
	^ aNameCollection
		includesQualifiedName: self name
		orLocalName: self localName
]

{ #category : #accessing }
XMLAttribute >> localName [
	^ self name localNameAfterPrefix
]

{ #category : #accessing }
XMLAttribute >> name [
	^ name ifNil: [name := '']
]

{ #category : #accessing }
XMLAttribute >> name: aName [
	self renameWith: [name := aName]
]

{ #category : #namespaces }
XMLAttribute >> namespaceURI [
	| prefix |

	"attributes must have prefixes to be namespaced"
	(self element notNil
		and: [(prefix := self prefix) notEmpty])
		ifFalse: [^ ''].
	
	^ self element resolvePrefix: prefix.
]

{ #category : #accessing }
XMLAttribute >> nextNode [
	^ self element ifNotNil: [:element | element attributeNodes after: self]
]

{ #category : #accessing }
XMLAttribute >> parent [
	"attributes have no parents and aren't part of the DOM tree"
	self shouldNotImplement
]

{ #category : #accessing }
XMLAttribute >> parent: aParentNode [
	"attributes have no parents and aren't part of the DOM tree"
	self shouldNotImplement
]

{ #category : #namespaces }
XMLAttribute >> prefix [
	^ self name prefixBeforeLocalName
]

{ #category : #namespaces }
XMLAttribute >> prefix: aPrefix [
	self renameWith: [name := self localName qualifyWithPrefix:  aPrefix]
]

{ #category : #accessing }
XMLAttribute >> previousNode [
	^ self element ifNotNil: [:element | element attributeNodes before: self]
]

{ #category : #private }
XMLAttribute >> renameWith: aBlock [
	| oldName |

	oldName := self name.
	aBlock value.
	(self name ~= oldName
		and: [self element notNil])
			ifTrue: [
				self element
					renamedAttribute: self
					from: oldName
					to: self name].
]

{ #category : #initialization }
XMLAttribute >> setName: aName value: aValue element: anElement [
	name := aName.
	value := aValue.
	parent := anElement.
]

{ #category : #private }
XMLAttribute >> sortKey [
	^ self name
]

{ #category : #accessing }
XMLAttribute >> value [
	^ value ifNil: [value := '']
]

{ #category : #accessing }
XMLAttribute >> value: aString [
	value := aString
]

{ #category : #printing }
XMLAttribute >> writeXMLOn: aWriter [
	aWriter
		writeName: self name
		escapedContentValue: self value
]
