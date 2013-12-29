"
This class parses mixed content declarations like ""(#PCDATA|one|two)""

"
Class {
	#name : #DTDMixedContentModelParser,
	#superclass : #DTDContentModelParser,
	#category : #'XML-Parser-DTD'
}

{ #category : #parsing }
DTDMixedContentModelParser >> parse [
	| mayContainElements allowedElements |

	(mayContainElements := contentModel last == $*)
		ifTrue: [contentModel := contentModel allButLast].

	allowedElements := self parseListAllowingElements: mayContainElements.

	^ XMLMixedContentElementValidator
		element: element
		allowedElements: allowedElements.
]

{ #category : #parsing }
DTDMixedContentModelParser >> parseListAllowingElements: aBoolean [
	| allowedElements |

	allowedElements := (DTDMixedContentListParser on: contentModel) parse.
	allowedElements remove: '#PCDATA'.

	(aBoolean or: [allowedElements isEmpty])
		ifFalse: [
			XMLValidationException signal:
				'Missing * after mixed content list with elements'].

	^ allowedElements.
]
