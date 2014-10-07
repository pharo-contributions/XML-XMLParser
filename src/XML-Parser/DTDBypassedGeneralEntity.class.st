"
A bypassed general entity is replaced by an escaped reference to itself.
"
Class {
	#name : #DTDBypassedGeneralEntity,
	#superclass : #DTDGeneralEntity,
	#category : #'XML-Parser-DTD'
}

{ #category : #replacement }
DTDBypassedGeneralEntity >> replacement [
	^ self asEscapedReference
]
