Class {
	#name : #SAXHandlerPluggableProxy,
	#superclass : #SAXHandlerProxy,
	#instVars : [
		'handlerCallbacks'
	],
	#category : #'XML-Tests-Parser'
}

{ #category : #'reflective operations' }
SAXHandlerPluggableProxy >> doesNotUnderstand: aMessage [
	| result |

	result := super doesNotUnderstand: aMessage.

	^ (self handlerCallbacks
		at: aMessage selector
		ifAbsent: [^ result]) value: aMessage
]

{ #category : #accessing }
SAXHandlerPluggableProxy >> handle: aSelector with: aBlock [
	self handlerCallbacks
		at: aSelector
		put: aBlock
]

{ #category : #accessing }
SAXHandlerPluggableProxy >> handlerCallbacks [
	^ handlerCallbacks ifNil: [handlerCallbacks := Dictionary new]
]
