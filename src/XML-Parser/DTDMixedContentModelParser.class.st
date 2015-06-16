"
This class parses mixed content declarations like ""(#PCDATA|one|two)"" using a DTDEnumerationListParser.
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

{ #category : #private }
DTDMixedContentModelParser >> parseAllowedElements [
	^ (DTDEnumerationListParser on: contentModel) parse
		remove: '#PCDATA';
		yourself
]
