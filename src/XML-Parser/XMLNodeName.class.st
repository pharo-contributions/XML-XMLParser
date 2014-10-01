"
The class represents a name for an element or attribute. It stores the prefix, local part and qualified name. It also notifies any observers whenever any part of the name it models changes using #nodeNameChangedFrom:to:. You should not need to use this class directly.
"
Class {
	#name : #XMLNodeName,
	#superclass : #Object,
	#instVars : [
		'qualified',
		'prefix',
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
XMLNodeName class >> qualified: aQualifiedName prefix: aPrefix localPart: aLocalPart [
	^ self new
		setQualified: aQualifiedName
		prefix: aPrefix
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
	^ self prefix notEmpty
]

{ #category : #testing }
XMLNodeName >> isSameAs: aNameString [
	^ self qualified = aNameString
		or: [self prefix size > 0
			and: [self localPart = aNameString]]
]

{ #category : #accessing }
XMLNodeName >> localPart [
	^ localPart ifNil: [
		self setFromQualified.
		localPart]
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
	^ prefix ifNil: [
		self setFromQualified.
		prefix]
]

{ #category : #accessing }
XMLNodeName >> prefix: aPrefix [
	self changeWith: [
		aPrefix isEmptyOrNil
			ifTrue: [
				self
					setQualified: self localPart
					prefix: ''
					localPart: self localPart]
			ifFalse: [
				self
					setQualified: aPrefix, ':', self localPart
					prefix: aPrefix
					localPart: self localPart]]
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
		self setFromQualified]
]

{ #category : #observing }
XMLNodeName >> removeObserver: anObserver [
	self notifier removeObserver: anObserver
]

{ #category : #private }
XMLNodeName >> setFromQualified [
	prefix := self qualified qualifiedNamePrefix.
	localPart := self qualified qualifiedNameLocalPart: prefix.
]

{ #category : #initialization }
XMLNodeName >> setQualified: aQualifiedName [
	qualified := aQualifiedName
]

{ #category : #initialization }
XMLNodeName >> setQualified: aQualifiedName prefix: aPrefix localPart: aLocalPart [
	qualified := aQualifiedName.
	prefix := aPrefix.
	localPart := aLocalPart.
]
