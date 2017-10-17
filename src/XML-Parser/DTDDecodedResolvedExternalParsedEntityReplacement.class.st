"
This class stores the decoded resolved replacement of an external parsed entity.
"
Class {
	#name : #DTDDecodedResolvedExternalParsedEntityReplacement,
	#superclass : #DTDResolvedExternalParsedEntityReplacement,
	#instVars : [
		'contents'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #'instance creation' }
DTDDecodedResolvedExternalParsedEntityReplacement class >> contents: aString [
	^ self new setContents: aString
]

{ #category : #accessing }
DTDDecodedResolvedExternalParsedEntityReplacement >> contents [
	^ contents
]

{ #category : #accessing }
DTDDecodedResolvedExternalParsedEntityReplacement >> isEmpty [
	^ self contents isEmpty
]

{ #category : #accessing }
DTDDecodedResolvedExternalParsedEntityReplacement >> readStream [
	^ self contents readStream
]

{ #category : #initialization }
DTDDecodedResolvedExternalParsedEntityReplacement >> setContents: aString [
	contents := aString
]
