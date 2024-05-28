"
This is an abstract class for markup declaration nodes in the internal subset.
"
Class {
	#name : 'XMLDeclarationNode',
	#superclass : 'XMLNode',
	#category : 'XML-Parser-DOM',
	#package : 'XML-Parser',
	#tag : 'DOM'
}

{ #category : 'testing' }
XMLDeclarationNode >> isDeclaration [
	^ true
]
