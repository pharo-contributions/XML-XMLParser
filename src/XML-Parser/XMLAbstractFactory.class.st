"
An abstract class for dynamically choosing supported concrete implementations for different platforms.
"
Class {
	#name : #XMLAbstractFactory,
	#superclass : #Object,
	#classInstVars : [
		'implementation'
	],
	#category : #'XML-Parser-Util'
}

{ #category : #private }
XMLAbstractFactory class >> errorUnsupported [
	self subclassResponsibility
]

{ #category : #private }
XMLAbstractFactory class >> implementation [
	^ implementation
		ifNil: [
			self isSupported
				ifTrue: [implementation := self]
				ifFalse: [implementation := self selectImplementation]]
]

{ #category : #private }
XMLAbstractFactory class >> implementation: aClass [
	implementation := aClass
]

{ #category : #'class initialization' }
XMLAbstractFactory class >> initialize [
	"self initialize"
	"clear cached implementations"
	self allSubclassesDo: [:each | each implementation: nil]
]

{ #category : #testing }
XMLAbstractFactory class >> isSupported [
	^ false
]

{ #category : #'instance creation' }
XMLAbstractFactory class >> new [
	^ self implementation basicNew initialize
]

{ #category : #private }
XMLAbstractFactory class >> preferredImplementation [
	self subclassResponsibility
]

{ #category : #private }
XMLAbstractFactory class >> selectImplementation [
	self preferredImplementation isSupported
		ifTrue: [^ self preferredImplementation].

	self allSubclassesDo: [:each |
		each isSupported
			ifTrue: [^ each]].

	self errorUnsupported.
]
