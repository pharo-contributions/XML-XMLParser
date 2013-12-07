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
SAXHandlerProxy class >> saxHandler: aSaxHandler [
	^ self new saxHandler: aSaxHandler
]

{ #category : #'reflective operations' }
SAXHandlerProxy >> doesNotUnderstand: aMessage [
	| result |

	(self handlerCategories anySatisfy: [:each |
		(saxHandler class selectorsInCategory: each)
			includes: aMessage selector])
		ifTrue: [self sentHandlerMessages addLast: aMessage].

	^ (result := aMessage sendTo: saxHandler) == saxHandler
		ifTrue: [self]
		ifFalse: [result].
]

{ #category : #accessing }
SAXHandlerProxy >> handlerCategories [
	^ #(content lexical declaration)
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
