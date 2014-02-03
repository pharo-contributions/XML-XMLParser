Class {
	#name : #XMLMockNode,
	#superclass : #XMLNode,
	#instVars : [
		'notifier'
	],
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #private }
XMLMockNode >> notifier [
	^ notifier ifNil: [notifier := XMLNotifier new]
]

{ #category : #printing }
XMLMockNode >> writeXMLOn: aWriter [
	aWriter string: self class name asString, '(', self identityHash printString, ') '
]
