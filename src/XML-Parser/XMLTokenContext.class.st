"
The context a token occurs in.
"
Class {
	#name : #XMLTokenContext,
	#superclass : #Object,
	#instVars : [
		'isLiteralValueContext'
	],
	#category : #'XML-Parser'
}

{ #category : #changing }
XMLTokenContext >> contentContext [
	^ XMLContentContext new
]

{ #category : #changing }
XMLTokenContext >> doctypeContext [
	^ XMLDoctypeContext new
]

{ #category : #changing }
XMLTokenContext >> enterLiteralValue [
	isLiteralValueContext := true
]

{ #category : #changing }
XMLTokenContext >> exitLiteralValue [
	isLiteralValueContext := false
]

{ #category : #changing }
XMLTokenContext >> externalSubsetContext [
	^ XMLExternalSubsetContext new
]

{ #category : #changing }
XMLTokenContext >> internalSubsetContext [
	^ XMLInternalSubsetContext new
]

{ #category : #testing }
XMLTokenContext >> isContentContext [
	^ false
]

{ #category : #testing }
XMLTokenContext >> isDoctypeContext [
	^ false
]

{ #category : #testing }
XMLTokenContext >> isExternalSubsetContext [
	^ false
]

{ #category : #testing }
XMLTokenContext >> isInitializedContext [
	^ true
]

{ #category : #testing }
XMLTokenContext >> isInternalSubsetContext [
	^ false
]

{ #category : #testing }
XMLTokenContext >> isLiteralValueContext [
	^ isLiteralValueContext ifNil: [isLiteralValueContext := false]
]

{ #category : #testing }
XMLTokenContext >> isPrologContext [
	^ false
]

{ #category : #testing }
XMLTokenContext >> isSubsetContext [
	^ false
]

{ #category : #testing }
XMLTokenContext >> isTerminatedContext [
	^ false
]

{ #category : #testing }
XMLTokenContext >> isTextDeclarationContext [
	^ false
]

{ #category : #tokenizing }
XMLTokenContext >> nextTokenFrom: aTokenizer [
	self subclassResponsibility
]

{ #category : #changing }
XMLTokenContext >> prologContext [
	^ XMLPrologContext new
]

{ #category : #changing }
XMLTokenContext >> terminatedContext [
	^ XMLTerminatedContext new
]

{ #category : #changing }
XMLTokenContext >> textDeclarationContext [
	^ XMLTextDeclarationContext previousContext: self
]
