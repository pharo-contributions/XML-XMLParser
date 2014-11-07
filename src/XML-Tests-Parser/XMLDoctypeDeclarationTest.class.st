Class {
	#name : #XMLDoctypeDeclarationTest,
	#superclass : #XMLNodeWithChildrenTest,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #testing }
XMLDoctypeDeclarationTest class >> isAbstract [
	^ false
]

{ #category : #accessing }
XMLDoctypeDeclarationTest >> nodeClass [
	^ XMLDoctypeDeclaration
]
