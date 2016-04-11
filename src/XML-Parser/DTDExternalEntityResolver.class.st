"
This class resolves external entity references using XMLURI, XMLHTTPRequest, and XMLFileHandle.

It supports retrieving external general entities as DTDExternalGeneralEntity objects with #resolveExternalGeneralEntity:publicID:systemID:baseURI: and external parameter entities as DTDExternalParameterEntity objects with #resolveExternalParameterEntity:publicID:systemID:baseURI:.

#resolveExternalEntityURI: and  #streamResolveExternalEntityURI: messages can resolve generic external entity URIs as strings or read streams.
"
Class {
	#name : #DTDExternalEntityResolver,
	#superclass : #Object,
	#instVars : [
		'externalEntityLimits',
		'totalResolvedExternalEntities'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #'instance creation' }
DTDExternalEntityResolver class >> default [
	^ self defaultClass new
]

{ #category : #accessing }
DTDExternalEntityResolver class >> defaultClass [
	^ DTDCachingExternalEntityResolver
]

{ #category : #private }
DTDExternalEntityResolver >> checkExternalEntityLimit [
	(self maxExternalEntities notNil
		and: [self totalResolvedExternalEntities >= self maxExternalEntities])
		ifTrue: [self erorrExternalEntityLimitExceeded]
]

{ #category : #private }
DTDExternalEntityResolver >> erorrExternalEntityLimitExceeded [
	XMLLimitException signal: 'External entity limit exceeded; use #maxExternalEntities: to change'
]

{ #category : #private }
DTDExternalEntityResolver >> errorLocalFromNonLocal [
	XMLLimitException signal:
		'Local URI referenced from non-local URI; use #resolvesLocalFromNonLocal: to change'
]

{ #category : #configuring }
DTDExternalEntityResolver >> externalEntityLimits [
	^ externalEntityLimits ifNil: [externalEntityLimits := DTDExternalEntityLimits new]
]

{ #category : #configuring }
DTDExternalEntityResolver >> externalEntityLimits: anExternalEntityLimits [
	externalEntityLimits := anExternalEntityLimits
]

{ #category : #resolving }
DTDExternalEntityResolver >> externalEntityURIFromPublicID: aPublicID systemID: aSystemID [
	^ aSystemID asXMLURI
]

{ #category : #resolving }
DTDExternalEntityResolver >> externalEntityURIFromPublicID: aPublicID systemID: aSystemID baseURI: aBaseXMLURIOrURIString [
	| baseURI externalEntityURI |

	baseURI := aBaseXMLURIOrURIString asXMLURI.
	externalEntityURI :=
		baseURI combinedWith:
			(self
				externalEntityURIFromPublicID: aPublicID
				systemID: aSystemID).
	(externalEntityURI isLocalURI
		and: [baseURI isLocalURI not
			and: [self resolvesLocalFromNonLocal not]])
		ifTrue: [self errorLocalFromNonLocal].

	^ externalEntityURI.
]

{ #category : #configuring }
DTDExternalEntityResolver >> externalSubsetReadLimit [
	^ self externalEntityLimits externalSubsetReadLimit
]

{ #category : #configuring }
DTDExternalEntityResolver >> externalSubsetReadLimit: aLimit [
	"change the external subset read limit or nil to disable"

	self externalEntityLimits externalSubsetReadLimit: aLimit
]

{ #category : #private }
DTDExternalEntityResolver >> incrementTotalResolvedExternalEntities [
	totalResolvedExternalEntities :=
		totalResolvedExternalEntities
			ifNil: [1]
			ifNotNil: [totalResolvedExternalEntities + 1]
]

{ #category : #configuring }
DTDExternalEntityResolver >> maxExternalEntities [
	^ self externalEntityLimits maxExternalEntities
]

{ #category : #configuring }
DTDExternalEntityResolver >> maxExternalEntities: aLimit [
	self externalEntityLimits maxExternalEntities: aLimit
]

{ #category : #configuring }
DTDExternalEntityResolver >> maxExternalEntitySize [
	^ self externalEntityLimits maxExternalEntitySize
]

{ #category : #configuring }
DTDExternalEntityResolver >> maxExternalEntitySize: aLimit [
	self externalEntityLimits maxExternalEntitySize: aLimit
]

{ #category : #copying }
DTDExternalEntityResolver >> postCopy [
	super postCopy.

	totalResolvedExternalEntities := 0.
	externalEntityLimits
		ifNotNil: [externalEntityLimits := externalEntityLimits copy].
]

{ #category : #configuring }
DTDExternalEntityResolver >> removeLimits [
	self externalEntityLimits removeAll
]

{ #category : #resolving }
DTDExternalEntityResolver >> resolveExternalEntityURI: anXMLURIOrURIString [
	^ self resolveExternalEntityWith: [:maxSize |
		anXMLURIOrURIString asXMLURI
			getUpToLimit: maxSize
			decoding: false]
]

{ #category : #private }
DTDExternalEntityResolver >> resolveExternalEntityWith: aBlock [
	| result |

	self checkExternalEntityLimit.
	result := aBlock value: self maxExternalEntitySize.
	self incrementTotalResolvedExternalEntities.

	^ result.
]

{ #category : #configuring }
DTDExternalEntityResolver >> resolvesLocalFromNonLocal [
	^ self externalEntityLimits resolvesLocalFromNonLocal
]

{ #category : #configuring }
DTDExternalEntityResolver >> resolvesLocalFromNonLocal: aBoolean [
	"allow non-local (http) entities to reference local (file) entities?
	(default disabled)"

	self externalEntityLimits resolvesLocalFromNonLocal: aBoolean
]

{ #category : #resolving }
DTDExternalEntityResolver >> streamResolveExternalEntityURI: anXMLURIOrURIString [
	^ self resolveExternalEntityWith: [:maxSize |
		anXMLURIOrURIString asXMLURI
			streamGetUpToLimit: maxSize
			decoding: false]
]

{ #category : #accessing }
DTDExternalEntityResolver >> totalResolvedExternalEntities [
	^ totalResolvedExternalEntities ifNil: [totalResolvedExternalEntities := 0]
]
