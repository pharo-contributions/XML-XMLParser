"
This class is for parameter entities with replacements.
"
Class {
	#name : #DTDParameterEntity,
	#superclass : #DTDParsedEntity,
	#category : #'XML-Parser-DTD'
}

{ #category : #replacement }
DTDParameterEntity >> constructReplacementOn: aTokenizer [
	aTokenizer constructReplacementForParameterEntity: self
]

{ #category : #accessing }
DTDParameterEntity >> escapedReferenceSymbol [
	^ '&#37;'
]

{ #category : #accessing }
DTDParameterEntity >> referenceSymbol [
	^ $%
]
