"
This parses element mixed content  (#PCDATA| ... ) lists.
"
Class {
	#name : #DTDMixedContentListParser,
	#superclass : #DTDValueListParser,
	#category : #'XML-Parser-DTD'
}

{ #category : #testing }
DTDMixedContentListParser >> isValidListValue: aValue [
	^ aValue = '#PCDATA' or: [XMLTokenizer isName: aValue]
]

{ #category : #parsing }
DTDMixedContentListParser >> parseAfterList [
	(valueListStream atEnd
		or: [valueListStream next == $*
			and: [valueListStream atEnd]])
		ifFalse: [
			XMLValidationException signal:
				'Mixed content list can only be followed by "*"'].
]
