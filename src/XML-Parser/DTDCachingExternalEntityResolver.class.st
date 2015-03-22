"
This resolver can cache entities so they don't have to be retrieved again (like over HTTP). (The default resolver)
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

{ #category : #private }
DTDCachingExternalEntityResolver class >> entityCache [
	^ entityCache ifNil: [entityCache := XMLKeyValueCache maxSize: 64]
]

{ #category : #private }
DTDCachingExternalEntityResolver class >> entityCacheAt: aURI ifAbsentPut: aBlock [
	^ self entityCache
		at: aURI
		ifAbsentPut: aBlock
]

{ #category : #private }
DTDCachingExternalEntityResolver class >> entityCacheAt: aURI put: anEntity [
	^ self entityCache
		at: aURI
		put: anEntity.
]

{ #category : #accessing }
DTDCachingExternalEntityResolver class >> maxCachedEntities [
	^ self entityCache maxSize
]

{ #category : #accessing }
DTDCachingExternalEntityResolver class >> maxCachedEntities: anInteger [
	self entityCache maxSize: anInteger
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
DTDCachingExternalEntityResolver >> resolveEntityURI: aURI [
	| uri |

	^ (uri := aURI asXMLURI) isLocalURI
		ifTrue: [super resolveEntityURI: uri]
		ifFalse: [
			(self class
				entityCacheAt: uri
				ifAbsentPut: [(super resolveEntityURI: uri) contents])
					readStream]
]
