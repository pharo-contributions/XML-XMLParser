"
This class wraps a SAXHandler and records handler event messages using a message recorder. Non-handler messages are forwarded to the SAXHandler.
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
SAXHandlerProxy >> allSentSelectors [
	^ (self messageRecorder messagesCollect: [:each | each selector]) asArray
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

	(self isHandlerMessage: aMessage)
		ifTrue: [self messageRecorder recordMessage: aMessage].

	^ (result := aMessage sendTo: saxHandler) == saxHandler
		ifTrue: [self]
		ifFalse: [result].
]

{ #category : #testing }
SAXHandlerProxy >> isHandlerMessage: aMessage [
	| category |

	category := saxHandler class whichCategoryIncludesSelector: aMessage selector.

	^ category asString beginsWith: 'handling'.
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
	^ self allSentSelectors = aSelectorArray asArray
]
