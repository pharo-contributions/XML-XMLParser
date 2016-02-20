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
	"either ANY or EMPTY"
	(contentModel at: 1) == $A
		ifTrue: [^ XMLAnyElementValidator element: element]
		ifFalse: [^ XMLEmptyElementValidator element: element]
]
