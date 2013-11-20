Class {
	#name : #DTDExternalParameterEntity,
	#superclass : #DTDParameterEntity,
	#category : #'XML-Parser-DTD'
}

{ #category : #testing }
DTDExternalParameterEntity >> isExternal [
	^ true
]

{ #category : #replacement }
DTDExternalParameterEntity >> replacementForLiteralContext [
	XMLValidationException signal: 'Cannot reference external parameter entity ', self asReference, ' in literal'
]
