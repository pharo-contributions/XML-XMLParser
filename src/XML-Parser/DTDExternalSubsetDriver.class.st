"
This class is a driver for parsing the external subset of a DTD.
"
Class {
	#name : #DTDExternalSubsetDriver,
	#superclass : #XMLParserDriver,
	#instVars : [
		'saxDriver',
		'documentUri'
	],
	#category : #'XML-Parser'
}

{ #category : #'instance creation' }
DTDExternalSubsetDriver class >> saxDriver: aSaxDriver documentURI: anExternalSubsetUri [
	^ self new
		setSAXDriver: aSaxDriver
		documentURI: anExternalSubsetUri 
]

{ #category : #accessing }
DTDExternalSubsetDriver >> documentURI [
	^ documentUri
]

{ #category : #accessing }
DTDExternalSubsetDriver >> dtd [
	^ saxDriver dtd
]

{ #category : #accessing }
DTDExternalSubsetDriver >> externalEntityResolver [
	^ self saxDriver externalEntityResolver
]

{ #category : #'handling tokens' }
DTDExternalSubsetDriver >> handleAttributeDeclaration: anElement name: aName type: aType default: aDefaultDeclaration [
	self isValidating
		ifTrue: [
			self dtd
				addValidatorForAttributeIn: anElement
				named: aName
				type: aType
				default: aDefaultDeclaration]
]

{ #category : #'handling tokens' }
DTDExternalSubsetDriver >> handleElementDeclaration: aName contentModel: aContentModel [
	self isValidating
		ifTrue: [
			self dtd
				addValidatorForElement: aName
				contentModel: aContentModel]
]

{ #category : #'handling tokens' }
DTDExternalSubsetDriver >> handleGeneralEntityDeclaration: aName publicID: aPublicId systemID: aSystemId ndata: aNotation [
	aNotation ifNotEmpty: [
		self dtd unparsedEntityAt: aName put: aNotation.
		^ self].

	self dtd
		generalEntityAt: aName
		put:
			(self externalEntityResolver
				resolveGeneralEntity: aName
				uri: aSystemId
				from: self documentURI).
]

{ #category : #'handling tokens' }
DTDExternalSubsetDriver >> handleGeneralEntityDeclaration: aName replacement: aReplacement [
	self dtd
		generalEntityAt: aName
		put:
			(DTDGeneralEntity 
				name: aName
				replacement: aReplacement
				uri: self documentURI).
]

{ #category : #'handling tokens' }
DTDExternalSubsetDriver >> handleNotationDeclaration: aName publicID: aPublicId systemID: aSystemId [
	self dtd addNotation: aName
]

{ #category : #'handling tokens' }
DTDExternalSubsetDriver >> handleParameterEntityDeclaration: aName publicID: aPublicId systemID: aSystemId [
	self dtd
		parameterEntityAt: aName
		put:
			(self externalEntityResolver
				resolveParameterEntity: aName
				uri: aSystemId
				from: self documentURI).
]

{ #category : #'handling tokens' }
DTDExternalSubsetDriver >> handleParameterEntityDeclaration: aName replacement: aReplacement [
	self dtd
		parameterEntityAt: aName
		put:
			(DTDParameterEntity
				name: aName
				replacement: aReplacement
				uri: self documentURI).
]

{ #category : #'handling tokens' }
DTDExternalSubsetDriver >> handleParameterEntityReference: aName [
	| entity |

	(entity := self dtd parameterEntityAt: aName)
		ifNil: [
			self isValidating
				ifTrue: [
					XMLValidationException signal:
						'Undeclared parameter entity reference %', aName, ';']].
	^ entity.
]

{ #category : #testing }
DTDExternalSubsetDriver >> isValidating [
	^ self saxDriver isValidating
]

{ #category : #testing }
DTDExternalSubsetDriver >> resolvesExternalEntities [
	^ true
]

{ #category : #accessing }
DTDExternalSubsetDriver >> saxDriver [
	^ saxDriver
]

{ #category : #initialization }
DTDExternalSubsetDriver >> setSAXDriver: aSaxdriver documentURI: aUri [
	saxDriver := aSaxdriver.
	documentUri := aUri.
]

{ #category : #initialization }
DTDExternalSubsetDriver >> tokenizerOn: aStringOrStream [
	| tokenizer |

	tokenizer := super tokenizerOn: aStringOrStream.
	tokenizer tokenContext enterExternalSubsetTextDeclaration.

	^ tokenizer.
]

{ #category : #testing }
DTDExternalSubsetDriver >> usesNamespaces [
	^ self saxDriver usesNamespaces
]
