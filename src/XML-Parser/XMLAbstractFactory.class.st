"
An abstract class for dynamically choosing a supported concrete implementation from a class hierarchy for this platform.

Each root subclass needs to override #preferredImplementation to return the preferred subclass and #noSupportedImplementationFound to signal an error if none are supported, and then each subclass of the root needs to define #isSupportedImplementation to return true if it supports this platform.
"
Class {
	#name : #XMLAbstractFactory,
	#superclass : #Object,
	#classInstVars : [
		'implementation'
	],
	#category : #'XML-Parser-Utils'
}

{ #category : #clearing }
XMLAbstractFactory class >> clearAllImplementations [
	"self clearAllImplementations"

	self
		implementation: nil;
		allSubclassesDo: [:each | each implementation: nil]
]

{ #category : #finding }
XMLAbstractFactory class >> findSupportedImplementation [
	self isSupportedImplementation
		ifTrue: [^ self].

	self preferredImplementation isSupportedImplementation
		ifTrue: [^ self preferredImplementation].
	self allSubclassesDo: [:each |
		each isSupportedImplementation
			ifTrue: [^ each]].

	^ nil.
]

{ #category : #testing }
XMLAbstractFactory class >> hasSupportedImplementation [
	^ self findSupportedImplementation notNil
]

{ #category : #accessing }
XMLAbstractFactory class >> implementation [
	^ implementation
		ifNil: [
			"avoid assigning to the class inst var unless an implementation
			was found to minimize write conflicts on GS"
			self findSupportedImplementation
				ifNil: [self noSupportedImplementationFound]
				ifNotNil: [:supportedImplementation |
					implementation := supportedImplementation].
			implementation]
]

{ #category : #accessing }
XMLAbstractFactory class >> implementation: aClassOrNil [
	implementation := aClassOrNil
]

{ #category : #'class initialization' }
XMLAbstractFactory class >> initialize [
	"self initialize"

	self clearAllImplementations
]

{ #category : #testing }
XMLAbstractFactory class >> isSupportedImplementation [
	^ false
]

{ #category : #'instance creation' }
XMLAbstractFactory class >> new [
	^ self implementation basicNew initialize
]

{ #category : #finding }
XMLAbstractFactory class >> noSupportedImplementationFound [
	self subclassResponsibility
]

{ #category : #defaults }
XMLAbstractFactory class >> preferredImplementation [
	self subclassResponsibility
]
