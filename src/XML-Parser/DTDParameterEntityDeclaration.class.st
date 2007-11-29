Class {
	#name : #DTDParameterEntityDeclaration,
	#superclass : #DTDEntityDeclaration,
	#category : #'XML-Parser'
}

{ #category : #'class initialization' }
DTDParameterEntityDeclaration class >> initialize [
	"DTDParameterEntityDeclaration initialize"

	contextBehavior := Dictionary new.
	contextBehavior
		at: #content put: #notRecognized: ;
		at: #attributeValueContent put: #notRecognized: ;
		at: #attributeValue put: #notRecognized: ;
		at: #entityValue put: #include: ;
		at: #dtd put: #includePE:
]

{ #category : #accessing }
DTDParameterEntityDeclaration class >> leadIn [
	^'%'
]

{ #category : #behaviors }
DTDParameterEntityDeclaration >> includePE [
	"Return my expanded value."
	^self include
]

{ #category : #behaviors }
DTDParameterEntityDeclaration >> notRecognized [
	SAXMalformedException signal: 'Malformed entity.'
]

{ #category : #invocation }
DTDParameterEntityDeclaration >> registerIn: aParser [
	aParser parameterEntity: self name put: self
]
