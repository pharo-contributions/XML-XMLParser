"
This is a base class for parser drivers. Subclasses should override any of the ""handling"" or ""handling - dtd"" messages sent by tokenizers to parse tokens.
"
Class {
	#name : #XMLParserDriver,
	#superclass : #Object,
	#instVars : [
		'entityURIStack'
	],
	#category : #'XML-Parser'
}

{ #category : #accessing }
XMLParserDriver >> baseURI [
	"returns a string with the current base URI at this stage of parsing"
	^ self entityURIStack xmlLastOrNil ifNil: [self documentURI]
]

{ #category : #testing }
XMLParserDriver >> decodesCharacters [
	^ true
]

{ #category : #accessing }
XMLParserDriver >> documentURI [
	^ nil
]

{ #category : #private }
XMLParserDriver >> entityURIStack [
	^ entityURIStack ifNil: [entityURIStack := OrderedCollection new]
]

{ #category : #'handling - dtd' }
XMLParserDriver >> handleAttributeDeclaration: anElement name: anAttribute type: aType defaultPragma: aDefaultPragma defaultValue: aDefaultValue [
]

{ #category : #handling }
XMLParserDriver >> handleCData: aString [
]

{ #category : #handling }
XMLParserDriver >> handleComment: aString [
]

{ #category : #'handling - dtd' }
XMLParserDriver >> handleElementDeclaration: aName contentModel: aContentModel [
]

{ #category : #handling }
XMLParserDriver >> handleEndContentEntityReplacement: aName [

]

{ #category : #'handling - dtd' }
XMLParserDriver >> handleEndDTD [
]

{ #category : #handling }
XMLParserDriver >> handleEndDocument [
]

{ #category : #handling }
XMLParserDriver >> handleEndTag: anElementName [
]

{ #category : #'handling - dtd' }
XMLParserDriver >> handleGeneralEntityDeclaration: aName publicID: aPublicID systemID: aSystemID ndata: aNotation [
]

{ #category : #'handling - dtd' }
XMLParserDriver >> handleGeneralEntityDeclaration: aName replacement: aReplacement [
]

{ #category : #handling }
XMLParserDriver >> handleGeneralEntityReference: aName [
	^ nil
]

{ #category : #'handling - dtd' }
XMLParserDriver >> handleNotationDeclaration: aName publicID: aPublicID systemID: aSystemID [
]

{ #category : #handling }
XMLParserDriver >> handlePCData: aString [
]

{ #category : #handling }
XMLParserDriver >> handlePI: aTargetString data: aDataString [
]

{ #category : #'handling - dtd' }
XMLParserDriver >> handleParameterEntityDeclaration: aName publicID: aPublicID systemID: aSystemID [
]

{ #category : #'handling - dtd' }
XMLParserDriver >> handleParameterEntityDeclaration: aName replacement: aReplacement [
]

{ #category : #'handling - dtd' }
XMLParserDriver >> handleParameterEntityReference: aName [
	^ nil
]

{ #category : #handling }
XMLParserDriver >> handleParseError: aString [
]

{ #category : #handling }
XMLParserDriver >> handleStartContent [
]

{ #category : #handling }
XMLParserDriver >> handleStartContentEntityReplacement: aName [
]

{ #category : #'handling - dtd' }
XMLParserDriver >> handleStartDTD: aRoot publicID: aPublicID systemID: aSystemID [
]

{ #category : #handling }
XMLParserDriver >> handleStartDocument [
]

{ #category : #handling }
XMLParserDriver >> handleStartTag: anElementName attributes: anAttributeDictionary namespaces: aNamespaceDictionary [
]

{ #category : #handling }
XMLParserDriver >> handleUnreplacedGeneralEntityReference: aName [
]

{ #category : #handling }
XMLParserDriver >> handleWhitespace: aString [
]

{ #category : #handling }
XMLParserDriver >> handleXMLVersion: aVersion encoding: anEncoding standalone: aYesOrNo [
]

{ #category : #'instance creation' }
XMLParserDriver >> newInitialContext [
	^ XMLXMLDeclarationContext new
]

{ #category : #'instance creation' }
XMLParserDriver >> newTokenizerOn: aStringOrStream [
	^ self tokenizerClass
		driver: self
		on: aStringOrStream
		readLimit: self readLimit
]

{ #category : #accessing }
XMLParserDriver >> popEntityURI: aURI [
	"remove: removes the first match"
	self entityURIStack removeAt:
		(self entityURIStack
			lastIndexOf: aURI
			ifAbsent: [^ aURI]).
	^ aURI.
]

{ #category : #accessing }
XMLParserDriver >> pushEntityURI: aURIString [
	^ self entityURIStack addLast: aURIString
]

{ #category : #accessing }
XMLParserDriver >> readLimit [
	^ nil
]

{ #category : #private }
XMLParserDriver >> tokenizerClass [
	^ XMLWellFormedParserTokenizer
]
