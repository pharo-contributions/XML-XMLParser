Class {
	#name : #DTDEntityDeclaration,
	#superclass : #Object,
	#instVars : [
		'name',
		'value',
		'ndata'
	],
	#classInstVars : [
		'contextBehavior'
	],
	#category : #'XML-Parser'
}

{ #category : #accessing }
DTDEntityDeclaration class >> behaviorForContext: aContext [
	^self contextBehavior at: aContext
]

{ #category : #accessing }
DTDEntityDeclaration class >> contextBehavior [
	^contextBehavior
]

{ #category : #'class initialization' }
DTDEntityDeclaration class >> initialize [
	"DTDEntityDeclaration initialize"

	contextBehavior := Dictionary new.
	contextBehavior
		at: #content put: #include ;
		at: #attributeValueContent put: #includedInLiteral ;
		at: #attributeValue put: #forbidden ;
		at: #entityValue put: #bypass ;
		at: #dtd put: #forbidden 
]

{ #category : #accessing }
DTDEntityDeclaration class >> leadIn [
	^'&'
]

{ #category : #'instance creation' }
DTDEntityDeclaration class >> name: aString value: aValueString [
	^self new
		name: aString;
		value: aValueString
]

{ #category : #behaviors }
DTDEntityDeclaration >> bypass [
	"Return my reference as is."
	^self reference
]

{ #category : #behaviors }
DTDEntityDeclaration >> forbidden [
	self error: 'Forbidden reference usage'
]

{ #category : #behaviors }
DTDEntityDeclaration >> include [
	"Return my expanded value."
	^value ifNil: [SAXWarning signal: 'XML undefined entity ' , name printString]
]

{ #category : #behaviors }
DTDEntityDeclaration >> includedInLiteral [
	"Return my expanded value."
	^self include
]

{ #category : #accessing }
DTDEntityDeclaration >> name [
	^name
]

{ #category : #accessing }
DTDEntityDeclaration >> name: aString [
	name := aString asSymbol
]

{ #category : #accessing }
DTDEntityDeclaration >> ndata [
	^ndata
]

{ #category : #accessing }
DTDEntityDeclaration >> ndata: aString [
	ndata := aString
]

{ #category : #behaviors }
DTDEntityDeclaration >> reference [
	"Return my reference as is."
	^self class leadIn , self name , ';'
]

{ #category : #invocation }
DTDEntityDeclaration >> registerIn: aParser [
	aParser entity: self name put: self
]

{ #category : #accessing }
DTDEntityDeclaration >> value [
	^value
]

{ #category : #accessing }
DTDEntityDeclaration >> value: aString [
	value := aString
]

{ #category : #invocation }
DTDEntityDeclaration >> valueForContext: aContext [
	^self perform: (self class behaviorForContext: aContext)
]
