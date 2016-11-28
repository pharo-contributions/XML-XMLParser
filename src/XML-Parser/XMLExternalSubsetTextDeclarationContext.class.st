"
A context for <?xml ...?> text declaration tokens at the start of the external DTD subset.

This context #canTerminateInput unlike XMLXMLDeclarationContext because external subsets and parsed entities can be empty, but documents must have at least one element.
"
Class {
	#name : #XMLExternalSubsetTextDeclarationContext,
	#superclass : #XMLExternalSubsetContext,
	#category : #'XML-Parser-Drivers'
}

{ #category : #tokenizing }
XMLExternalSubsetTextDeclarationContext >> nextTokenFrom: aTokenizer [
	aTokenizer nextStartExternalSubset
]

{ #category : #testing }
XMLExternalSubsetTextDeclarationContext >> supportsEncodingDetection [
	^ true
]
