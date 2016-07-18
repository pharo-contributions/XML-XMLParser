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
			'Unresolvable external entity {1}. ',
			'Enable resolution with #resolvesExternalEntityReferences:'
		with: self asReference
]
