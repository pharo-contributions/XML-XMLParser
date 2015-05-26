"
A general entity with an external replacement.
"
Class {
	#name : #DTDExternalGeneralEntity,
	#superclass : #DTDGeneralEntity,
	#category : #'XML-Parser-DTD'
}

{ #category : #testing }
DTDExternalGeneralEntity >> isExternal [
	^ true
]

{ #category : #accessing }
DTDExternalGeneralEntity >> replacementStream [
	^ XMLDecodingReadStreamAdapter onExternalStream: super replacementStream
]
