"
A parameter entity with an external replacement.
"
Class {
	#name : #DTDExternalParameterEntity,
	#superclass : #DTDParameterEntity,
	#category : #'XML-Parser-DTD'
}

{ #category : #testing }
DTDExternalParameterEntity >> isExternal [
	^ true
]

{ #category : #accessing }
DTDExternalParameterEntity >> replacementStream [
	^ XMLDecodingReadStreamAdapter on: super replacementStream
]
