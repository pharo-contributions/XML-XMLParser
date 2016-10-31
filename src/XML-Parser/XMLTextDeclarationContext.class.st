"
A context for <?xml ...?> text declaration tokens at the start of external parsed entities and the external DTD subset.

This context #canTerminateInput unlike XMLXMLDeclarationContext because external subsets and parsed entities can be empty, but documents must have at least one element.
"
Class {
	#name : #XMLTextDeclarationContext,
	#superclass : #XMLTokenContext,
	#instVars : [
		'previousContext'
	],
	#category : #'XML-Parser-Drivers'
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
	^ previousContext ifNil: [self externalSubsetContext]
]

{ #category : #accessing }
XMLTextDeclarationContext >> previousContext: aTokenContex [
	previousContext := aTokenContex
]

{ #category : #testing }
XMLTextDeclarationContext >> supportsEncodingDetection [
	^ true
]
