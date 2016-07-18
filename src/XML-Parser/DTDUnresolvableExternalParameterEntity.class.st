"
This is a class for unresolvable external parameter parsed entities. Resolving them will raise an exception.
"
Class {
	#name : #DTDUnresolvableExternalParameterEntity,
	#superclass : #DTDUnresolvableExternalEntity,
	#category : #'XML-Parser-DTD'
}

{ #category : #testing }
DTDUnresolvableExternalParameterEntity >> isParameter [
	^ true
]
