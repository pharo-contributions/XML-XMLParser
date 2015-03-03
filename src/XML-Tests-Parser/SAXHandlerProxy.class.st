"
A SAXHandler that records events.
"
Class {
	#name : #SAXHandlerProxy,
	#superclass : #Object,
	#instVars : [
		'saxHandler',
		'sentHandlerMessages'
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
	^ self sentHandlerMessages select: [:each | each selector = aName asSymbol]
]

{ #category : #accessing }
SAXHandlerProxy >> argumentsSentWith: aSelector [
	^ (self sentHandlerMessages
		detect: [:each | each selector = aSelector]
		ifNone: [^ #()]) arguments
]

{ #category : #'reflective operations' }
SAXHandlerProxy >> doesNotUnderstand: aMessage [
	| result |

	(self handlerCategories includes:
		(saxHandler class whichCategoryIncludesSelector: aMessage selector))
		ifTrue: [self sentHandlerMessages addLast: aMessage].

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

{ #category : #accessing }
SAXHandlerProxy >> sentHandlerMessages [
	^ sentHandlerMessages ifNil: [sentHandlerMessages := OrderedCollection new]
]

{ #category : #accessing }
SAXHandlerProxy >> sentHandlerSelectors [
	^ (self sentHandlerMessages collect: [:each | each selector]) asArray.
]

{ #category : #testing }
SAXHandlerProxy >> wasSentSelectors: aSelectorArray [
	^ self sentHandlerSelectors asArray = aSelectorArray asArray
]
