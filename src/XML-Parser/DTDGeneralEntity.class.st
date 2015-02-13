"
This class is for general parsed entities with replacements.

"
Class {
	#name : #DTDGeneralEntity,
	#superclass : #DTDParsedEntity,
	#category : #'XML-Parser-DTD'
}

{ #category : #replacing }
DTDGeneralEntity >> constructReplacementOn: aTokenizer [
	aTokenizer constructReplacementForGeneralEntity: self
]

{ #category : #accessing }
DTDGeneralEntity >> referencePrefix [
	^ '&'
]
