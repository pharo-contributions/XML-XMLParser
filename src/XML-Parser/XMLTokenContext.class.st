"
Abstract class for token parsing contexts.
"
Class {
	#name : #XMLTokenContext,
	#superclass : #Object,
	#category : #'XML-Parser-Drivers'
}

{ #category : #testing }
XMLTokenContext >> canTerminateDocument [
	^ true
]

{ #category : #changing }
XMLTokenContext >> contentContext [
	^ XMLContentContext new
]

{ #category : #changing }
XMLTokenContext >> doctypeDeclarationContext [
	^ XMLDoctypeDeclarationContext new
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
XMLTokenContext >> isDoctypeDeclarationContext [
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
	^ false
]

{ #category : #testing }
XMLTokenContext >> isPostDoctypeDeclarationContext [
	^ false
]

{ #category : #testing }
XMLTokenContext >> isPrologContext [
	^ false
]

{ #category : #testing }
XMLTokenContext >> isTerminatedContext [
	^ false
]

{ #category : #testing }
XMLTokenContext >> isXMLDeclarationContext [
	^ false
]

{ #category : #tokenizing }
XMLTokenContext >> nextTokenFrom: aTokenizer [
	self subclassResponsibility
]

{ #category : #changing }
XMLTokenContext >> postDoctypeDeclarationContext [
	^ XMLPostDoctypeDeclarationContext new
]

{ #category : #changing }
XMLTokenContext >> prologContext [
	^ XMLPrologContext new
]

{ #category : #testing }
XMLTokenContext >> supportsEncodingDetection [
	^ false
]

{ #category : #changing }
XMLTokenContext >> terminatedContext [
	^ XMLTerminatedContext new
]

{ #category : #changing }
XMLTokenContext >> textDeclarationContext [
	^ XMLTextDeclarationContext previousContext: self
]
