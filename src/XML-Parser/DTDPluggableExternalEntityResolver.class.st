"
This class is a pluggable resolver that maps entity URIs to string replacements so resolution can be done without HTTP or file access. Used during testing.
"
Class {
	#name : #DTDPluggableExternalEntityResolver,
	#superclass : #DTDExternalEntityResolver,
	#instVars : [
		'entities'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #'instance creation' }
DTDPluggableExternalEntityResolver class >> entities: anAssociationCollection [
	^ self new entities: anAssociationCollection
]

{ #category : #private }
DTDPluggableExternalEntityResolver >> entities [
	^ entities ifNil: [entities := Dictionary new]
]

{ #category : #accessing }
DTDPluggableExternalEntityResolver >> entities: anAssociationCollection [
	self hasEntities
		ifTrue: [self removeEntities].
	anAssociationCollection associationsDo: [:each |
		self
			entityAtURI: each key
			put: each value].
]

{ #category : #accessing }
DTDPluggableExternalEntityResolver >> entityAtURI: anXMLURIOrURIString [
	^ self
		entityAtURI: anXMLURIOrURIString asXMLURI
		ifAbsent: ['']
]

{ #category : #accessing }
DTDPluggableExternalEntityResolver >> entityAtURI: anXMLURIOrURIString ifAbsent: aBlock [
	^ self entities
		at: anXMLURIOrURIString asXMLURI
		ifAbsent: aBlock
]

{ #category : #accessing }
DTDPluggableExternalEntityResolver >> entityAtURI: anXMLURIOrURIString ifAbsentPut: aBlock [
	^ self entities
		at: anXMLURIOrURIString asXMLURI
		ifAbsentPut: aBlock
]

{ #category : #accessing }
DTDPluggableExternalEntityResolver >> entityAtURI: anXMLURIOrURIString put: aReplacement [
	^ self entities
		at: anXMLURIOrURIString asXMLURI
		put: aReplacement
]

{ #category : #private }
DTDPluggableExternalEntityResolver >> errorMaxEntitySize: aMaxSize exceededByURI: anXMLURIOrURIString [
	XMLLimitException
		formatSignal: 'Entity exceeds max size of {1} bytes: {2}'
		with: aMaxSize
		with: anXMLURIOrURIString asString
]

{ #category : #private }
DTDPluggableExternalEntityResolver >> errorUnresolvableEntityURI: anXMLURIOrURIString [
	XMLParserException
		formatSignal: 'Unresolvable entity: {1}'
		with: anXMLURIOrURIString asString
]

{ #category : #testing }
DTDPluggableExternalEntityResolver >> hasEntities [
	^ self entities notEmpty
]

{ #category : #testing }
DTDPluggableExternalEntityResolver >> includesEntityURI: anXMLURIOrURIString [
	^ self entities includesKey: anXMLURIOrURIString asXMLURI
]

{ #category : #removing }
DTDPluggableExternalEntityResolver >> removeEntities [
	self entities removeAll
]

{ #category : #removing }
DTDPluggableExternalEntityResolver >> removeEntityURI: anXMLURIOrURIString [
	^ self entities removeKey: anXMLURIOrURIString asXMLURI
]

{ #category : #removing }
DTDPluggableExternalEntityResolver >> removeEntityURI: anXMLURIOrURIString ifAbsent: aBlock [
	^ self entities
		removeKey: anXMLURIOrURIString asXMLURI
		ifAbsent: aBlock
]

{ #category : #resolving }
DTDPluggableExternalEntityResolver >> resolveEntityURI: anXMLURIOrURIString [
	^ self resolveEntityWith: [:maxSize | | replacement |
		replacement :=
			self
				entityAtURI: anXMLURIOrURIString
				ifAbsent: [self errorUnresolvableEntityURI: anXMLURIOrURIString].
		(maxSize notNil
			and: [replacement size > maxSize])
			ifTrue: [
				self
					errorMaxEntitySize: maxSize
					exceededByURI: anXMLURIOrURIString].
		replacement]
]

{ #category : #resolving }
DTDPluggableExternalEntityResolver >> streamResolveEntityURI: anXMLURIOrURIString [
	^ (self resolveEntityURI: anXMLURIOrURIString) readStream
]
