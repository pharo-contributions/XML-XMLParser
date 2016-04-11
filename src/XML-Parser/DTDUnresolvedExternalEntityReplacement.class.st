"
This class stores an entity resolver and the public ID, system ID, and base URI of an external entity so its replacement can be lazily resolved only if the entity is referenced.
"
Class {
	#name : #DTDUnresolvedExternalEntityReplacement,
	#superclass : #Object,
	#instVars : [
		'resolver',
		'publicID',
		'systemID',
		'baseURI'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #'instance creation' }
DTDUnresolvedExternalEntityReplacement class >> resolver: aResolver publicID: aPublicID systemID: aSystemID baseURI: aBaseURIString [
	^ self new
		setResolver: aResolver
		publicID: aPublicID
		systemID: aSystemID
		baseURI: aBaseURIString
]

{ #category : #accessing }
DTDUnresolvedExternalEntityReplacement >> baseURI [
	^ baseURI ifNil: [baseURI := '']
]

{ #category : #printing }
DTDUnresolvedExternalEntityReplacement >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(.
	self publicID
		ifEmpty: [aStream nextPutAll: 'SYSTEM']
		ifNotEmpty: [
			aStream
				nextPutAll: 'PUBLIC "';
				nextPutAll: self publicID;
				nextPut: $"].
	aStream
		nextPutAll: ' "';
		nextPutAll: self systemID;
		nextPutAll: '")'.
]

{ #category : #accessing }
DTDUnresolvedExternalEntityReplacement >> publicID [
	^ publicID ifNil: [publicID := '']
]

{ #category : #resolving }
DTDUnresolvedExternalEntityReplacement >> resolveForExternalEntity: anExternalEntity [
	| externalEntityURI |

	externalEntityURI :=
		self resolver
			externalEntityURIFromPublicID: self publicID
			systemID: self systemID
			baseURI: self baseURI.

	anExternalEntity
		replacement: (self resolver resolveExternalEntityURI: externalEntityURI);
		uri: externalEntityURI asString;
		unresolvedReplacement: nil.
]

{ #category : #accessing }
DTDUnresolvedExternalEntityReplacement >> resolver [
	^ resolver ifNil: [resolver := DTDExternalEntityResolver default]
]

{ #category : #initialization }
DTDUnresolvedExternalEntityReplacement >> setResolver: aResolver publicID: aPublicID systemID: aSystemID baseURI: aBaseURIString [
	resolver := aResolver.
	publicID := aPublicID.
	systemID := aSystemID.
	baseURI := aBaseURIString.
]

{ #category : #accessing }
DTDUnresolvedExternalEntityReplacement >> systemID [
	^ systemID ifNil: [systemID := '']
]
