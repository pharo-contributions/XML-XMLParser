Class {
	#name : #DTDBypassedParameterEntity,
	#superclass : #DTDParameterEntity,
	#category : #'XML-Parser-DTD'
}

{ #category : #replacement }
DTDBypassedParameterEntity >> replacement [
	^ self asEscapedReference
]

{ #category : #replacement }
DTDBypassedParameterEntity >> replacementForDTDContext [
	^ ''
]
