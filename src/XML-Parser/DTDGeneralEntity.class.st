Class {
	#name : #DTDGeneralEntity,
	#superclass : #DTDEntityDeclaration,
	#category : #'XML-Parser-DTD'
}

{ #category : #accessing }
DTDGeneralEntity >> referenceSymbol [
	^ $&
]

{ #category : #replacement }
DTDGeneralEntity >> replacementForContentContext [
	^ self replacement
]
