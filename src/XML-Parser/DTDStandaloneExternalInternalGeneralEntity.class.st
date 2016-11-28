"
This is a class for standalone externally defined external general entities that cannot be referenced in documents except in ATTLIST attribute declaration default values.
"
Class {
	#name : #DTDStandaloneExternalInternalGeneralEntity,
	#superclass : #DTDInternalGeneralEntity,
	#category : #'XML-Parser-DTD-Standalone'
}

{ #category : #testing }
DTDStandaloneExternalInternalGeneralEntity >> isStandaloneExternal [
	^ true
]
