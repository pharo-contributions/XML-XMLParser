"
This class is a driver for parsing the external subset of a DTD.
"
Class {
	#name : #DTDExternalSubsetParserDriver,
	#superclass : #XMLParserDriver,
	#instVars : [
		'saxDriver',
		'doctypeDefinition',
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
DTDExternalSubsetParserDriver >> doctypeDefinition [
	^ doctypeDefinition
]

{ #category : #accessing }
DTDExternalSubsetParserDriver >> documentURI [
	^ documentUri
]

{ #category : #accessing }
DTDExternalSubsetParserDriver >> externalEntityResolver [
	^ self saxDriver externalEntityResolver
]

{ #category : #'handling tokens' }
DTDExternalSubsetParserDriver >> handleAttributeDeclaration: anElement name: aName type: aType defaultPragma: aDefaultPragma defaultValue: aDefaultValue [
	self isValidating
		ifTrue: [
			self doctypeDefinition
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
			self doctypeDefinition
				addValidatorForElement: aName
				contentModel: aContentModel]
]

{ #category : #'handling tokens' }
DTDExternalSubsetParserDriver >> handleGeneralEntityDeclaration: aName publicID: aPublicId systemID: aSystemId ndata: aNotation [
	aNotation ifNotEmpty: [
		self isValidating
			ifTrue: [
				self doctypeDefinition unparsedEntityValidator
					validateUnparsedEntity: aName
					withNotation: aNotation].
		self doctypeDefinition
			addUnparsedEntity: aName
			ndata: aNotation.
		^ self].

	self doctypeDefinition
		addExternalGeneralEntity: aName
		resolver: self externalEntityResolver
		uri: aSystemId
		from: self currentURI.
]

{ #category : #'handling tokens' }
DTDExternalSubsetParserDriver >> handleGeneralEntityDeclaration: aName replacement: aReplacement [
	self doctypeDefinition
		addGeneralEntity: aName
		replacement: aReplacement
		from: self currentURI
]

{ #category : #'handling tokens' }
DTDExternalSubsetParserDriver >> handleNotationDeclaration: aName publicID: aPublicId systemID: aSystemId [
	self doctypeDefinition addNotation: aName
]

{ #category : #'handling tokens' }
DTDExternalSubsetParserDriver >> handleParameterEntityDeclaration: aName publicID: aPublicId systemID: aSystemId [
	self doctypeDefinition
		addExternalParameterEntity: aName
		resolver: self externalEntityResolver
		uri: aSystemId
		from: self currentURI
]

{ #category : #'handling tokens' }
DTDExternalSubsetParserDriver >> handleParameterEntityDeclaration: aName replacement: aReplacement [
	self doctypeDefinition
		addParameterEntity: aName
		replacement:aReplacement
		from: self currentURI
]

{ #category : #'handling tokens' }
DTDExternalSubsetParserDriver >> handleParameterEntityReference: aName [
	^ self saxDriver handleParameterEntityReference: aName
]

{ #category : #initialization }
DTDExternalSubsetParserDriver >> initialContext [
	^ XMLExternalSubsetContext new textDeclarationContext
]

{ #category : #testing }
DTDExternalSubsetParserDriver >> isParsingExternalSubset [
	^ true
]

{ #category : #testing }
DTDExternalSubsetParserDriver >> isValidating [
	^ self saxDriver isValidating
]

{ #category : #accessing }
DTDExternalSubsetParserDriver >> maxEntityReplacementDepth [
	^ self saxDriver maxEntityReplacementDepth
]

{ #category : #testing }
DTDExternalSubsetParserDriver >> preservesUndeclaredEntityReferences [
	^ self saxDriver preservesUndeclaredEntityReferences
]

{ #category : #accessing }
DTDExternalSubsetParserDriver >> readLimit [
	^ self externalEntityResolver externalSubsetReadLimit
]

{ #category : #testing }
DTDExternalSubsetParserDriver >> replacesContentEntityReferences [
	^ self saxDriver replacesContentEntityReferences
]

{ #category : #testing }
DTDExternalSubsetParserDriver >> resolvesExternalEntities [
	^ self saxDriver resolvesExternalEntities
]

{ #category : #accessing }
DTDExternalSubsetParserDriver >> saxDriver [
	^ saxDriver
]

{ #category : #initialization }
DTDExternalSubsetParserDriver >> setSAXDriver: aSaxdriver documentURI: aUri [
	saxDriver := aSaxdriver.
	doctypeDefinition := aSaxdriver doctypeDefinition.
	documentUri := aUri.
]

{ #category : #testing }
DTDExternalSubsetParserDriver >> usesNamespaces [
	^ self saxDriver usesNamespaces
]
