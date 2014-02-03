"
The context a token occurs in.
"
Class {
	#name : #XMLTokenContext,
	#superclass : #Object,
	#instVars : [
		'context',
		'previousContext'
	],
	#category : #'XML-Parser'
}

{ #category : #testing }
XMLTokenContext >> atEnd [
	^ context == #atEnd
]

{ #category : #'changing context' }
XMLTokenContext >> enterAtEnd [
	context := #atEnd
]

{ #category : #'changing context' }
XMLTokenContext >> enterContent [
	context := #inContent
]

{ #category : #'changing context' }
XMLTokenContext >> enterDoctype [
	context := #inDoctype
]

{ #category : #'changing context' }
XMLTokenContext >> enterExternalSubset [
	context := #inExternalSubset
]

{ #category : #'changing context' }
XMLTokenContext >> enterExternalSubsetTextDeclaration [
	context := #inExternalSubsetTextDeclaration
]

{ #category : #'changing context' }
XMLTokenContext >> enterInternalSubset [
	context := #inInternalSubset
]

{ #category : #'changing context' }
XMLTokenContext >> enterLiteralValue [
	context := #inLiteralValue
]

{ #category : #'changing context' }
XMLTokenContext >> enterProlog [
	context := #inProlog
]

{ #category : #'changing context' }
XMLTokenContext >> enterTextDeclaration [
	context := #inTextDeclaration
]

{ #category : #testing }
XMLTokenContext >> isInContent [
	^ context == #inContent
]

{ #category : #testing }
XMLTokenContext >> isInDoctype [
	^ context == #inDoctype
]

{ #category : #testing }
XMLTokenContext >> isInExternalSubset [
	^ context == #inExternalSubset
		or: [self isInExternalSubsetTextDeclaration]
]

{ #category : #testing }
XMLTokenContext >> isInExternalSubsetTextDeclaration [
	^ context == #inExternalSubsetTextDeclaration
]

{ #category : #testing }
XMLTokenContext >> isInInternalSubset [
	^ context == #inInternalSubset
]

{ #category : #testing }
XMLTokenContext >> isInLiteralValue [
	^ context == #inLiteralValue
]

{ #category : #testing }
XMLTokenContext >> isInProlog [
	^ context == #inProlog
]

{ #category : #testing }
XMLTokenContext >> isInSubset [
	^ self isInInternalSubset or: [self isInExternalSubset]
]

{ #category : #testing }
XMLTokenContext >> isInTextDeclaration [
	^ context == #inTextDeclaration
		or: [self isInExternalSubsetTextDeclaration]
]

{ #category : #testing }
XMLTokenContext >> isInitialized [
	^ context notNil
]

{ #category : #testing }
XMLTokenContext >> notInitialized [
	^ context isNil
]

{ #category : #'changing context' }
XMLTokenContext >> resetPrevious [
	context := previousContext
]

{ #category : #'changing context' }
XMLTokenContext >> saveCurrent [
	previousContext := context
]
