"
A class for unparsed entities. These should never be referenced with the &name; syntax but can be named in values of ENTITY and ENTITIES attributes.
"
Class {
	#name : #DTDUnparsedEntity,
	#superclass : #DTDEntity,
	#instVars : [
		'ndata'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #'instance creation' }
DTDUnparsedEntity class >> name: aName ndata: aNotationName [
	^ self new
		setName: aName
		ndata: aNotationName
]

{ #category : #testing }
DTDUnparsedEntity >> isUnparsed [
	^ true
]

{ #category : #accessing }
DTDUnparsedEntity >> ndata [
	^ ndata ifNil: [ndata := '']
]

{ #category : #accessing }
DTDUnparsedEntity >> ndata: aNotationName [
	ndata := aNotationName
]

{ #category : #initialization }
DTDUnparsedEntity >> setName: aName ndata: aNotationName [
	name := aName.
	ndata := aNotationName.
]
