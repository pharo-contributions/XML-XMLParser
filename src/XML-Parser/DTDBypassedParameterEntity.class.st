Class {
	#name : #DTDBypassedParameterEntity,
	#superclass : #DTDParameterEntity,
	#category : #'XML-Parser-DTD'
}

{ #category : #accessing }
DTDBypassedParameterEntity >> replacement [
	^ self asEscapedReference
]

{ #category : #accessing }
DTDBypassedParameterEntity >> replacementForDTDContext [
	^ ''
]
