"
A bypassed parameter entity is replaced by an escaped reference inside entity declaration replacements or an empty string outside replacements in DTD subsets.
"
Class {
	#name : #DTDBypassedParameterEntity,
	#superclass : #DTDParameterEntity,
	#category : #'XML-Parser-DTD'
}

{ #category : #replacement }
DTDBypassedParameterEntity >> constructReplacementOn: aTokenizer [
	aTokenizer constructReplacementForBypassedParameterEntity: self
]

{ #category : #replacement }
DTDBypassedParameterEntity >> replacement [
	^ self asEscapedReference
]
