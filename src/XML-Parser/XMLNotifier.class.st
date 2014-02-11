"
This class implements the observer pattern.

Classes using it need to forward its entire protocol to a private instance. Objects will then be able to register themselves as observers of it and receive notifications from it, which are selectors that the observers are expected to implement, typically under the category ""notifications.""

It stores observers in an Array grown and shrunk with #copyWith: and #copyWithout: rather than an OrderedCollection for better memory usage and faster performance (because each node only has at most two observers).
"
Class {
	#name : #XMLNotifier,
	#superclass : #Object,
	#instVars : [
		'observers'
	],
	#category : #'XML-Parser-DOM'
}

{ #category : #observing }
XMLNotifier >> addObserver: anObject [
	observers
		ifNil: [observers := anObject]
		ifNotNil: [
			observers :=
				observers isArray
					ifTrue: [observers copyWith: anObject]
					ifFalse: [Array with: observers with: anObject]]
]

{ #category : #notification }
XMLNotifier >> notifyOf: aSelector with: anArgument [
	observers isArray
		ifTrue: [
			observers do: [:each |
				each perform: aSelector with: anArgument]]
		ifFalse: [
			observers ifNotNil: [
				observers perform: aSelector with: anArgument]]
]

{ #category : #notification }
XMLNotifier >> notifyOf: aSelector with: aFirstArgument with: aSecondArgument [
	observers isArray
		ifTrue: [ 
			observers do: [:each |
				each
					perform: aSelector
					with: aFirstArgument
					with: aSecondArgument]]
		ifFalse: [
			observers ifNotNil: [
				observers
					perform: aSelector
					with: aFirstArgument
					with: aSecondArgument]]
]

{ #category : #notification }
XMLNotifier >> notifyOf: aSelector with: aFirstArgument with: aSecondArgument with: aThirdArgument [
	observers isArray
		ifTrue: [
			observers do: [:each |
				each
					perform: aSelector
					with: aFirstArgument
					with: aSecondArgument
					with: aThirdArgument]]
		ifFalse: [
			observers ifNotNil: [
				observers
					perform: aSelector
					with: aFirstArgument
					with: aSecondArgument
					with: aThirdArgument]]
]

{ #category : #notification }
XMLNotifier >> notifyOf: aSelector withArguments: anArray [
	observers isArray
		ifTrue: [
			observers do: [:each |
				each perform: aSelector withArguments: anArray]]
		ifFalse: [
			observers ifNotNil: [
				observers perform: aSelector withArguments: anArray]]
]

{ #category : #accessing }
XMLNotifier >> observers [
	^ observers ifNil: [#()]
]

{ #category : #observing }
XMLNotifier >> removeObserver: anObject [
	observers isArray
		ifTrue: [
			(observers := observers copyWithout: anObject) size = 1
				ifTrue: [observers := observers first]]
		ifFalse: [
			observers == anObject
				ifTrue: [observers := nil]]
]
