"
This class parses mixed content declarations like ""(#PCDATA|one|two)*"" using a DTDEnumerationListParser and returns an element validator accepting any sequence of PCDATA and the named elements.
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
		allowedElements:
			((DTDEnumerationListParser on: contentModel) parse
				remove: '#PCDATA';
				yourself)
]
