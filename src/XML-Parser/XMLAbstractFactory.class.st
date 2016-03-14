"
An abstract class for dynamically choosing a supported concrete implementation from a class hierarchy for this platform.

Each root subclass needs to override preferredImplementation to return the preferred subclass and errorNoSupportedImplementation to signal an error if none are supported, and then each subclass of the root needs to define isSupportedImplementation to return true if it supports this platform.
"
Class {
	#name : #XMLAbstractFactory,
	#superclass : #Object,
	#classInstVars : [
		'implementation'
	],
	#category : #'XML-Parser-Utils'
}

{ #category : #private }
XMLAbstractFactory class >> clearAllImplementations [
	"self clearImplementations"

	self implementation: nil.
	self allSubclassesDo: [:each | each implementation: nil]
]

{ #category : #private }
XMLAbstractFactory class >> errorNoSupportedImplementation [
	self subclassResponsibility
]

{ #category : #private }
XMLAbstractFactory class >> findSupportedImplementation [
	self preferredImplementation isSupportedImplementation
		ifTrue: [^ self preferredImplementation].

	self isSupportedImplementation
		ifTrue: [^ self].
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
			(implementation := self findSupportedImplementation)
				ifNil: [self errorNoSupportedImplementation].
			implementation]
]

{ #category : #accessing }
XMLAbstractFactory class >> implementation: aClass [
	implementation := aClass
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

{ #category : #accessing }
XMLAbstractFactory class >> preferredImplementation [
	self subclassResponsibility
]
