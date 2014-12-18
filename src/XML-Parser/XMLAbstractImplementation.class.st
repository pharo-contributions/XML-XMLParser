"
An abstract class for dynamically choosing supported concrete implementations.
"
Class {
	#name : #XMLAbstractImplementation,
	#superclass : #Object,
	#classInstVars : [
		'implementation'
	],
	#category : #'XML-Parser-Util'
}

{ #category : #private }
XMLAbstractImplementation class >> errorUnsupported [
	self subclassResponsibility
]

{ #category : #private }
XMLAbstractImplementation class >> implementation [
	^ implementation
		ifNil: [
			self isSupported
				ifTrue: [implementation := self]
				ifFalse: [implementation := self selectImplementation]]
]

{ #category : #private }
XMLAbstractImplementation class >> implementation: aClass [
	implementation := aClass
]

{ #category : #'class initialization' }
XMLAbstractImplementation class >> initialize [
	"self initialize"

	"clear cached implementations"
	self allSubclassesDo: [:each | each implementation: nil]
]

{ #category : #testing }
XMLAbstractImplementation class >> isSupported [
	^ false
]

{ #category : #'instance creation' }
XMLAbstractImplementation class >> new [
	^ self implementation basicNew initialize
]

{ #category : #private }
XMLAbstractImplementation class >> preferredImplementation [
	self subclassResponsibility
]

{ #category : #private }
XMLAbstractImplementation class >> selectImplementation [
	self preferredImplementation isSupported
		ifTrue: [^ self preferredImplementation].

	self allSubclassesDo: [:each |
		each isSupported
			ifTrue: [^ each]].

	self errorUnsupported.
]
