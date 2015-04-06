"
A context for parsing the <?xml ...?> token.
"
Class {
	#name : #XMLXMLDeclarationContext,
	#superclass : #XMLPrologContext,
	#category : #'XML-Parser'
}

{ #category : #testing }
XMLXMLDeclarationContext >> isXMLDeclarationContext [
	^ true
]
