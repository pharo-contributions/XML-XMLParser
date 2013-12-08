Class {
	#name : #DTDParameterEntity,
	#superclass : #DTDParsedEntity,
	#category : #'XML-Parser-DTD'
}

{ #category : #accessing }
DTDParameterEntity >> escapedReferenceSymbol [
	^ '&#37;'
]

{ #category : #accessing }
DTDParameterEntity >> referenceSymbol [
	^ $%
]

{ #category : #replacement }
DTDParameterEntity >> replacementForDTDContext [
	^ (self replacement copyWithFirst: Character space) copyWith: Character space.
]
