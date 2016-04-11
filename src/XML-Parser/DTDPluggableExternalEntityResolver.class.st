"
This class is a pluggable resolver that maps entity URIs to string replacements so resolution can be done without HTTP or file access. Used during testing.
"
Class {
	#name : #DTDPluggableExternalEntityResolver,
	#superclass : #DTDExternalEntityResolver,
	#instVars : [
		'externalEntities'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #'instance creation' }
DTDPluggableExternalEntityResolver class >> externalEntities: anAssociationCollection [
	^ self new externalEntities: anAssociationCollection
]

{ #category : #private }
DTDPluggableExternalEntityResolver >> errorMaxExternalEntitySize: aMaxSize exceededByURI: anXMLURIOrURIString [
	XMLLimitException
		formatSignal: 'Entity exceeds max size of {1} bytes: {2}'
		with: aMaxSize
		with: anXMLURIOrURIString asString
]

{ #category : #private }
DTDPluggableExternalEntityResolver >> errorUnresolvableExternalEntityURI: anXMLURIOrURIString [
	XMLParserException
		formatSignal: 'Unresolvable external entity URI: {1}'
		with: anXMLURIOrURIString asString
]

{ #category : #private }
DTDPluggableExternalEntityResolver >> externalEntities [
	^ externalEntities ifNil: [externalEntities := Dictionary new]
]

{ #category : #accessing }
DTDPluggableExternalEntityResolver >> externalEntities: anAssociationCollection [
	self hasExternalEntities
		ifTrue: [self removeExternalEntities].
	anAssociationCollection associationsDo: [:each |
		self
			externalEntityAtURI: each key
			put: each value].
]

{ #category : #accessing }
DTDPluggableExternalEntityResolver >> externalEntityAtURI: anXMLURIOrURIString [
	^ self
		externalEntityAtURI: anXMLURIOrURIString asXMLURI
		ifAbsent: ['']
]

{ #category : #accessing }
DTDPluggableExternalEntityResolver >> externalEntityAtURI: anXMLURIOrURIString ifAbsent: aBlock [
	^ self externalEntities
		at: anXMLURIOrURIString asXMLURI
		ifAbsent: aBlock
]

{ #category : #accessing }
DTDPluggableExternalEntityResolver >> externalEntityAtURI: anXMLURIOrURIString ifAbsentPut: aBlock [
	^ self externalEntities
		at: anXMLURIOrURIString asXMLURI
		ifAbsentPut: aBlock
]

{ #category : #accessing }
DTDPluggableExternalEntityResolver >> externalEntityAtURI: anXMLURIOrURIString put: aReplacement [
	^ self externalEntities
		at: anXMLURIOrURIString asXMLURI
		put: aReplacement
]

{ #category : #testing }
DTDPluggableExternalEntityResolver >> hasExternalEntities [
	^ self externalEntities notEmpty
]

{ #category : #testing }
DTDPluggableExternalEntityResolver >> includesExternalEntityURI: anXMLURIOrURIString [
	^ self externalEntities includesKey: anXMLURIOrURIString asXMLURI
]

{ #category : #removing }
DTDPluggableExternalEntityResolver >> removeExternalEntities [
	self externalEntities removeAll
]

{ #category : #removing }
DTDPluggableExternalEntityResolver >> removeExternalEntityURI: anXMLURIOrURIString [
	^ self externalEntities removeKey: anXMLURIOrURIString asXMLURI
]

{ #category : #removing }
DTDPluggableExternalEntityResolver >> removeExternalEntityURI: anXMLURIOrURIString ifAbsent: aBlock [
	^ self externalEntities
		removeKey: anXMLURIOrURIString asXMLURI
		ifAbsent: aBlock
]

{ #category : #resolving }
DTDPluggableExternalEntityResolver >> resolveExternalEntityURI: anXMLURIOrURIString [
	^ self resolveExternalEntityWith: [:maxSize | | replacement |
		replacement :=
			self
				externalEntityAtURI: anXMLURIOrURIString
				ifAbsent: [self errorUnresolvableExternalEntityURI: anXMLURIOrURIString].
		(maxSize notNil
			and: [replacement size > maxSize])
			ifTrue: [
				self
					errorMaxExternalEntitySize: maxSize
					exceededByURI: anXMLURIOrURIString].
		replacement]
]

{ #category : #resolving }
DTDPluggableExternalEntityResolver >> streamResolveExternalEntityURI: anXMLURIOrURIString [
	^ (self resolveExternalEntityURI: anXMLURIOrURIString) readStream
]
