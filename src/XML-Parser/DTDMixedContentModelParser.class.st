"
This class parses mixed content declarations like ""(#PCDATA|one|two)"" using a DTDMixedContentListParser.
"
Class {
	#name : #DTDMixedContentModelParser,
	#superclass : #DTDContentModelParser,
	#category : #'XML-Parser-DTD'
}

{ #category : #private }
DTDMixedContentModelParser >> errorInvalidMixedContentList [
	XMLValidationException signal: 'Missing * after mixed content list with elements'
]

{ #category : #parsing }
DTDMixedContentModelParser >> parse [
	^ XMLMixedContentElementValidator
		element: element
		allowedElements: self parseAllowedElements
]

{ #category : #private }
DTDMixedContentModelParser >> parseAllowedElements [
	| allowedElements |

	allowedElements := (DTDMixedContentListParser on: contentModel) parse.
	allowedElements remove: '#PCDATA'.

	(allowedElements isEmpty or: [contentModel last == $*])
		ifFalse: [self errorInvalidMixedContentList].

	^ allowedElements.
]
