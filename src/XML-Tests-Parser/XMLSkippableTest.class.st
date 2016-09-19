"
An abstract class for TestCases with skippable tests.
"
Class {
	#name : #XMLSkippableTest,
	#superclass : #TestCase,
	#instVars : [
		'skippableTests'
	],
	#classInstVars : [
		'isSkipping'
	],
	#category : #'XML-Tests-Parser'
}

{ #category : #testing }
XMLSkippableTest class >> isAbstract [
	^ true
]

{ #category : #testing }
XMLSkippableTest class >> isSkipping [
	^ isSkipping ifNil: [isSkipping := true]
]

{ #category : #testing }
XMLSkippableTest class >> isSkipping: aBoolean [
	isSkipping := aBoolean
]

{ #category : #accessing }
XMLSkippableTest class >> skippableTests [
	"subclasses should override to return a collection of skippable test selectors"
	^ #()
]

{ #category : #accessing }
XMLSkippableTest class >> startSkipping [
	^ self isSkipping: true
]

{ #category : #accessing }
XMLSkippableTest class >> stopSkipping [
	^ self isSkipping: false
]

{ #category : #testing }
XMLSkippableTest >> isSkipping [
	^ self class isSkipping
]

{ #category : #private }
XMLSkippableTest >> skipOrReturnWith: aBlock [
	"skip is not portable to Squeak, so a return block is used as a backup"
	(self respondsTo: #skip)
		ifTrue: [self skip]
		ifFalse: [aBlock value]
]

{ #category : #private }
XMLSkippableTest >> skipOrReturnWith: aBlock ifSkippable: aSelector [
	"skip is not portable to Squeak, so a return block is used as a backup"
	(self isSkipping
		and: [self skippableTests includes: aSelector])
		ifTrue: [self skipOrReturnWith: aBlock]
]

{ #category : #accessing }
XMLSkippableTest >> skippableTests [
	"make it a set for faster lookup"
	^ skippableTests ifNil: [skippableTests := self class skippableTests asSet]
]