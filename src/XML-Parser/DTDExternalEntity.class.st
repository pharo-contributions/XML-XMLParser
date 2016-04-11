"
This is an abstract class for external parsed entities with external replacements that can be inserted into an XML document.

The external replacements are resolved lazily the first time #replacement or #replacementStream is sent.
"
Class {
	#name : #DTDExternalEntity,
	#superclass : #DTDEntity,
	#instVars : [
		'unresolvedReplacement'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #'instance creation' }
DTDExternalEntity class >> name: aName resolver: aResolver publicID: aPublicID systemID: aSystemID baseURI: aBaseURIString [
	^ self new
		setName: aName
		unresolvedReplacement:
			(DTDUnresolvedExternalEntityReplacement
				resolver: aResolver
				publicID: aPublicID
				systemID: aSystemID
				baseURI: aBaseURIString)
]

{ #category : #testing }
DTDExternalEntity >> hasUnresolvedReplacement [
	^ self unresolvedReplacement notNil
]

{ #category : #testing }
DTDExternalEntity >> isExternal [
	^ true
]

{ #category : #printing }
DTDExternalEntity >> printNameOn: aStream [
	aStream
		nextPut: ${;
		nextPutAll: self uri;
		nextPut: $}.
	super printNameOn: aStream.
]

{ #category : #accessing }
DTDExternalEntity >> replacement [
	self resolveReplacement.
	^ super replacement.
]

{ #category : #accessing }
DTDExternalEntity >> replacementStream [
	^ XMLDecodingReadStreamAdapter on: self replacement readStream
]

{ #category : #resolving }
DTDExternalEntity >> resolveReplacement [
	self hasUnresolvedReplacement
		ifTrue: [self unresolvedReplacement resolveForExternalEntity: self]
]

{ #category : #initialization }
DTDExternalEntity >> setName: aName unresolvedReplacement: anUnresolvedReplacement [
	name := aName.
	unresolvedReplacement := anUnresolvedReplacement.
]

{ #category : #accessing }
DTDExternalEntity >> unresolvedReplacement [
	^ unresolvedReplacement
]

{ #category : #accessing }
DTDExternalEntity >> unresolvedReplacement: anUnresolvedReplacement [
	unresolvedReplacement := anUnresolvedReplacement
]
