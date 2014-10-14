"
The class represents a name for an element or attribute. It stores the local part and qualified name. You should not need to use this class directly.
"
Class {
	#name : #XMLNodeName,
	#superclass : #Object,
	#instVars : [
		'qualified',
		'localPart'
	],
	#category : #'XML-Parser-DOM'
}

{ #category : #'instance creation' }
XMLNodeName class >> qualified: aQualifiedName [
	^ self new setQualified: aQualifiedName
]

{ #category : #'instance creation' }
XMLNodeName class >> qualified: aQualifiedName localPart: aLocalPart [
	^ self new
		setQualified: aQualifiedName
		localPart: aLocalPart
]

{ #category : #accessing }
XMLNodeName >> expandWith: aUri [
	^ aUri
		ifEmpty: [self localPart]
		ifNotEmpty: ['{', aUri, '}', self localPart]
]

{ #category : #testing }
XMLNodeName >> isPrefixed [
	^ self qualified size > self localPart size
]

{ #category : #testing }
XMLNodeName >> isSameAs: aNameString [
	^ aNameString
		isQualifiedName: self qualified
		orLocalName: self localPart
]

{ #category : #accessing }
XMLNodeName >> localPart [
	^ localPart ifNil: [localPart := self qualified qualifiedNameLocalPart]
]

{ #category : #accessing }
XMLNodeName >> prefix [
	| prefixSize |

	"faster than qualifiedNamePrefix if we already have the localPart"
	(prefixSize := self qualified size - self localPart size - 1) > 0
		ifTrue: [^ qualified copyFrom: 1 to: prefixSize]
		ifFalse: [^ '']
]

{ #category : #accessing }
XMLNodeName >> prefix: aPrefix [
	qualified := 
		aPrefix
			ifEmpty: [self localPart]
			ifNotEmpty: [aPrefix, ':', self localPart]
]

{ #category : #printing }
XMLNodeName >> printOn: aStream [
	aStream nextPutAll: self qualified
]

{ #category : #accessing }
XMLNodeName >> qualified [
	^ qualified ifNil: [qualified := '']
]

{ #category : #accessing }
XMLNodeName >> qualified: aQualifiedName [
	qualified := aQualifiedName.
	localPart := aQualifiedName qualifiedNameLocalPart.
]

{ #category : #initialization }
XMLNodeName >> setQualified: aQualifiedName [
	qualified := aQualifiedName
]

{ #category : #initialization }
XMLNodeName >> setQualified: aQualifiedName localPart: aLocalPart [
	qualified := aQualifiedName.
	localPart := aLocalPart.
]
