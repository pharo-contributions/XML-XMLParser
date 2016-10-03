"
This is an abstract class for external parsed entities that are unresolvable because external entity resolution was not enabled. Resolving them will raise an exception.

"
Class {
	#name : #DTDUnresolvableExternalEntity,
	#superclass : #DTDExternalEntity,
	#category : #'XML-Parser-DTD'
}

{ #category : #testing }
DTDUnresolvableExternalEntity >> hasUnresolvedReplacement [
	^ true
]

{ #category : #resolving }
DTDUnresolvableExternalEntity >> resolveReplacement [
	XMLParserException
		formatSignal:
			'External entity {1} can''t be resolved unless resolution is ',
			'enabled; use #resolvesExternalEntityReferences: before parsing ',
			'to enable'
		with: self asReference
]
