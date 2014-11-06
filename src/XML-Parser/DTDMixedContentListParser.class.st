"
This parses element mixed content  (#PCDATA| ... ) lists.
"
Class {
	#name : #DTDMixedContentListParser,
	#superclass : #DTDValueListParser,
	#category : #'XML-Parser-DTD'
}

{ #category : #private }
DTDMixedContentListParser >> errorInvalidMixedContentList [
	XMLValidationException signal: 'Mixed content list can only be followed by "*"'
]

{ #category : #testing }
DTDMixedContentListParser >> isValidListValue: aValue [
	^ aValue = '#PCDATA' or: [XMLWellFormedParserTokenizer isName: aValue]
]

{ #category : #private }
DTDMixedContentListParser >> parseAfterList [
	(valueListStream atEnd
		or: [valueListStream next == $*
			and: [valueListStream atEnd]])
		ifFalse: [self errorInvalidMixedContentList].
]
