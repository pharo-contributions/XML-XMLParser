"
The class represents a name for an element or attribute. It stores the prefix, local part and qualified name. It also notifies any observers whenever any part of the name it models changes.
"
Class {
	#name : #XMLNodeName,
	#superclass : #Object,
	#traits : 'TXMLObservable',
	#classTraits : 'TXMLObservable classTrait',
	#instVars : [
		'qualified',
		'prefix',
		'localPart',
		'notifier'
	],
	#category : #'XML-Parser-Nodes'
}

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
	^ self qualified = aNameString or: [self localPart = aNameString]
]

{ #category : #accessing }
XMLNodeName >> localPart [
	^ localPart ifNil: [localPart := '']
]

{ #category : #accessing }
XMLNodeName >> localPart: aLocalPart [
	self changeWith: [self setPrefix: self prefix localPart: aLocalPart]
]

{ #category : #accessing }
XMLNodeName >> notifier [
	^ notifier ifNil: [notifier := XMLNotifier new]
]

{ #category : #accessing }
XMLNodeName >> prefix [
	^ prefix ifNil: [prefix := '']
]

{ #category : #accessing }
XMLNodeName >> prefix: aPrefix [
	self changeWith: [self setPrefix: aPrefix localPart: self localPart]
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
	aQualifiedName splitQualifiedNameInto: [:prefixPart :localName |
		self changeWith: [self setPrefix: prefixPart localPart: localName]]
]

{ #category : #private }
XMLNodeName >> setPrefix: aPrefix localPart: aLocalPart [
	aPrefix isEmptyOrNil
		ifTrue: [
			self
				setQualified: aLocalPart
				prefix: ''
				localPart: aLocalPart]
		ifFalse: [
			self
				setQualified: aPrefix, ':', aLocalPart
				prefix: aPrefix
				localPart: aLocalPart]
]

{ #category : #private }
XMLNodeName >> setQualified: aQualifiedName prefix: aPrefix localPart: aLocalPart [
	qualified := aQualifiedName.
	prefix := aPrefix.
	localPart := aLocalPart.
]
