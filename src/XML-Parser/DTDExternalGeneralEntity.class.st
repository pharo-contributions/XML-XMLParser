Class {
	#name : #DTDExternalGeneralEntity,
	#superclass : #DTDGeneralEntity,
	#category : #'XML-Parser-DTD'
}

{ #category : #testing }
DTDExternalGeneralEntity >> isExternal [
	^ true
]

{ #category : #replacement }
DTDExternalGeneralEntity >> replacementForLiteralContext [
	XMLValidationException signal: 'Cannot reference external general entity ', self asReference, ' in literal'
]
