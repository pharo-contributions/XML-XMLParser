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
DTDParsedEntity class >> name: aName replacement: aReplacementString [
	^ self
		name: aName
		replacement: aReplacementString
		uri: ''
]

{ #category : #'instance creation' }
DTDParsedEntity class >> name: aName replacement: aReplacementString uri: aURIString [
	^ self new
		setName: aName
		replacement: aReplacementString
		uri: aURIString
]

{ #category : #'instance creation' }
DTDParsedEntity class >> named: aName [
	^ self
		name: aName
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

{ #category : #testing }
DTDParsedEntity >> isInternalTo: aURI [
	^ self isExternal not
		and: [self uri = aURI]
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

{ #category : #accessing }
DTDParsedEntity >> replacementStream [
	self isExternal
		ifTrue: [^ XMLDecodingReadStreamAdapter on: self replacement readStream]
		ifFalse: [^ self replacement readStream]
]

{ #category : #initialization }
DTDParsedEntity >> setName: aName replacement: aReplacementString uri: aURIString [
	name := aName.
	replacement := aReplacementString.
	uri := aURIString.
]

{ #category : #accessing }
DTDParsedEntity >> uri [
	^ uri ifNil: [uri := '']
]
