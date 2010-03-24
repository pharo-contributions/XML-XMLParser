"
The class represents a name for an element or attribute.
"
Class {
	#name : #XMLNodeName,
	#superclass : #Object,
	#instVars : [
		'qualifiedName',
		'prefix',
		'localName'
	],
	#category : #'XML-Parser-Nodes'
}

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
	aPrefix isEmptyOrNil
		ifTrue: [
			self
				setQualifiedName: aLocalName
				prefix: nil
				localName: aLocalName]
		ifFalse: [
			self
				setQualifiedName: aPrefix, ':', aLocalName
				prefix: aPrefix
				localName: aLocalName]
]

{ #category : #private }
XMLNodeName >> setQualifiedName: aQualifiedName prefix: aPrefix localName: aLocalName [
	qualifiedName := aQualifiedName.
	prefix := aPrefix.
	localName := aLocalName.
]
