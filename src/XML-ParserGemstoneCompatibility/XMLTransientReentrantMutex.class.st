"
This class is an implementation that uses Gemstone's TransientRecursionLock to implement a reentrant mutex. These are not persistent.
"
Class {
	#name : #XMLTransientReentrantMutex,
	#superclass : #XMLReentrantMutex,
	#instVars : [
		'transientRecursionLock'
	],
	#category : #'XML-ParserGemstoneCompatibility'
}

{ #category : #testing }
XMLTransientReentrantMutex class >> isSupportedImplementation [
	^ XMLClassFinder hasClassNamed: #TransientRecursionLock
]

{ #category : #'mutual exclusion' }
XMLTransientReentrantMutex >> critical: aBlock [
	^ transientRecursionLock critical: aBlock
]

{ #category : #initialization }
XMLTransientReentrantMutex >> initialize [
	super initialize.

	transientRecursionLock :=
		(XMLClassFinder classNamed: #TransientRecursionLock) new.
]
