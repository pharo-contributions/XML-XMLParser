"
This resolver can cache entities so they don't have to be retrieved again (like over HTTP).
"
Class {
	#name : #DTDCachingEntityResolver,
	#superclass : #DTDExternalEntityResolver,
	#classInstVars : [
		'entityCache'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #clearing }
DTDCachingEntityResolver class >> clearEntityCache [
	"self clearEntityCache"
	self entityCache clear
]

{ #category : #private }
DTDCachingEntityResolver class >> entityCache [
	^ entityCache ifNil: [entityCache := XMLKeyValueCache maxSize: 64]
]

{ #category : #private }
DTDCachingEntityResolver class >> entityCacheAt: aUri ifAbsentPut: aBlock [
	^ self entityCache
		at: aUri
		ifAbsentPut: aBlock
]

{ #category : #private }
DTDCachingEntityResolver class >> entityCacheAt: aUri put: anEntity [
	^ self entityCache
		at: aUri
		put: anEntity.
]

{ #category : #accessing }
DTDCachingEntityResolver class >> maxCachedEntities [
	^ self entityCache maxSize
]

{ #category : #accessing }
DTDCachingEntityResolver class >> maxCachedEntities: anInteger [
	self entityCache maxSize: anInteger
]

{ #category : #clearing }
DTDCachingEntityResolver >> clearEntityCache [
	self class clearEntityCache
]

{ #category : #accessing }
DTDCachingEntityResolver >> maxCachedEntities [
	^ self class maxCachedEntities
]

{ #category : #accessing }
DTDCachingEntityResolver >> maxCachedEntities: anInteger [
	self class maxCachedEntities: anInteger
]

{ #category : #resolving }
DTDCachingEntityResolver >> resolveEntityURI: aUri [
	| uri |

	^ (uri := aUri asXMLURI) isLocalURI
		ifTrue: [super resolveEntityURI: uri]
		ifFalse: [
			ReadStream on:
				(self class
					entityCacheAt: uri
					ifAbsentPut: [(super resolveEntityURI: uri) contents])]
]
