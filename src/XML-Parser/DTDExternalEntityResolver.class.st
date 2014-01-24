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
		ifTrue: [XMLLimitException signal: 'External entity limit exceeded'].
]

{ #category : #combining }
DTDExternalEntityResolver >> combineURI: aBaseUri with: aRelativeUri [
	| baseUri combinedUri |

	baseUri := XMLURI fromString: aBaseUri.
	combinedUri := baseUri / aRelativeUri.
	(combinedUri isLocalURI and: [baseUri isLocalURI not])
		ifTrue: [XMLLimitException signal: 'Local URI referenced from non-local URI'].

	^ combinedUri.
]

{ #category : #accessing }
DTDExternalEntityResolver >> defaultDocumentURI [
	^ XMLFileHandle currentWorkingDirectory, '/default'
]

{ #category : #private }
DTDExternalEntityResolver >> externalEntityLimits [
	^ externalEntityLimits ifNil: [externalEntityLimits := DTDExternalEntityLimits new]
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
	| combinedUri replacement |

	combinedUri := self combineURI: aSourceUri with: anEntityUri.
	replacement := self resolveEntityURI: combinedUri.
	^ aClass
		name: aName
		replacement: replacement contents
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

{ #category : #private }
DTDExternalEntityResolver >> totalResolvedEntities [
	^ totalResolvedEntities ifNil: [totalResolvedEntities := 0]
]
