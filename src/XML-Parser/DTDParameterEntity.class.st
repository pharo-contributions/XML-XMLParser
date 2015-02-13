"
This class is for parameter entities with replacements.
"
Class {
	#name : #DTDParameterEntity,
	#superclass : #DTDParsedEntity,
	#category : #'XML-Parser-DTD'
}

{ #category : #replacing }
DTDParameterEntity >> constructReplacementOn: aTokenizer [
	aTokenizer constructReplacementForParameterEntity: self
]

{ #category : #accessing }
DTDParameterEntity >> referencePrefix [
	^ '%'
]
