"
This is a class for external parameter parsed entities with external replacements that can be inserted into an XML document.
"
Class {
	#name : #DTDExternalParameterEntity,
	#superclass : #DTDExternalEntity,
	#category : #'XML-Parser-DTD'
}

{ #category : #testing }
DTDExternalParameterEntity >> isParameter [
	^ true
]
