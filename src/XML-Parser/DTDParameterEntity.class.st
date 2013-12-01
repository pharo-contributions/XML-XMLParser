Class {
	#name : #DTDParameterEntity,
	#superclass : #DTDParsedEntity,
	#category : #'XML-Parser-DTD'
}

{ #category : #accessing }
DTDParameterEntity >> referenceSymbol [
	^ $%
]

{ #category : #replacement }
DTDParameterEntity >> replacementForDTDContext [
	^ ' ', self replacement, ' '
]
