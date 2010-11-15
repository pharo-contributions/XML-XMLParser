"
This is a generic class to represent markup declarations in the internal subset. Each subclass represents a specific kind of declaration, and each is immutable.
"
Class {
	#name : #XMLDeclarationNode,
	#superclass : #XMLNode,
	#instVars : [
		'name'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #accessing }
XMLDeclarationNode >> name [
	^ name ifNil: [name := '']
]
