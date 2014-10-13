"
The class represents a name for an element or attribute. It stores the local part and qualified name. It also notifies any observers whenever any part of the name it models changes using #nodeNameChangedFrom:to:. You should not need to use this class directly.
"
Class {
	#name : #XMLNodeName,
	#superclass : #Object,
	#instVars : [
		'qualified',
		'localPart',
		'notifier'
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

{ #category : #observing }
XMLNodeName >> addObserver: anObserver [
	self notifier addObserver: anObserver
]

{ #category : #private }
XMLNodeName >> changeWith: aBlock [
	| oldName newName |

	oldName := self qualified.
	aBlock value.
	newName := self qualified.
	newName = oldName
		ifFalse: [self notifyOf: #nodeNameChangedFrom:to: with: oldName with: newName].
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

{ #category : #private }
XMLNodeName >> notifier [
	^ notifier ifNil: [notifier := XMLNotifier new]
]

{ #category : #notification }
XMLNodeName >> notifyOf: aSelector with: anArgument [
	self notifier notifyOf: aSelector with: anArgument
]

{ #category : #notification }
XMLNodeName >> notifyOf: aSelector with: aFirstArgument with: aSecondArgument [
	self notifier notifyOf: aSelector with: aFirstArgument with: aSecondArgument
]

{ #category : #notification }
XMLNodeName >> notifyOf: aSelector with: aFirstArgument with: aSecondArgument with: aThirdArgument [
	self notifier
		notifyOf: aSelector
		with: aFirstArgument
		with: aSecondArgument
		with: aThirdArgument
]

{ #category : #notification }
XMLNodeName >> notifyOf: aSelector withArguments: anArray [
	self notifier notifyOf: aSelector withArguments: anArray
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
	self changeWith: [
		qualified := 
			aPrefix
				ifEmpty: [self localPart]
				ifNotEmpty: [aPrefix, ':', self localPart]]
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
	self changeWith: [
		qualified := aQualifiedName.
		localPart := aQualifiedName qualifiedNameLocalPart]
]

{ #category : #observing }
XMLNodeName >> removeObserver: anObserver [
	self notifier removeObserver: anObserver
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
