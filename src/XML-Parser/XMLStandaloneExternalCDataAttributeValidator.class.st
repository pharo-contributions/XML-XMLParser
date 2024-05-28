"
This class validates standalone externally defined CDATA attributes. It disallows attributes that need substitution with default or fixed default values.
"
Class {
	#name : 'XMLStandaloneExternalCDataAttributeValidator',
	#superclass : 'XMLCDataAttributeValidator',
	#category : 'XML-Parser-Validation-Standalone',
	#package : 'XML-Parser',
	#tag : 'Validation-Standalone'
}

{ #category : 'testing' }
XMLStandaloneExternalCDataAttributeValidator >> isStandaloneExternal [
	^ true
]
