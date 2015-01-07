"
This class is a driver for parsing the external subset of a DTD.
"
Class {
	#name : #DTDExternalSubsetParserDriver,
	#superclass : #XMLParserDriver,
	#instVars : [
		'saxDriver',
		'dtd',
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
	^ dtd
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
		self isValidating
			ifTrue: [
				self dtd unparsedEntityValidator
					validateUnparsedEntity: aName
					withNotation: aNotation].
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
	^ self saxDriver externalSubsetReadLimit
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
	dtd := saxDriver dtd.
	documentUri := aUri.
]

{ #category : #testing }
DTDExternalSubsetParserDriver >> usesNamespaces [
	^ self saxDriver usesNamespaces
]
