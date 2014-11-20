"
A context for text declaration tokens.
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

{ #category : #testing }
XMLTextDeclarationContext >> isTextDeclarationContext [
	^ true
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
