"
This class is a driver for parsing the external subset of a DTD.
"
Class {
	#name : #DTDExternalSubsetParserDriver,
	#superclass : #XMLParserDriver,
	#instVars : [
		'saxDriver',
		'documentUri'
	],
	#category : #'XML-Parser'
}

{ #category : #'instance creation' }
DTDExternalSubsetParserDriver class >> saxDriver: aSaxDriver documentURI: anExternalSubsetUri [
	^ self new
		setSAXDriver: aSaxDriver
		documentURI: anExternalSubsetUri 
]

{ #category : #accessing }
DTDExternalSubsetParserDriver >> documentURI [
	^ documentUri
]

{ #category : #accessing }
DTDExternalSubsetParserDriver >> dtd [
	"direct acceess for speed"
	^ saxDriver dtd
]

{ #category : #accessing }
DTDExternalSubsetParserDriver >> externalEntityResolver [
	^ self saxDriver externalEntityResolver
]

{ #category : #'handling tokens' }
DTDExternalSubsetParserDriver >> handleAttributeDeclaration: anElement name: aName type: aType defaultPragma: aDefaultPragma defaultValue: aDefaultValue [
	self isValidating
		ifTrue: [
			self dtd
				addValidatorForAttributeIn: anElement
				named: aName
				type: aType
				defaultPragma: aDefaultPragma
				defaultValue: aDefaultValue]
]

{ #category : #'handling tokens' }
DTDExternalSubsetParserDriver >> handleElementDeclaration: aName contentModel: aContentModel [
	self isValidating
		ifTrue: [
			self dtd
				addValidatorForElement: aName
				contentModel: aContentModel]
]

{ #category : #'handling tokens' }
DTDExternalSubsetParserDriver >> handleGeneralEntityDeclaration: aName publicID: aPublicId systemID: aSystemId ndata: aNotation [
	aNotation ifNotEmpty: [
		self dtd
			addUnparsedEntity: aName
			ndata: aNotation.
		^ self].

	self dtd
		addExternalGeneralEntity: aName
		resolver: self externalEntityResolver
		uri: aSystemId
		from: self currentURI.
]

{ #category : #'handling tokens' }
DTDExternalSubsetParserDriver >> handleGeneralEntityDeclaration: aName replacement: aReplacement [
	self dtd
		addGeneralEntity: aName
		replacement: aReplacement
		from: self currentURI
]

{ #category : #'handling tokens' }
DTDExternalSubsetParserDriver >> handleNotationDeclaration: aName publicID: aPublicId systemID: aSystemId [
	self dtd addNotation: aName
]

{ #category : #'handling tokens' }
DTDExternalSubsetParserDriver >> handleParameterEntityDeclaration: aName publicID: aPublicId systemID: aSystemId [
	self dtd
		addExternalParameterEntity: aName
		resolver: self externalEntityResolver
		uri: aSystemId
		from: self currentURI
]

{ #category : #'handling tokens' }
DTDExternalSubsetParserDriver >> handleParameterEntityDeclaration: aName replacement: aReplacement [
	self dtd
		addParameterEntity: aName
		replacement:aReplacement
		from: self currentURI
]

{ #category : #'handling tokens' }
DTDExternalSubsetParserDriver >> handleParameterEntityReference: aName [
	| entity |

	entity := self dtd parameterEntityAt: aName.
	(entity isNil and: [self isValidating])
		ifTrue: [
			XMLValidationException signal:
				'Undeclared parameter entity reference %', aName, ';'].

	^ entity.
]

{ #category : #testing }
DTDExternalSubsetParserDriver >> isValidating [
	"direct acceess for speed"
	^ saxDriver isValidating
]

{ #category : #accessing }
DTDExternalSubsetParserDriver >> maxEntityReplacementDepth [
	^ self saxDriver maxEntityReplacementDepth
]

{ #category : #accessing }
DTDExternalSubsetParserDriver >> readLimit [
	^ self saxDriver externalSubsetReadLimit
]

{ #category : #accessing }
DTDExternalSubsetParserDriver >> saxDriver [
	^ saxDriver
]

{ #category : #initialization }
DTDExternalSubsetParserDriver >> setSAXDriver: aSaxdriver documentURI: aUri [
	saxDriver := aSaxdriver.
	documentUri := aUri.
]

{ #category : #initialization }
DTDExternalSubsetParserDriver >> tokenizerOn: aStringOrStream [
	^ (super tokenizerOn: aStringOrStream)
		nextStartExternalSubset;
		yourself
]

{ #category : #testing }
DTDExternalSubsetParserDriver >> usesNamespaces [
	^ self saxDriver usesNamespaces
]
