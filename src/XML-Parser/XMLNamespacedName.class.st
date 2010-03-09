"
The class represents a name for an element or attribute that can be associated with a namespace.
"
Class {
	#name : #XMLNamespacedName,
	#superclass : #Object,
	#instVars : [
		'localName',
		'qualifiedName',
		'prefix',
		'scope'
	],
	#category : #'XML-Parser'
}

{ #category : #accessing }
XMLNamespacedName >> expandedName [
	"Returns a string containing the local name expanded with its namespace URI"
	^ self namespaceURI
		ifNil: [self localName asString]
		ifNotNil: ['{', self namespaceURI, '}', self localName asString]
]

{ #category : #testing }
XMLNamespacedName >> hasPrefix [
	^ prefix notNil
]

{ #category : #accessing }
XMLNamespacedName >> localName [
	^ localName ifNil: ['']
]

{ #category : #accessing }
XMLNamespacedName >> localName: aString [
	self setPrefix: self prefix localName: aString
]

{ #category : #accessing }
XMLNamespacedName >> namespace [
	^ (self hasPrefix
		ifTrue: [self prefix]
		ifFalse: [self namespaceURI])
]

{ #category : #accessing }
XMLNamespacedName >> namespaceURI [
	^ self scope resolvePrefix: self prefix
]

{ #category : #accessing }
XMLNamespacedName >> prefix [
	^ prefix
]

{ #category : #accessing }
XMLNamespacedName >> prefix: aPrefix [
	self setPrefix: aPrefix localName: self localName
]

{ #category : #accessing }
XMLNamespacedName >> prefix: aPrefix uri: aUri [
	self setPrefix: aPrefix localName: self localName.
]

{ #category : #accessing }
XMLNamespacedName >> qualifiedName [
	^ qualifiedName ifNil: ['']
]

{ #category : #accessing }
XMLNamespacedName >> qualifiedName: aQualifiedName [
	aQualifiedName
		splitQualifiedNameInto: [:prefixPart :localPart |
			self setPrefix: prefixPart localName: localPart]
]

{ #category : #accessing }
XMLNamespacedName >> scope [
	^ scope ifNil: [scope := XMLNamespaceScope new]
]

{ #category : #accessing }
XMLNamespacedName >> setPrefix: aPrefix localName: aLocalName [
	localName := aLocalName.
	(aPrefix isEmptyOrNil or: [aPrefix = 'xmlns'])
		ifTrue: [
			prefix := nil.
			qualifiedName := localName]
		ifFalse: [
			self scope validatePrefix: aPrefix.
			prefix := aPrefix.
			qualifiedName := prefix qualifyName: localName].
]

{ #category : #accessing }
XMLNamespacedName >> setScope: aScope [
	scope := aScope
]
