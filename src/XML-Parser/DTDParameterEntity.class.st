Class {
	#name : #DTDParameterEntity,
	#superclass : #DTDEntityDeclaration,
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
