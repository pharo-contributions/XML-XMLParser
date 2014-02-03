"
This class parses mixed content declarations like ""(#PCDATA|one|two)"" using a DTDMixedContentListParser.
"
Class {
	#name : #DTDMixedContentModelParser,
	#superclass : #DTDContentModelParser,
	#category : #'XML-Parser-DTD'
}

{ #category : #parsing }
DTDMixedContentModelParser >> parse [
	^ XMLMixedContentElementValidator
		element: element
		allowedElements: self parseAllowedElements
]

{ #category : #parsing }
DTDMixedContentModelParser >> parseAllowedElements [
	| allowedElements |

	allowedElements := (DTDMixedContentListParser on: contentModel) parse.
	allowedElements remove: '#PCDATA'.

	(allowedElements isEmpty or: [contentModel last == $*])
		ifFalse: [
			XMLValidationException signal:
				'Missing * after mixed content list with elements'].

	^ allowedElements.
]
