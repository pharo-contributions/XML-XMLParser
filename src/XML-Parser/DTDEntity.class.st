"
This is an abstract class for internal and external parsed entities with replacements that can be inserted into an XML document.
"
Class {
	#name : #DTDEntity,
	#superclass : #Object,
	#instVars : [
		'name',
		'replacement',
		'uri'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #'instance creation' }
DTDEntity class >> name: aName replacement: aReplacementString [
	^ self
		name: aName
		replacement: aReplacementString
		uri: ''
]

{ #category : #'instance creation' }
DTDEntity class >> name: aName replacement: aReplacementString uri: aURIString [
	^ self new
		setName: aName
		replacement: aReplacementString
		uri: aURIString
]

{ #category : #'instance creation' }
DTDEntity class >> named: aName [
	^ self
		name: aName
		replacement: ''
]

{ #category : #converting }
DTDEntity >> asPushedBackEntity [
	^ self isParameter
		ifTrue: [XMLPushedBackParameterEntity entity: self]
		ifFalse: [XMLPushedBackGeneralEntity entity: self]
]

{ #category : #converting }
DTDEntity >> asReference [
	^ String streamContents: [:stream | self printReferenceOn: stream]
]

{ #category : #testing }
DTDEntity >> hasReplacement [
	^ self replacement notEmpty
]

{ #category : #testing }
DTDEntity >> isExternal [
	^ false
]

{ #category : #testing }
DTDEntity >> isParameter [
	^ false
]

{ #category : #testing }
DTDEntity >> isStandaloneExternal [
	^ false
]

{ #category : #testing }
DTDEntity >> isUnparsed [
	^ false
]

{ #category : #accessing }
DTDEntity >> name [
	^ name ifNil: [name := '']
]

{ #category : #accessing }
DTDEntity >> name: aName [
	name := aName
]

{ #category : #printing }
DTDEntity >> printNameOn: aStream [
	aStream nextPutAll: self name
]

{ #category : #printing }
DTDEntity >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(.
	self printNameOn: aStream.
	aStream nextPut: $).
]

{ #category : #printing }
DTDEntity >> printReferenceOn: aStream [
	aStream
		nextPut: self referencePrefix;
		nextPutAll: self name;
		nextPut: $;
]

{ #category : #'private ' }
DTDEntity >> referencePrefix [
	^ self isParameter
		ifTrue: [$%]
		ifFalse: [$&]
]

{ #category : #accessing }
DTDEntity >> replacement [
	^ replacement ifNil: [replacement := '']
]

{ #category : #accessing }
DTDEntity >> replacement: aReplacementString [
	replacement := aReplacementString
]

{ #category : #accessing }
DTDEntity >> replacementStream [
	^ self replacement readStream
]

{ #category : #initialization }
DTDEntity >> setName: aName replacement: aReplacementString uri: aURIString [
	name := aName.
	replacement := aReplacementString.
	uri := aURIString.
]

{ #category : #accessing }
DTDEntity >> uri [
	^ uri ifNil: [uri := '']
]

{ #category : #accessing }
DTDEntity >> uri: aURIString [
	uri := aURIString
]
