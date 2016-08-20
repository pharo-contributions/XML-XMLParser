"
This is a base class for mappers to map element handler objects to element handler factories Querying the factory for an element handler checks the handler's #elementHandlerFactory message first and then the mapper's own #elementHandlerFactory message.

SAX2ElementParsers will reuse (inherit) the current factory if none is found for a new element handler.
"
Class {
	#name : #SAX2ElementHandlerFactoryMapper,
	#superclass : #Object,
	#category : #'XML-Parser'
}

{ #category : #accessing }
SAX2ElementHandlerFactoryMapper >> elementHandlerFactory [
	^ nil
]

{ #category : #accessing }
SAX2ElementHandlerFactoryMapper >> factoryForElementHandler: anElementHandler [
	^ self
		factoryForElementHandler: anElementHandler
		ifNone: [nil]
]

{ #category : #accessing }
SAX2ElementHandlerFactoryMapper >> factoryForElementHandler: anElementHandler ifNone: aBlock [
	^ anElementHandler elementHandlerFactory
		ifNil: [
			self elementHandlerFactory
				ifNil: [aBlock value]]
]
