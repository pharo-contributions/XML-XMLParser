"
This is an abstract class for token contexts to control tokenization. Subclasses must implement #nextTokenFrom: to send a tokenizing message to the argument tokenizer.
"
Class {
	#name : #XMLTokenContext,
	#superclass : #Object,
	#classInstVars : [
		'instance'
	],
	#category : #'XML-Parser-Drivers'
}

{ #category : #accessing }
XMLTokenContext class >> instance [
	^ instance
		ifNil: [instance := self basicNew initialize]
]

{ #category : #'instance creation' }
XMLTokenContext class >> new [
	"all subclasses are stateless and have a single, immutable, shared instance"
	^ self instance
]

{ #category : #testing }
XMLTokenContext >> canTerminateInput [
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
