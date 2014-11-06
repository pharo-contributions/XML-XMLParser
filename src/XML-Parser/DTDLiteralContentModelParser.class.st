"
Parser for ANY and EMPTY elements.
"
Class {
	#name : #DTDLiteralContentModelParser,
	#superclass : #DTDContentModelParser,
	#category : #'XML-Parser-DTD'
}

{ #category : #private }
DTDLiteralContentModelParser >> errorInvalidContentModel [
	XMLValidationException
		formatSignal: 'Invalid content model "{1}" for element <{2}>'
		with: contentModel
		with: element.
]

{ #category : #parsing }
DTDLiteralContentModelParser >> parse [
	contentModel = 'ANY'
		ifTrue: [^ XMLAnyElementValidator element: element].
	contentModel = 'EMPTY'
		ifTrue: [^ XMLEmptyElementValidator element: element].

	self errorInvalidContentModel.
]
