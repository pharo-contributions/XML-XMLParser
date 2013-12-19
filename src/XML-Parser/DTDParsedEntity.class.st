"
This is a base class for internal and external parsed entities with replacements that can be inserted into an XML document.
"
Class {
	#name : #DTDParsedEntity,
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
DTDParsedEntity class >> initialize [
	"self initialize"

	super initialize.

	(LiteralEscapes := IdentityDictionary new)
		at: $" put: '&#34;';
		at: $' put: '&#39;'
]

{ #category : #'instance creation' }
DTDParsedEntity class >> name: aString replacement: aValueString [
	^ self new
		setName: aString
		replacement: aValueString
		uri: nil
]

{ #category : #'instance creation' }
DTDParsedEntity class >> name: aString replacement: aValueString uri: aUri [
	^ self new
		setName: aString
		replacement: aValueString
		uri: aUri
]

{ #category : #'instance creation' }
DTDParsedEntity class >> named: aString [
	^ self
		name: aString
		replacement: ''
]

{ #category : #converting }
DTDParsedEntity >> asEscapedReference [
	^ self asReferenceStartingWith: self escapedReferenceSymbol
]

{ #category : #converting }
DTDParsedEntity >> asReference [
	^ self asReferenceStartingWith: self referenceSymbol asString
]

{ #category : #private }
DTDParsedEntity >> asReferenceStartingWith: aString [
	^ (aString, self name) copyWith: $;
]

{ #category : #accessing }
DTDParsedEntity >> escapedReferenceSymbol [
	self subclassResponsibility
]

{ #category : #testing }
DTDParsedEntity >> isExternal [
	^ false
]

{ #category : #accessing }
DTDParsedEntity >> name [
	^ name ifNil: [name := '']
]

{ #category : #printing }
DTDParsedEntity >> printOn: aStream [
	self asReference printOn: aStream
	
]

{ #category : #accessing }
DTDParsedEntity >> referenceSymbol [
	self subclassResponsibility
]

{ #category : #replacement }
DTDParsedEntity >> replacement [
	^ replacement ifNil: [replacement := '']
]

{ #category : #replacement }
DTDParsedEntity >> replacementForLiteralContext [
	| aReplacement |

	aReplacement := (String new: self replacement size) writeStream.
	self replacement do: [:each |
		(LiteralEscapes includesKey: each)
			ifTrue: [aReplacement nextPutAll: (LiteralEscapes at: each)]
			ifFalse: [aReplacement nextPut: each]].
	^ aReplacement contents.
]

{ #category : #initializing }
DTDParsedEntity >> setName: aName replacement: aReplacement uri: aUri [
	name := aName.
	replacement := aReplacement.
	uri := aUri.
]

{ #category : #accessing }
DTDParsedEntity >> uri [
	^ uri ifNil: [uri := '']
]
