"
This class resolves external entity references using XMLURI, XMLHTTPRequest, and XMLFileHandle.
"
Class {
	#name : #DTDExternalEntityResolver,
	#superclass : #Object,
	#instVars : [
		'externalEntityLimits',
		'totalResolvedEntities'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #private }
DTDExternalEntityResolver >> checkExternalEntityLimit [
	(self maxExternalEntities notNil
		and: [self totalResolvedEntities + 1 > self maxExternalEntities])
		ifTrue: [self erorrExternalEntityLimitExceeded]
]

{ #category : #combining }
DTDExternalEntityResolver >> combineSourceURI: aSourceURIOrURIString withEntityURI: anEntityURIOrURIString [
	| sourceURI combinedURI |

	sourceURI := aSourceURIOrURIString asXMLURI.
	combinedURI := sourceURI / anEntityURIOrURIString.
	(combinedURI isLocalURI
		and: [sourceURI isLocalURI not
			and: [self resolvesLocalFromNonLocal not]])
		ifTrue: [self errorLocalFromNonLocal].

	^ combinedURI.
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
DTDExternalEntityResolver >> externalSubsetReadLimit [
	^ self externalEntityLimits externalSubsetReadLimit
]

{ #category : #configuring }
DTDExternalEntityResolver >> externalSubsetReadLimit: aLimit [
	"change the external subset read limit or nil to disable"

	self externalEntityLimits externalSubsetReadLimit: aLimit
]

{ #category : #private }
DTDExternalEntityResolver >> incrementEntityTotal [
	totalResolvedEntities := (totalResolvedEntities ifNil: [0]) + 1
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

	totalResolvedEntities := 0.
	externalEntityLimits
		ifNotNil: [externalEntityLimits := externalEntityLimits copy].
]

{ #category : #configuring }
DTDExternalEntityResolver >> removeLimits [
	self externalEntityLimits removeAll
]

{ #category : #resolving }
DTDExternalEntityResolver >> resolveEntityURI: aURIOrURIString [
	^ self resolveEntityWith: [:maxSize |
		aURIOrURIString asXMLURI
			getUpToLimit: maxSize
			decoding: false]
]

{ #category : #private }
DTDExternalEntityResolver >> resolveEntityWith: aBlock [
	| result |

	self checkExternalEntityLimit.
	result := aBlock value: self maxExternalEntitySize.
	self incrementEntityTotal.

	^ result.
]

{ #category : #private }
DTDExternalEntityResolver >> resolveExternalEntity: aName publicID: aPublicID systemID: aSystemID from: aSourceURIString class: aClass [
	| combinedURI |

	combinedURI :=
		self
			combineSourceURI: aSourceURIString
			withEntityURI: aSystemID.

	^ aClass
		name: aName
		replacement: (self resolveEntityURI: combinedURI)
		uri: combinedURI asString.
]

{ #category : #resolving }
DTDExternalEntityResolver >> resolveExternalGeneralEntity: aName publicID: aPublicID systemID: aSystemID from: aSourceURIString [
	^ self
		resolveExternalEntity: aName
		publicID: aPublicID
		systemID: aSystemID
		from: aSourceURIString
		class: DTDExternalGeneralEntity
]

{ #category : #resolving }
DTDExternalEntityResolver >> resolveExternalParameterEntity: aName publicID: aPublicID systemID: aSystemID from: aSourceURIString [
	^ self
		resolveExternalEntity: aName
		publicID: aPublicID
		systemID: aSystemID
		from: aSourceURIString
		class: DTDExternalParameterEntity
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
DTDExternalEntityResolver >> streamResolveEntityURI: aURIOrURIString [
	^ self resolveEntityWith: [:maxSize |
		aURIOrURIString asXMLURI
			streamGetUpToLimit: maxSize
			decoding: false]
]

{ #category : #private }
DTDExternalEntityResolver >> totalResolvedEntities [
	^ totalResolvedEntities ifNil: [totalResolvedEntities := 0]
]
