Class {
	#name : #DTDAnyOrEmptyContentModelParser,
	#superclass : #DTDContentModelParser,
	#category : #'XML-Parser-DTD'
}

{ #category : #parsing }
DTDAnyOrEmptyContentModelParser >> parse [
	contentModel = 'ANY'
		ifTrue: [^ XMLAnyElementValidator element: name].
	contentModel = 'EMPTY'
		ifTrue: [^ XMLEmptyElementValidator element: name].

	XMLValidationException signal: 'Invalid content model "', contentModel, '"'.
]
