"
This class is used by objects using the TXMLObservable Trait to send notifications to objects that register themselves as observers. The notifications are selectors that observers are expected to implement, typically under the category ""notifications.""

It uses an Array grown and shrunk with #copyWith: and #copyWithout: rather than an OrderedCollection for better memory usage and faster performance (because each node only has at most two observers).
"
Class {
	#name : #XMLNotifier,
	#superclass : #Object,
	#instVars : [
		'observers'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #observing }
XMLNotifier >> addObserver: anObject [
	observers :=
		observers
			ifNil: [Array with: anObject]
			ifNotNil: [observers copyWith: anObject]
]

{ #category : #notification }
XMLNotifier >> notifyOf: aSelector with: anArgument [
	observers ifNotNil: [
		observers do: [:each |
			each perform: aSelector with: anArgument]]
]

{ #category : #notification }
XMLNotifier >> notifyOf: aSelector with: aFirstArgument with: aSecondArgument [
	observers ifNotNil: [
		observers do: [:each |
			each
				perform: aSelector
				with: aFirstArgument
				with: aSecondArgument]]
]

{ #category : #notification }
XMLNotifier >> notifyOf: aSelector with: aFirstArgument with: aSecondArgument with: aThirdArgument [
	observers ifNotNil: [
		observers do: [:each |
			each
				perform: aSelector
				with: aFirstArgument
				with: aSecondArgument
				with: aThirdArgument]]
]

{ #category : #notification }
XMLNotifier >> notifyOf: aSelector withArguments: anArray [
	observers ifNotNil: [
		observers do: [:each |
			each perform: aSelector withArguments: anArray]]
]

{ #category : #accessing }
XMLNotifier >> observers [
	^ observers ifNil: [#()]
]

{ #category : #observing }
XMLNotifier >> removeObserver: anObject [
	(observers := observers copyWithout: anObject)
		ifEmpty: [observers := nil]
]
