"
This is a class for unresolvable external parameter parsed entities that lazily raises an error when #replacement or #replacementStream is sent, which would normally trigger resolution.
"
Class {
	#name : 'DTDUnresolvableExternalParameterParsedEntity',
	#superclass : 'DTDUnresolvableExternalParsedEntity',
	#category : 'XML-Parser-DTD',
	#package : 'XML-Parser',
	#tag : 'DTD'
}

{ #category : 'testing' }
DTDUnresolvableExternalParameterParsedEntity >> isParameter [

	^ true
]
