"
A context for parsing prolog tokens after <!DOCTYPE ...> declarations.
"
Class {
	#name : #XMLPostDoctypeDeclarationContext,
	#superclass : #XMLPrologContext,
	#category : #'XML-Parser'
}

{ #category : #testing }
XMLPostDoctypeDeclarationContext >> isPostDoctypeDeclarationContext [
	^ true
]
