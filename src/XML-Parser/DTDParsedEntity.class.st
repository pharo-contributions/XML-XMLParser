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
	#category : #'XML-Parser-DTD'
}

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
DTDParsedEntity >> asReference [
	^ self printString
]

{ #category : #replacing }
DTDParsedEntity >> constructReplacementOn: aTokenizer [
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
	aStream
		nextPutAll: self referencePrefix;
		nextPutAll: self name;
		nextPut: $;
]

{ #category : #accessing }
DTDParsedEntity >> referencePrefix [
	self subclassResponsibility
]

{ #category : #replacing }
DTDParsedEntity >> replacement [
	^ replacement ifNil: [replacement := '']
]

{ #category : #initialization }
DTDParsedEntity >> setName: aName replacement: aReplacement uri: aUri [
	name := aName.
	replacement := aReplacement.
	uri := aUri.
]

{ #category : #accessing }
DTDParsedEntity >> uri [
	^ uri ifNil: [uri := '']
]
