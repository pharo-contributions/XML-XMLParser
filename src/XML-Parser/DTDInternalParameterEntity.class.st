"
This is a class for internal parameter parsed entities with replacements that can be inserted into documents.
"
Class {
	#name : #DTDInternalParameterEntity,
	#superclass : #DTDInternalEntity,
	#category : #'XML-Parser-DTD'
}

{ #category : #testing }
DTDInternalParameterEntity >> isParameter [
	^ true
]
