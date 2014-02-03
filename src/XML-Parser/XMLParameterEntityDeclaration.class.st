"
This is class for internal/external parameter <!ENTITY> declarations.
"
Class {
	#name : #XMLParameterEntityDeclaration,
	#superclass : #XMLEntityDeclaration,
	#category : #'XML-Parser-DOM'
}

{ #category : #testing }
XMLParameterEntityDeclaration >> isParameter [
	^ true
]
