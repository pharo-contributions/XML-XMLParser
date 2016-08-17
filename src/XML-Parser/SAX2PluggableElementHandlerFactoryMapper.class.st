"
This class is a pluggable mappers to map element handler objects to element handler factories. Querying the factory for an element handler checks for a mapping set with  #mapElementHandlerClass: toFactory:, then the handler's class  #elementHandlerFactory message, then the mapper's own #elementHandlerFactory message, which returns a default factory (unlike in the base class) which can be set with #elementHandlerFactory:.

SAX2ElementParsers will reuse (inherit) the current factory if none is found for a new element handler, but this won't happen unless the default factory is cleared by setting #elementHandlerFactory: to nil.
"
Class {
	#name : #SAX2PluggableElementHandlerFactoryMapper,
	#superclass : #SAX2ElementHandlerFactoryMapper,
	#instVars : [
		'elementHandlerFactoryMap',
		'elementHandlerFactory'
	],
	#category : #'XML-Parser'
}

{ #category : #private }
SAX2PluggableElementHandlerFactoryMapper >> defaultElementHandlerFactoryClass [
	^ SAX2ElementHandlerFactory
]

{ #category : #accessing }
SAX2PluggableElementHandlerFactoryMapper >> elementHandlerFactory [
	^ elementHandlerFactory
]

{ #category : #accessing }
SAX2PluggableElementHandlerFactoryMapper >> elementHandlerFactory: anElementHandlerFactory [
	elementHandlerFactory := anElementHandlerFactory
]

{ #category : #private }
SAX2PluggableElementHandlerFactoryMapper >> elementHandlerFactoryMap [
	^ elementHandlerFactoryMap
]

{ #category : #accessing }
SAX2PluggableElementHandlerFactoryMapper >> factoryForElementHandler: anElementHandler ifNone: aBlock [
	"optimization to skip any unneeded hash lookups"
	elementHandlerFactoryMap size > 0
		ifTrue: [
			^ elementHandlerFactoryMap
				at: anElementHandler class
				ifAbsent: [
					super
						factoryForElementHandler: anElementHandler
						ifNone: aBlock]]
		ifFalse: [
			^ super
				factoryForElementHandler: anElementHandler
				ifNone: aBlock]
]

{ #category : #initialization }
SAX2PluggableElementHandlerFactoryMapper >> initialize [
	super initialize.

	elementHandlerFactoryMap := IdentityDictionary new.
	elementHandlerFactory := self defaultElementHandlerFactoryClass new.
]

{ #category : #mapping }
SAX2PluggableElementHandlerFactoryMapper >> mapElementHandlerClass: aClass toFactory: aFactory [
	elementHandlerFactoryMap
		at: aClass
		put: aFactory
]

{ #category : #copying }
SAX2PluggableElementHandlerFactoryMapper >> postCopy [
	super postCopy.

	elementHandlerFactoryMap := elementHandlerFactoryMap copy.
]
