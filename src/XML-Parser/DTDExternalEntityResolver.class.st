"
This class resolves external entity references using XMLURI, XMLHTTPRequest, and XMLFileHandle.

The #externalEntityURIFromPublicID:systemID: and #externalEntityURIFromPublicID:systemID:baseURI: convert public IDs and system IDs into resolvable XMLURI objects.

The #resolveExternalEntityURI: and #streamResolveExternalEntityURI: messages can resolve external entity XMLURIs or URI strings as either a string or a stream on the undecoded entity content. If the entity is in a file, then #streamResolveExternalEntityURI: can be used to avoid storing it in-memory, but if it's fetched over HTTP, it will just return a stream on the entire in-memory HTTP response.
"
Class {
	#name : #DTDExternalEntityResolver,
	#superclass : #Object,
	#instVars : [
		'externalEntityLimits'
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
DTDExternalEntityResolver >> errorLocalFromNonLocal [
	XMLLimitException signal:
		'Local URI referenced from non-local URI; ',
		'use #resolvesLocalFromNonLocal: to change'
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
DTDExternalEntityResolver >> externalSubsetReadLimit: anInteger [
	"change the external subset read limit or nil to disable"

	self externalEntityLimits externalSubsetReadLimit: anInteger
]

{ #category : #configuring }
DTDExternalEntityResolver >> maxExternalEntities [
	^ self externalEntityLimits maxExternalEntities
]

{ #category : #configuring }
DTDExternalEntityResolver >> maxExternalEntities: anInteger [
	self externalEntityLimits maxExternalEntities: anInteger
]

{ #category : #configuring }
DTDExternalEntityResolver >> maxExternalEntitySize [
	^ self externalEntityLimits maxExternalEntitySize
]

{ #category : #configuring }
DTDExternalEntityResolver >> maxExternalEntitySize: anInteger [
	self externalEntityLimits maxExternalEntitySize: anInteger
]

{ #category : #copying }
DTDExternalEntityResolver >> postCopy [
	super postCopy.

	externalEntityLimits
		ifNotNil: [externalEntityLimits := externalEntityLimits copy].
]

{ #category : #configuring }
DTDExternalEntityResolver >> removeLimits [
	self externalEntityLimits removeAll
]

{ #category : #resolving }
DTDExternalEntityResolver >> resolveExternalEntityURI: anXMLURIOrURIString [
	^ anXMLURIOrURIString asXMLURI
		getUpToLimit: self maxExternalEntitySize
		decoding: false
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
	^ anXMLURIOrURIString asXMLURI
		streamGetUpToLimit: self maxExternalEntitySize
		decoding: false
]
