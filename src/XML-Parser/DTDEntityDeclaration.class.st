Class {
	#name : #DTDEntityDeclaration,
	#superclass : #Object,
	#instVars : [
		'name',
		'replacement',
		'uri'
	],
	#classVars : [
		'LiteralEscapes'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #'class initialization' }
DTDEntityDeclaration class >> initialize [
	"self initialize"

	(LiteralEscapes := IdentityDictionary new)
		at: $" put: '&#34;';
		at: $' put: '&#39;'
]

{ #category : #'instance creation' }
DTDEntityDeclaration class >> name: aString replacement: aValueString [
	^ self new
		setName: aString
		replacement: aValueString
		uri: nil
]

{ #category : #'instance creation' }
DTDEntityDeclaration class >> name: aString replacement: aValueString uri: aUri [
	^ self new
		setName: aString
		replacement: aValueString
		uri: aUri
]

{ #category : #converting }
DTDEntityDeclaration >> asReference [
	^ self referenceSymbol asString, self name, ';'
]

{ #category : #testing }
DTDEntityDeclaration >> isExternal [
	^ false
]

{ #category : #accessing }
DTDEntityDeclaration >> name [
	^ name ifNil: [name := '']
]

{ #category : #printing }
DTDEntityDeclaration >> printOn: aStream [
	self asReference printOn: aStream
	
]

{ #category : #accessing }
DTDEntityDeclaration >> referenceSymbol [
	self subclassResponsibility
]

{ #category : #accessing }
DTDEntityDeclaration >> replacement [
	^ replacement ifNil: [replacement := '']
]

{ #category : #replacement }
DTDEntityDeclaration >> replacementForLiteralContext [
	| aReplacement |

	aReplacement := (String new: self replacement size) writeStream.
	self replacement do: [:each |
		(LiteralEscapes includesKey: each)
			ifTrue: [aReplacement nextPutAll: (LiteralEscapes at: each)]
			ifFalse: [aReplacement nextPut: each]].
	^ aReplacement contents.
]

{ #category : #accessing }
DTDEntityDeclaration >> setName: aName replacement: aReplacement uri: aUri [
	name := aName.
	replacement := aReplacement.
	uri := aUri.
]

{ #category : #accessing }
DTDEntityDeclaration >> uri [
	^ uri ifNil: [uri := '']
]
