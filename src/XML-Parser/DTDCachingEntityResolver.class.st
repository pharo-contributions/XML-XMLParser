"
This resolver can cache entities so they don't have to be retrieved again (like over HTTP). Use it like this:
	entityResolver := DTDCachingEntityResolver new.
	(XMLDOMParser on: xml)
		externalEntityResolver: entityResolver;
		parseDocument.
"
Class {
	#name : #DTDCachingEntityResolver,
	#superclass : #DTDExternalEntityResolver,
	#instVars : [
		'entityCache'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #clearing }
DTDCachingEntityResolver >> clearEntityCache [
	self entityCache removeAll
]

{ #category : #accessing }
DTDCachingEntityResolver >> entityCache [
	^ entityCache ifNil: [entityCache := Dictionary new]
]

{ #category : #resolving }
DTDCachingEntityResolver >> resolveEntity: aUri [
	^ (self entityCache
		at: aUri
		ifAbsentPut: [(super resolveEntity: aUri) contents]) readStream
]
