"
This is a generic class to represent markup declarations in the internal subset. Each subclass represents a specific kind of declaration.
"
Class {
	#name : #XMLDeclarationNode,
	#superclass : #XMLNode,
	#category : #'XML-Parser-DOM'
}

{ #category : #testing }
XMLDeclarationNode >> isDeclaration [
	^ true
]
