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
DTDParsedEntity class >> name: aString replacement: aValueString uri: aURI [
	^ self new
		setName: aString
		replacement: aValueString
		uri: aURI
]

{ #category : #'instance creation' }
DTDParsedEntity class >> named: aString [
	^ self
		name: aString
		replacement: ''
]

{ #category : #converting }
DTDParsedEntity >> asReference [
	^ String streamContents: [:stream | self printReferenceOn: stream]
]

{ #category : #replacing }
DTDParsedEntity >> constructReplacementOn: aTokenizer [
	self subclassResponsibility
]

{ #category : #testing }
DTDParsedEntity >> hasReplacement [
	^ self replacement notEmpty
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
	super printOn: aStream.
	aStream nextPut: $(.
	self isExternal
		ifTrue: [
			aStream
				nextPut: ${;
				nextPutAll: self uri;
				nextPut: $}].
	aStream
		nextPutAll: self name;
		nextPut: $).
]

{ #category : #printing }
DTDParsedEntity >> printReferenceOn: aStream [
	aStream
		nextPutAll: self referencePrefix;
		nextPutAll: self name;
		nextPut: $;
]

{ #category : #accessing }
DTDParsedEntity >> referencePrefix [
	self subclassResponsibility
]

{ #category : #accessing }
DTDParsedEntity >> replacement [
	^ replacement ifNil: [replacement := '']
]

{ #category : #initialization }
DTDParsedEntity >> setName: aName replacement: aReplacement uri: aURI [
	name := aName.
	replacement := aReplacement.
	uri := aURI.
]

{ #category : #accessing }
DTDParsedEntity >> uri [
	^ uri ifNil: [uri := '']
]
