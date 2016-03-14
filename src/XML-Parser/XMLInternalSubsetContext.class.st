"
A context for internal subset tokens.
"
Class {
	#name : #XMLInternalSubsetContext,
	#superclass : #XMLDoctypeDeclarationContext,
	#instVars : [
		'isLiteralValueContext'
	],
	#category : #'XML-Parser'
}

{ #category : #changing }
XMLInternalSubsetContext >> enterLiteralValue [
	isLiteralValueContext := true
]

{ #category : #changing }
XMLInternalSubsetContext >> exitLiteralValue [
	isLiteralValueContext := false
]

{ #category : #testing }
XMLInternalSubsetContext >> isInternalSubsetContext [
	^ true
]

{ #category : #testing }
XMLInternalSubsetContext >> isLiteralValueContext [
	^ isLiteralValueContext ifNil: [isLiteralValueContext := false]
]

{ #category : #tokenizing }
XMLInternalSubsetContext >> nextTokenFrom: aTokenizer [
	aTokenizer nextInternalSubsetToken
]
