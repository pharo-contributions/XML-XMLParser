"
The class represents an attribute node stored in an attribute node list. The name of an attribute node can be namespaced using prefixes, but the prefix must be mapped to a namespace URI in the containing element node. Unprefixed attributes have no namespace, not even a default if one is in scope, per the XML namespace standard.
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
XMLAttribute >> element [
	"reuse instance variable to save memory"
	^ parent
]

{ #category : #accessing }
XMLAttribute >> element: anElement [
	"reuse instance variable to save memory"
	parent := anElement
]

{ #category : #accessing }
XMLAttribute >> expandedName [
	^ self localName expandWithXMLNamespaceURI: self namespaceURI
]

{ #category : #testing }
XMLAttribute >> hasLanguage: aLanguage [
	| language xmlLang |

	language := aLanguage asLowercase.
	^ (xmlLang := self value asLowercase) = language
		or: [(xmlLang copyUpTo: $-) = language].
]

{ #category : #testing }
XMLAttribute >> hasNamespaceURI [
	^ self namespaceURI notEmpty
]

{ #category : #testing }
XMLAttribute >> hasPrefix [
	^ (self name
		indexOf: $:
		startingAt: 2) > 0
]

{ #category : #testing }
XMLAttribute >> isAttribute [
	^ true
]

{ #category : #testing }
XMLAttribute >> isInLanguage: aLanguage [
	self name = 'xml:lang'
		ifTrue: [^ self hasLanguage: aLanguage]
		ifFalse: [^ super isInLanguage: aLanguage]
]

{ #category : #testing }
XMLAttribute >> isNamed: aName [
	^ aName
		isXMLQualifiedName: self name
		orLocalName: self localName
]

{ #category : #testing }
XMLAttribute >> isNamedAny: aNameCollection [
	^ aNameCollection
		includesXMLQualifiedName: self name
		orLocalName: self localName
]

{ #category : #accessing }
XMLAttribute >> localName [
	^ self name xmlLocalNameAfterPrefix
]

{ #category : #accessing }
XMLAttribute >> name [
	^ name ifNil: [name := '']
]

{ #category : #accessing }
XMLAttribute >> name: aName [
	self renameWith: [name := aName]
]

{ #category : #accessing }
XMLAttribute >> namespaceURI [
	| prefix |

	"attributes must have prefixes to be namespaced"
	(self hasParent
		and: [(prefix := self prefix) notEmpty])
		ifTrue: [^ self parent resolvePrefix: prefix]
		ifFalse: [^ '']
]

{ #category : #accessing }
XMLAttribute >> prefix [
	^ self name xmlPrefixBeforeLocalName
]

{ #category : #accessing }
XMLAttribute >> prefix: aPrefix [
	self renameWith: [name := self localName qualifyWithXMLPrefix:  aPrefix]
]

{ #category : #private }
XMLAttribute >> renameWith: aBlock [
	| oldName |

	oldName := self name.
	aBlock value.
	(self name ~= oldName
		and: [self hasParent])
			ifTrue: [
				self parent
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
