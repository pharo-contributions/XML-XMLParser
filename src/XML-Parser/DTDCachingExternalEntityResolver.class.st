"
This resolver can cache non-local entities so they don't have to be retrieved again (like over HTTP). (The default resolver)
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
DTDCachingExternalEntityResolver class >> entityCacheAt: aURI [
	^ self entityCache at: aURI
]

{ #category : #accessing }
DTDCachingExternalEntityResolver class >> entityCacheAt: aURI ifAbsent: aBlock [
	^ self entityCache
		at: aURI
		ifAbsent: aBlock
]

{ #category : #accessing }
DTDCachingExternalEntityResolver class >> entityCacheAt: aURI ifAbsentPut: aBlock [
	^ self entityCache
		at: aURI
		ifAbsentPut: aBlock
]

{ #category : #accessing }
DTDCachingExternalEntityResolver class >> entityCacheAt: aURI put: anEntity [
	^ self entityCache
		at: aURI
		put: anEntity
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
DTDCachingExternalEntityResolver >> cachingResolveEntityURI: aURIOrURIString [
	| uri |

	uri := aURIOrURIString asXMLURI.
	^ self class
		entityCacheAt: uri
		ifAbsentPut: [
			self resolveEntityWith: [:maxSize |
				uri
					getUpToLimit: maxSize
					decoding: false]]
]

{ #category : #private }
DTDCachingExternalEntityResolver >> cachingStreamResolveEntityURI: aURIOrURIString [
	^ (self cachingResolveEntityURI: aURIOrURIString) readStream
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
DTDCachingExternalEntityResolver >> resolveEntityURI: aURIOrURIString [
	| uri |

	(uri := aURIOrURIString asXMLURI) isLocalURI
		ifTrue: [^ super resolveEntityURI: uri]
		ifFalse: [^ self cachingResolveEntityURI: uri]
]

{ #category : #resolving }
DTDCachingExternalEntityResolver >> streamResolveEntityURI: aURIOrURIString [
	| uri |

	(uri := aURIOrURIString asXMLURI) isLocalURI
		ifTrue: [^ super streamResolveEntityURI: uri]
		ifFalse: [^ self cachingStreamResolveEntityURI: uri]
]
