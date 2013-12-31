Class {
	#name : #XMLMockObserverNode,
	#superclass : #XMLMockNode,
	#instVars : [
		'lastNotificationArguments'
	],
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #accessing }
XMLMockObserverNode >> lastNotificationArguments [
	^ lastNotificationArguments
]

{ #category : #accessing }
XMLMockObserverNode >> lastNotificationArguments: anArray [
	lastNotificationArguments := anArray
]

{ #category : #notifications }
XMLMockObserverNode >> mockNotifyWith: aFirstObject [
	lastNotificationArguments := Array with: aFirstObject
]

{ #category : #notifications }
XMLMockObserverNode >> mockNotifyWith: aFirstObject with: aSecondObject [
	lastNotificationArguments := Array with: aFirstObject with: aSecondObject
]

{ #category : #notifications }
XMLMockObserverNode >> mockNotifyWith: aFirstObject with: aSecondObject with: aThirdArgument [
	lastNotificationArguments := Array with: aFirstObject with: aSecondObject with: aThirdArgument
]
