"
A context for <?xml ...?> text declaration tokens at the start of external entities.
"
Class {
	#name : #XMLTextDeclarationContext,
	#superclass : #XMLTokenContext,
	#instVars : [
		'previousContext'
	],
	#category : #'XML-Parser'
}

{ #category : #'instance creation' }
XMLTextDeclarationContext class >> previousContext: aTokenContex [
	^ self new previousContext: aTokenContex
]

{ #category : #tokenizing }
XMLTextDeclarationContext >> nextTokenFrom: aTokenizer [
	aTokenizer nextXMLTextDeclaration
]

{ #category : #accessing }
XMLTextDeclarationContext >> previousContext [
	^ previousContext
]

{ #category : #accessing }
XMLTextDeclarationContext >> previousContext: aTokenContex [
	previousContext := aTokenContex
]
