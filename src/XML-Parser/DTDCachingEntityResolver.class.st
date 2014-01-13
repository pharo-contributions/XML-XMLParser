"
This resolver can cache entities so they don't have to be retrieved again (like over HTTP).
"
Class {
	#name : #DTDCachingEntityResolver,
	#superclass : #DTDExternalEntityResolver,
	#classInstVars : [
		'entityCache',
		'maxCachedEntities'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #clearing }
DTDCachingEntityResolver class >> clearEntityCache [
	"self clearEntityCache"
	self entityCache removeAll
]

{ #category : #private }
DTDCachingEntityResolver class >> entityCache [
	^ entityCache ifNil: [entityCache := Dictionary new]
]

{ #category : #private }
DTDCachingEntityResolver class >> entityCacheAt: aUri ifAbsentPut: aBlock [
	^ self entityCache
		at: aUri
		ifAbsent: [
			self
				entityCacheAt: aUri
				put: aBlock value]
]

{ #category : #private }
DTDCachingEntityResolver class >> entityCacheAt: aUri put: anEntity [
	self entityCache size >= self maxCachedEntities
		ifTrue: [self clearEntityCache].

	^ self entityCache
		at: aUri
		put: anEntity.
]

{ #category : #accessing }
DTDCachingEntityResolver class >> maxCachedEntities [
	^ maxCachedEntities ifNil: [maxCachedEntities := 64]
]

{ #category : #accessing }
DTDCachingEntityResolver class >> maxCachedEntities: anInteger [
	maxCachedEntities := anInteger
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
DTDCachingEntityResolver >> resolveEntity: aUri [
	| uri |

	^ (uri := aUri asXMLURI) isLocalURI
		ifTrue: [super resolveEntity: uri]
		ifFalse: [
			ReadStream on:
				(self class
					entityCacheAt: uri
					ifAbsentPut: [(super resolveEntity: uri) contents])]
]
