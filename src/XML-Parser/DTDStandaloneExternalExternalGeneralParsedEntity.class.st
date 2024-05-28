"
This is a class for standalone externally defined external general entities that cannot be referenced in documents.
"
Class {
	#name : 'DTDStandaloneExternalExternalGeneralParsedEntity',
	#superclass : 'DTDExternalGeneralParsedEntity',
	#category : 'XML-Parser-DTD-Standalone',
	#package : 'XML-Parser',
	#tag : 'DTD-Standalone'
}

{ #category : 'testing' }
DTDStandaloneExternalExternalGeneralParsedEntity >> isStandaloneExternal [
	^ true
]
