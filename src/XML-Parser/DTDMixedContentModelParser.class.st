Class {
	#name : #DTDMixedContentModelParser,
	#superclass : #DTDContentModelParser,
	#category : #'XML-Parser-DTD'
}

{ #category : #parsing }
DTDMixedContentModelParser >> parse [
	| mayContainElements mixedContentList allowedElements  |

	mayContainElements := contentModel last == $*.
	mixedContentList :=
		mayContainElements
			ifTrue: [contentModel allButLast]
			ifFalse: [contentModel].

	allowedElements := (DTDMixedContentListParser on: mixedContentList) parse.
	allowedElements remove: '#PCDATA'.
	(mayContainElements or: [allowedElements isEmpty])
		ifFalse: [XMLValidationException signal: 'Missing * after mixed content list with elements'].

	^ XMLMixedContentElementValidator
		element: element
		allowedElements: allowedElements.
]
