Class {
	#name : #OPRootElement,
	#superclass : #OPGenericElement,
	#category : #'XML-Parser-Opax'
}

{ #category : #printing }
OPRootElement >> printOn: aStream [
	aStream
		nextPutAll: '<?xml version="1.0" encoding="utf-8"?>';
		nextPut: Character cr.
	self children do: [ :each | each printOn: aStream ].
]
