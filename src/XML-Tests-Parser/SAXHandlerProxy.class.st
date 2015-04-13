"
A class that wraps a SAXHandler and records handler events messages using a message recorder. Non-handler messages are forwarded to the wrapped SAXHandler.
"
Class {
	#name : #SAXHandlerProxy,
	#superclass : #Object,
	#instVars : [
		'saxHandler',
		'messageRecorder'
	],
	#category : #'XML-Tests-Parser'
}

{ #category : #'instance creation' }
SAXHandlerProxy class >> on: aStringOrStream [
	^ self saxHandler: (SAXHandler on: aStringOrStream)
]

{ #category : #'instance creation' }
SAXHandlerProxy class >> saxHandler: aSaxHandler [
	^ self new saxHandler: aSaxHandler
]

{ #category : #accessing }
SAXHandlerProxy >> allSentMessagesNamed: aName [
	^ self messageRecorder messagesSelect: [:each | each selector = aName asSymbol]
]

{ #category : #accessing }
SAXHandlerProxy >> argumentsSentWith: aSelector [
	self messageRecorder messagesDo: [:each |
		each selector = aSelector
			ifTrue: [^ each arguments]].
	^ #().
]

{ #category : #'reflective operations' }
SAXHandlerProxy >> doesNotUnderstand: aMessage [
	| result |

	(self handlerCategories includes:
		(saxHandler class whichCategoryIncludesSelector: aMessage selector))
		ifTrue: [self messageRecorder recordMessage: aMessage].

	^ (result := aMessage sendTo: saxHandler) == saxHandler
		ifTrue: [self]
		ifFalse: [result].
]

{ #category : #accessing }
SAXHandlerProxy >> handlerCategories [
	^ #(
		#'handling - content'
		#'handling - lexical'
		#'handling - declarations'
	)
]

{ #category : #accessing }
SAXHandlerProxy >> messageRecorder [
	^ messageRecorder ifNil: [messageRecorder := XMLMessageRecorder new]
]

{ #category : #parsing }
SAXHandlerProxy >> parseDocument [
	self parser parseDocument
]

{ #category : #parsing }
SAXHandlerProxy >> parser [
	^ XMLParser
		driver: (self driverClass saxHandler: self)
		on: saxHandler input
]

{ #category : #accessing }
SAXHandlerProxy >> saxHandler: aSaxHandler [
	saxHandler := aSaxHandler
]

{ #category : #testing }
SAXHandlerProxy >> wasSentSelectors: aSelectorArray [
	^ (self messageRecorder messagesCollect: [:each | each selector]) asArray =
		aSelectorArray asArray
]
