"
The class represents a name for an element or attribute that can be associated with a namespace.
"
Class {
	#name : #XMLNodeName,
	#superclass : #Object,
	#instVars : [
		'qualifiedName',
		'localName',
		'prefix'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #'instance creation' }
XMLNodeName class >> prefix: aPrefix localName: aLocalName [
	^ self new setPrefix: aPrefix localName: aLocalName
]

{ #category : #converting }
XMLNodeName >> asString [
	^ self qualifiedName
]

{ #category : #accessing }
XMLNodeName >> expandedWith: aUri [
	^ aUri
		ifNil: [self localName]
		ifNotNil: ['{', aUri, '}', self localName]
]

{ #category : #testing }
XMLNodeName >> hasPrefix [
	^ prefix notNil
]

{ #category : #accessing }
XMLNodeName >> localName [
	^ localName ifNil: ['']
]

{ #category : #accessing }
XMLNodeName >> name: aQualifiedName [
	aQualifiedName
		splitQualifiedNameInto: [:prefixPart :localPart |
			self setPrefix: prefixPart localName: localPart]
]

{ #category : #accessing }
XMLNodeName >> prefix [
	^ prefix
]

{ #category : #accessing }
XMLNodeName >> prefix: aPrefix [
	self setPrefix: aPrefix localName: self localName
]

{ #category : #printing }
XMLNodeName >> printOn: aStream [
	aStream nextPutAll: self qualifiedName
]

{ #category : #accessing }
XMLNodeName >> qualifiedName [
	^ qualifiedName ifNil: ['']
]

{ #category : #private }
XMLNodeName >> setPrefix: aPrefix localName: aLocalName [
	localName := aLocalName.
	aPrefix isEmptyOrNil
		ifTrue: [
			prefix := nil.
			qualifiedName := localName]
		ifFalse: [
			prefix := aPrefix.
			qualifiedName := prefix, ':', localName].
]
