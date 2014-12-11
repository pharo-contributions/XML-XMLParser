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
		ifTrue: [^ XMLAnyElementValidator element: element]
		ifFalse: [^ XMLEmptyElementValidator element: element]
]
