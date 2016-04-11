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
DTDExternalSubsetParserDriver class >> saxDriver: aSAXDriver documentURI: anExternalSubsetURIString [
	^ self new
		setSAXDriver: aSAXDriver
		documentURI: anExternalSubsetURIString
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
				baseURI: self baseURI]
		ifFalse: [
			self doctypeDefinition
				addUnparsedEntity: aName
				ndata: aNotation]
]

{ #category : #'handling - dtd' }
DTDExternalSubsetParserDriver >> handleGeneralEntityDeclaration: aName replacement: aReplacement [
	self doctypeDefinition
		addInternalGeneralEntity: aName
		replacement: aReplacement
		baseURI: self baseURI
]

{ #category : #'handling - dtd' }
DTDExternalSubsetParserDriver >> handleImproperParameterEntityNesting [
	self saxDriver handleImproperParameterEntityNesting
]

{ #category : #'handling - dtd' }
DTDExternalSubsetParserDriver >> handleNotationDeclaration: aName publicID: aPublicID systemID: aSystemID [
	self isValidating
		ifTrue: [
			self doctypeDefinition unparsedEntityValidator
				validateNotationDeclaration: aName].
	self doctypeDefinition addNotation: aName.
]

{ #category : #'handling - dtd' }
DTDExternalSubsetParserDriver >> handleParameterEntityDeclaration: aName publicID: aPublicID systemID: aSystemID [
	self doctypeDefinition
		addExternalParameterEntity: aName
		resolver: self externalEntityResolver
		publicID: aPublicID
		systemID: aSystemID
		baseURI: self baseURI
]

{ #category : #'handling - dtd' }
DTDExternalSubsetParserDriver >> handleParameterEntityDeclaration: aName replacement: aReplacement [
	self doctypeDefinition
		addInternalParameterEntity: aName
		replacement:aReplacement
		baseURI: self baseURI
]

{ #category : #'handling - dtd' }
DTDExternalSubsetParserDriver >> handleParameterEntityReference: aName [
	^ self saxDriver handleParameterEntityReference: aName
]

{ #category : #handling }
DTDExternalSubsetParserDriver >> handleParseError: aString [
	XMLWellFormednessException signal: aString
]

{ #category : #testing }
DTDExternalSubsetParserDriver >> isValidating [
	^ self saxDriver isValidating
]

{ #category : #accessing }
DTDExternalSubsetParserDriver >> maxEntityReplacementDepth [
	^ self saxDriver maxEntityReplacementDepth
]

{ #category : #'instance creation' }
DTDExternalSubsetParserDriver >> newInitialContext [
	^ XMLTextDeclarationContext new
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

{ #category : #accessing }
DTDExternalSubsetParserDriver >> saxDriver [
	^ saxDriver
]

{ #category : #initialization }
DTDExternalSubsetParserDriver >> setSAXDriver: aSAXDriver documentURI: anExternalSubsetURIString [
	saxDriver := aSAXDriver.
	doctypeDefinition := aSAXDriver doctypeDefinition.
	documentURI := anExternalSubsetURIString.
]
