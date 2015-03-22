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
DTDExternalEntityResolver >> combineURI: aBaseURI with: aRelativeURI [
	| baseURI combinedURI |

	baseURI := XMLURI fromString: aBaseURI.
	combinedURI := baseURI / aRelativeURI.
	(combinedURI isLocalURI
		and: [baseURI isLocalURI not
			and: [self resolvesLocalFromNonLocal notNil
				and: [self resolvesLocalFromNonLocal not]]])
		ifTrue: [self errorLocalFromNonLocal].

	^ combinedURI.
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

{ #category : #configuring }
DTDExternalEntityResolver >> removeLimits [
	self externalEntityLimits removeAll
]

{ #category : #resolving }
DTDExternalEntityResolver >> resolveEntityURI: aURI [
	| readStream |

	self checkExternalEntityLimit.
	readStream := aURI asXMLURI getUpToLimit: self maxExternalEntitySize.
	self incrementEntityTotal.

	^ readStream.
]

{ #category : #private }
DTDExternalEntityResolver >> resolveExternalEntity: aName uri: anEntityURI from: aSourceURI class: aClass [
	| combinedURI replacement replacementStream |

	combinedURI := self combineURI: aSourceURI with: anEntityURI.

	replacementStream := self resolveEntityURI: combinedURI.
	replacement  := replacementStream contents.
	replacementStream close.

	^ aClass
		name: aName
		replacement: replacement
		uri: combinedURI asString.
]

{ #category : #resolving }
DTDExternalEntityResolver >> resolveExternalGeneralEntity: aName uri: anEntityURI from: aSourceURI [
	^ self
		resolveExternalEntity: aName
		uri: anEntityURI
		from: aSourceURI
		class: DTDExternalGeneralEntity
]

{ #category : #resolving }
DTDExternalEntityResolver >> resolveExternalParameterEntity: aName uri: anEntityURI from: aSourceURI [
	^ self
		resolveExternalEntity: aName
		uri: anEntityURI
		from: aSourceURI
		class: DTDExternalParameterEntity
]

{ #category : #configuring }
DTDExternalEntityResolver >> resolvesLocalFromNonLocal [
	^ self externalEntityLimits resolvesLocalFromNonLocal
]

{ #category : #configuring }
DTDExternalEntityResolver >> resolvesLocalFromNonLocal: aBoolean [
	self externalEntityLimits resolvesLocalFromNonLocal: aBoolean
]

{ #category : #private }
DTDExternalEntityResolver >> totalResolvedEntities [
	^ totalResolvedEntities ifNil: [totalResolvedEntities := 0]
]
