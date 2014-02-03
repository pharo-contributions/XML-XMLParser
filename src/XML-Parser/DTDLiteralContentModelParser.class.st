"
Parser for ANY and EMPTY elements.
"
Class {
	#name : #DTDLiteralContentModelParser,
	#superclass : #DTDContentModelParser,
	#category : #'XML-Parser-DTD'
}

{ #category : #parsing }
DTDLiteralContentModelParser >> parse [
	contentModel = 'ANY'
		ifTrue: [^ XMLAnyElementValidator element: element].
	contentModel = 'EMPTY'
		ifTrue: [^ XMLEmptyElementValidator element: element].

	XMLValidationException signal: 'Invalid content model "', contentModel, '"'.
]
