"
This class is an adapter for DTDExternalEntityResolvers that limits the number of entities that can be resolved. This is not handled directly by resolvers to make them less stateful and more reusable.
"
Class {
	#name : #DTDLimitedExternalEntityResolverAdapter,
	#superclass : #Object,
	#instVars : [
		'externalEntityResolver',
		'totalResolvedExternalEntities'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #'instance creation' }
DTDLimitedExternalEntityResolverAdapter class >> externalEntityResolver: anExternalEntityResolver [
	^ self new externalEntityResolver: anExternalEntityResolver
]

{ #category : #private }
DTDLimitedExternalEntityResolverAdapter >> checkExternalEntityLimit [
	| maxExternalEntities |

	((maxExternalEntities := self externalEntityResolver maxExternalEntities) notNil
		and: [self totalResolvedExternalEntities >= maxExternalEntities])
		ifTrue: [self erorrExternalEntityLimitExceeded]
]

{ #category : #private }
DTDLimitedExternalEntityResolverAdapter >> erorrExternalEntityLimitExceeded [
	XMLLimitException signal:
		'External entity limit exceeded; ',
		'use #maxExternalEntities: to change or disable'
]

{ #category : #configuring }
DTDLimitedExternalEntityResolverAdapter >> externalEntityLimits [
	^ self externalEntityResolver externalEntityLimits
]

{ #category : #configuring }
DTDLimitedExternalEntityResolverAdapter >> externalEntityLimits: anExternalEntityLimits [
	self externalEntityResolver externalEntityLimits: anExternalEntityLimits
]

{ #category : #accessing }
DTDLimitedExternalEntityResolverAdapter >> externalEntityResolver [
	^ externalEntityResolver
]

{ #category : #accessing }
DTDLimitedExternalEntityResolverAdapter >> externalEntityResolver: anExternalEntityResolver [
	externalEntityResolver := anExternalEntityResolver
]

{ #category : #resolving }
DTDLimitedExternalEntityResolverAdapter >> externalEntityURIFromPublicID: aPublicID systemID: aSystemID [
	^ self externalEntityResolver
		externalEntityURIFromPublicID: aPublicID
		systemID: aSystemID
]

{ #category : #resolving }
DTDLimitedExternalEntityResolverAdapter >> externalEntityURIFromPublicID: aPublicID systemID: aSystemID baseURI: aBaseXMLURIOrURIString [
	^ self externalEntityResolver
		externalEntityURIFromPublicID: aPublicID
		systemID: aSystemID
		baseURI: aBaseXMLURIOrURIString
]

{ #category : #configuring }
DTDLimitedExternalEntityResolverAdapter >> externalSubsetReadLimit [
	^ self externalEntityResolver externalSubsetReadLimit
]

{ #category : #configuring }
DTDLimitedExternalEntityResolverAdapter >> externalSubsetReadLimit: anInteger [
	self externalEntityResolver externalSubsetReadLimit: anInteger
]

{ #category : #private }
DTDLimitedExternalEntityResolverAdapter >> incrementTotalResolvedExternalEntities [
	totalResolvedExternalEntities :=
		totalResolvedExternalEntities
			ifNil: [1]
			ifNotNil: [totalResolvedExternalEntities + 1]
]

{ #category : #configuring }
DTDLimitedExternalEntityResolverAdapter >> maxExternalEntities [
	^ self externalEntityResolver maxExternalEntities
]

{ #category : #configuring }
DTDLimitedExternalEntityResolverAdapter >> maxExternalEntities: anInteger [
	self externalEntityResolver maxExternalEntities: anInteger
]

{ #category : #configuring }
DTDLimitedExternalEntityResolverAdapter >> maxExternalEntitySize [
	^ self externalEntityResolver maxExternalEntitySize
]

{ #category : #configuring }
DTDLimitedExternalEntityResolverAdapter >> maxExternalEntitySize: anInteger [
	self externalEntityResolver maxExternalEntitySize: anInteger
]

{ #category : #configuring }
DTDLimitedExternalEntityResolverAdapter >> removeLimits [
	self externalEntityResolver removeLimits
]

{ #category : #resolving }
DTDLimitedExternalEntityResolverAdapter >> resolveExternalEntityURI: anXMLURIOrURIString [
	^ self resolveExternalEntityWith: [
		self externalEntityResolver resolveExternalEntityURI:
			anXMLURIOrURIString]
]

{ #category : #private }
DTDLimitedExternalEntityResolverAdapter >> resolveExternalEntityWith: aBlock [
	| result |

	self checkExternalEntityLimit.
	result := aBlock value.
	self incrementTotalResolvedExternalEntities.

	^ result.
]

{ #category : #configuring }
DTDLimitedExternalEntityResolverAdapter >> resolvesLocalFromNonLocal [
	^ self externalEntityResolver resolvesLocalFromNonLocal
]

{ #category : #configuring }
DTDLimitedExternalEntityResolverAdapter >> resolvesLocalFromNonLocal: aBoolean [
	self externalEntityResolver resolvesLocalFromNonLocal: aBoolean
]

{ #category : #resolving }
DTDLimitedExternalEntityResolverAdapter >> streamResolveExternalEntityURI: anXMLURIOrURIString [
	^ self resolveExternalEntityWith: [
		self externalEntityResolver streamResolveExternalEntityURI:
			anXMLURIOrURIString]
]

{ #category : #accessing }
DTDLimitedExternalEntityResolverAdapter >> totalResolvedExternalEntities [
	^ totalResolvedExternalEntities ifNil: [totalResolvedExternalEntities := 0]
]
