Class {
	#name : #DTDBypassedGeneralEntity,
	#superclass : #DTDGeneralEntity,
	#category : #'XML-Parser-DTD'
}

{ #category : #accessing }
DTDBypassedGeneralEntity >> replacement [
	^ self asEscapedReference
]
