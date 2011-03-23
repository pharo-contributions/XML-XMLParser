"
This class represents a preserved CDATA section from a parsed document. It behaves like its superclass, except that its printed form differs in that it contains a ""<![CDATA["" prefix and a ""]]>"" suffix and its contents are NOT escaped. By default, CDATA sections are converted to regular string nodes during parsing. To preserve them as CDATA nodes, use #preservesCDataNodes: with the DOM parser before parsing.
"
Class {
	#name : #XMLCData,
	#superclass : #XMLString,
	#category : #'XML-Parser-Nodes'
}

{ #category : #testing }
XMLCData >> isCData [
	^ true
]

{ #category : #printing }
XMLCData >> writeXMLOn: aWriter [
	aWriter cdata: self string
]
