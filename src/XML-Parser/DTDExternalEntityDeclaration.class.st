Class {
	#name : #DTDExternalEntityDeclaration,
	#superclass : #DTDEntityDeclaration,
	#category : #'XML-Parser'
}

{ #category : #'class initialization' }
DTDExternalEntityDeclaration class >> initialize [
	"DTDExternalEntityDeclaration initialize"

	contextBehavior := Dictionary new.
	contextBehavior
		at: #content put: #include ;
		at: #attributeValueContent put: #includedInLiteral ;
		at: #attributeValue put: #forbidden ;
		at: #entityValue put: #bypass ;
		at: #dtd put: #forbidden 
]
