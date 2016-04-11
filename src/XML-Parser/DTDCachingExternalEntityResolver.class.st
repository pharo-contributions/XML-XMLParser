"
This class is a resolver that caches non-local entities so they don't have to be retrieved again (like over HTTP). (The default resolver)
"
Class {
	#name : #DTDCachingExternalEntityResolver,
	#superclass : #DTDExternalEntityResolver,
	#classInstVars : [
		'entityCache'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #clearing }
DTDCachingExternalEntityResolver class >> clearEntityCache [
	"self clearEntityCache"
	self entityCache clear
]

{ #category : #accessing }
DTDCachingExternalEntityResolver class >> entityCache [
	^ entityCache ifNil: [entityCache := XMLKeyValueCache maxSize: 64]
]

{ #category : #accessing }
DTDCachingExternalEntityResolver class >> entityCacheAtURI: anXMLURIOrURIString [
	^ self entityCache at: anXMLURIOrURIString asXMLURI
]

{ #category : #accessing }
DTDCachingExternalEntityResolver class >> entityCacheAtURI: anXMLURIOrURIString ifAbsent: aBlock [
	^ self entityCache
		at: anXMLURIOrURIString asXMLURI
		ifAbsent: aBlock
]

{ #category : #accessing }
DTDCachingExternalEntityResolver class >> entityCacheAtURI: anXMLURIOrURIString ifAbsentPut: aBlock [
	^ self entityCache
		at: anXMLURIOrURIString asXMLURI
		ifAbsentPut: aBlock
]

{ #category : #accessing }
DTDCachingExternalEntityResolver class >> entityCacheAtURI: anXMLURIOrURIString put: aReplacement [
	^ self entityCache
		at: anXMLURIOrURIString asXMLURI
		put: aReplacement
]

{ #category : #accessing }
DTDCachingExternalEntityResolver class >> maxCachedEntities [
	^ self entityCache maxSize
]

{ #category : #accessing }
DTDCachingExternalEntityResolver class >> maxCachedEntities: anInteger [
	self entityCache maxSize: anInteger
]

{ #category : #private }
DTDCachingExternalEntityResolver >> cachingResolveEntityURI: anXMLURIOrURIString [
	| uri |

	uri := anXMLURIOrURIString asXMLURI.
	^ self class
		entityCacheAtURI: uri
		ifAbsentPut: [
			self resolveExternalEntityWith: [:maxSize |
				uri
					getUpToLimit: maxSize
					decoding: false]]
]

{ #category : #private }
DTDCachingExternalEntityResolver >> cachingStreamResolveEntityURI: anXMLURIOrURIString [
	^ (self cachingResolveEntityURI: anXMLURIOrURIString) readStream
]

{ #category : #clearing }
DTDCachingExternalEntityResolver >> clearEntityCache [
	self class clearEntityCache
]

{ #category : #accessing }
DTDCachingExternalEntityResolver >> maxCachedEntities [
	^ self class maxCachedEntities
]

{ #category : #accessing }
DTDCachingExternalEntityResolver >> maxCachedEntities: anInteger [
	self class maxCachedEntities: anInteger
]

{ #category : #resolving }
DTDCachingExternalEntityResolver >> resolveExternalEntityURI: anXMLURIOrURIString [
	| uri |

	(uri := anXMLURIOrURIString asXMLURI) isLocalURI
		ifTrue: [^ super resolveExternalEntityURI: uri]
		ifFalse: [
			"non-local entities are cached"
			^ self cachingResolveEntityURI: uri]
]

{ #category : #resolving }
DTDCachingExternalEntityResolver >> streamResolveExternalEntityURI: anXMLURIOrURIString [
	| uri |

	(uri := anXMLURIOrURIString asXMLURI) isLocalURI
		ifTrue: [^ super streamResolveExternalEntityURI: uri]
		ifFalse: [
			"non-local entities are cached"
			^ self cachingStreamResolveEntityURI: uri]
]
