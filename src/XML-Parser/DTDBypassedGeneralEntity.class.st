Class {
	#name : #DTDBypassedGeneralEntity,
	#superclass : #DTDGeneralEntity,
	#category : #'XML-Parser-DTD'
}

{ #category : #replacement }
DTDBypassedGeneralEntity >> replacement [
	^ self asEscapedReference
]
