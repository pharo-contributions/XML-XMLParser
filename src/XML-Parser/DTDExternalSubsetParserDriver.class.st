"
This class is used by SAXParserDriver for parsing the external subset of a DTD.
"
Class {
	#name : #DTDExternalSubsetParserDriver,
	#superclass : #XMLParserDriver,
	#instVars : [
		'saxDriver',
		'doctypeDefinition',
		'documentURI'
	],
	#category : #'XML-Parser'
}

{ #category : #'instance creation' }
DTDExternalSubsetParserDriver class >> saxDriver: aSaxDriver documentURI: anExternalSubsetURI [
	^ self new
		setSAXDriver: aSaxDriver
		documentURI: anExternalSubsetURI
]

{ #category : #testing }
DTDExternalSubsetParserDriver >> decodesCharacters [
	^ self saxDriver decodesCharacters
]

{ #category : #accessing }
DTDExternalSubsetParserDriver >> doctypeDefinition [
	^ doctypeDefinition
]

{ #category : #accessing }
DTDExternalSubsetParserDriver >> documentURI [
	^ documentURI
]

{ #category : #accessing }
DTDExternalSubsetParserDriver >> externalEntityResolver [
	^ self saxDriver externalEntityResolver
]

{ #category : #'handling - dtd' }
DTDExternalSubsetParserDriver >> handleAttributeDeclaration: anElement name: anAttribute type: aType defaultPragma: aDefaultPragma defaultValue: aDefaultValue [
	self isValidating
		ifTrue: [
			self doctypeDefinition
				addValidatorForAttributeIn: anElement
				named: anAttribute
				type: aType
				defaultPragma: aDefaultPragma
				defaultValue: aDefaultValue]
]

{ #category : #'handling - dtd' }
DTDExternalSubsetParserDriver >> handleElementDeclaration: aName contentModel: aContentModel [
	self isValidating
		ifTrue: [
			self doctypeDefinition
				addValidatorForElement: aName
				contentModel: aContentModel]
]

{ #category : #'handling - dtd' }
DTDExternalSubsetParserDriver >> handleGeneralEntityDeclaration: aName publicID: aPublicID systemID: aSystemID ndata: aNotation [
	aNotation isEmpty
		ifTrue: [	
			self doctypeDefinition
				addExternalGeneralEntity: aName
				resolver: self externalEntityResolver
				publicID: aPublicID
				systemID: aSystemID
				from: self currentURI]
		ifFalse: [
			self doctypeDefinition
				addUnparsedEntity: aName
				ndata: aNotation]
]

{ #category : #'handling - dtd' }
DTDExternalSubsetParserDriver >> handleGeneralEntityDeclaration: aName replacement: aReplacement [
	self doctypeDefinition
		addGeneralEntity: aName
		replacement: aReplacement
		from: self currentURI
]

{ #category : #'handling - dtd' }
DTDExternalSubsetParserDriver >> handleNotationDeclaration: aName publicID: aPublicID systemID: aSystemID [
	self doctypeDefinition addNotation: aName
]

{ #category : #'handling - dtd' }
DTDExternalSubsetParserDriver >> handleParameterEntityDeclaration: aName publicID: aPublicID systemID: aSystemID [
	self doctypeDefinition
		addExternalParameterEntity: aName
		resolver: self externalEntityResolver
		publicID: aPublicID
		systemID: aSystemID
		from: self currentURI
]

{ #category : #'handling - dtd' }
DTDExternalSubsetParserDriver >> handleParameterEntityDeclaration: aName replacement: aReplacement [
	self doctypeDefinition
		addParameterEntity: aName
		replacement:aReplacement
		from: self currentURI
]

{ #category : #'handling - dtd' }
DTDExternalSubsetParserDriver >> handleParameterEntityReference: aName [
	^ self saxDriver handleParameterEntityReference: aName
]

{ #category : #handling }
DTDExternalSubsetParserDriver >> handleParseError: aString [
	XMLWellFormednessException signal: aString
]

{ #category : #initialization }
DTDExternalSubsetParserDriver >> initialContext [
	^ XMLTextDeclarationContext new
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
DTDExternalSubsetParserDriver >> setSAXDriver: aSaxdriver documentURI: aURI [
	saxDriver := aSaxdriver.
	doctypeDefinition := aSaxdriver doctypeDefinition.
	documentURI := aURI.
]

{ #category : #testing }
DTDExternalSubsetParserDriver >> usesNamespaces [
	^ self saxDriver usesNamespaces
]
