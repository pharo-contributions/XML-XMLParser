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
DTDExternalEntityResolver >> combineURI: aBaseUri with: aRelativeUri [
	| baseUri combinedUri |

	baseUri := XMLURI fromString: aBaseUri.
	combinedUri := baseUri / aRelativeUri.
	(combinedUri isLocalURI
		and: [baseUri isLocalURI not
			and: [self resolvesLocalFromNonLocal notNil
				and: [self resolvesLocalFromNonLocal not]]])
		ifTrue: [self errorLocalFromNonLocal].

	^ combinedUri.
]

{ #category : #accessing }
DTDExternalEntityResolver >> defaultDocumentURI [
	^ XMLFileHandle currentWorkingDirectory, '/default'
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

{ #category : #configuration }
DTDExternalEntityResolver >> externalEntityLimits [
	^ externalEntityLimits ifNil: [externalEntityLimits := DTDExternalEntityLimits new]
]

{ #category : #configuration }
DTDExternalEntityResolver >> externalSubsetReadLimit [
	^ self externalEntityLimits externalSubsetReadLimit
]

{ #category : #configuration }
DTDExternalEntityResolver >> externalSubsetReadLimit: aLimit [
	self externalEntityLimits externalSubsetReadLimit: aLimit
]

{ #category : #private }
DTDExternalEntityResolver >> incrementEntityTotal [
	totalResolvedEntities := (totalResolvedEntities ifNil: [0]) + 1
]

{ #category : #configuration }
DTDExternalEntityResolver >> maxExternalEntities [
	^ self externalEntityLimits maxExternalEntities
]

{ #category : #configuration }
DTDExternalEntityResolver >> maxExternalEntities: aLimit [
	self externalEntityLimits maxExternalEntities: aLimit
]

{ #category : #configuration }
DTDExternalEntityResolver >> maxExternalEntitySize [
	^ self externalEntityLimits maxExternalEntitySize
]

{ #category : #configuration }
DTDExternalEntityResolver >> maxExternalEntitySize: aLimit [
	self externalEntityLimits maxExternalEntitySize: aLimit
]

{ #category : #configuration }
DTDExternalEntityResolver >> removeLimits [
	self externalEntityLimits removeAll
]

{ #category : #resolving }
DTDExternalEntityResolver >> resolveEntityURI: aUri [
	| readStream |

	self checkExternalEntityLimit.
	readStream := aUri asXMLURI getUpToLimit: self maxExternalEntitySize.
	self incrementEntityTotal.

	^ readStream.
]

{ #category : #private }
DTDExternalEntityResolver >> resolveExternalEntity: aName uri: anEntityUri from: aSourceUri class: aClass [
	| combinedUri replacement replacementStream |

	combinedUri := self combineURI: aSourceUri with: anEntityUri.

	replacementStream := self resolveEntityURI: combinedUri.
	replacement  := replacementStream contents.
	replacementStream close.

	^ aClass
		name: aName
		replacement: replacement
		uri: combinedUri asString.
]

{ #category : #resolving }
DTDExternalEntityResolver >> resolveExternalGeneralEntity: aName uri: anEntityUri from: aSourceUri [
	^ self
		resolveExternalEntity: aName
		uri: anEntityUri
		from: aSourceUri
		class: DTDExternalGeneralEntity
]

{ #category : #resolving }
DTDExternalEntityResolver >> resolveExternalParameterEntity: aName uri: anEntityUri from: aSourceUri [
	^ self
		resolveExternalEntity: aName
		uri: anEntityUri
		from: aSourceUri
		class: DTDExternalParameterEntity
]

{ #category : #configuration }
DTDExternalEntityResolver >> resolvesLocalFromNonLocal [
	^ self externalEntityLimits resolvesLocalFromNonLocal
]

{ #category : #configuration }
DTDExternalEntityResolver >> resolvesLocalFromNonLocal: aBoolean [
	self externalEntityLimits resolvesLocalFromNonLocal: aBoolean
]

{ #category : #private }
DTDExternalEntityResolver >> totalResolvedEntities [
	^ totalResolvedEntities ifNil: [totalResolvedEntities := 0]
]
