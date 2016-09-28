"
A factory for creating reentrant mutexes that support nested sends of #critical: by the same process without deadlocking.

(Doesn't use  XMLAbstractFactory because it has no special platform-specific behavior.)
"
Class {
	#name : #XMLReentrantMutexFactory,
	#superclass : #Object,
	#classVars : [
		'ReentrantMutexClass'
	],
	#category : #'XML-Parser-Utils'
}

{ #category : #private }
XMLReentrantMutexFactory class >> errorNoReentrantMutexClass [
	Error signal: 'No supported reentrant mutex class available'
]

{ #category : #'class initialization' }
XMLReentrantMutexFactory class >> initialize [
	"self initialize"

	ReentrantMutexClass :=
		XMLClassFinder
			classNamed: #Mutex
			ifAbsent: [
				"use TransientRecursionLock on GS"
				XMLClassFinder
					classNamed: #TransientRecursionLock
					ifAbsent: [self errorNoReentrantMutexClass]]
]

{ #category : #'instance creation' }
XMLReentrantMutexFactory class >> new [
	^ self reentrantMutexClass new
]

{ #category : #accessing }
XMLReentrantMutexFactory class >> reentrantMutexClass [
	^ ReentrantMutexClass
]

{ #category : #accessing }
XMLReentrantMutexFactory class >> reentrantMutexClass: aClass [
	ReentrantMutexClass := aClass
]
