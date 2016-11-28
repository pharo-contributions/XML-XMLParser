"
This is a class for standalone externally defined external general entities that cannot be referenced in documents.
"
Class {
	#name : #DTDStandaloneExternalExternalGeneralEntity,
	#superclass : #DTDExternalGeneralEntity,
	#category : #'XML-Parser-DTD-Standalone'
}

{ #category : #testing }
DTDStandaloneExternalExternalGeneralEntity >> isStandaloneExternal [
	^ true
]
