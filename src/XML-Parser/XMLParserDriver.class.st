"
This is a base class for parser drivers. Drivers are sent messages by a tokenizer to handle various XML tokens as they are read. To create a driver, subclass this class and override the handler messages and testing messages that control tokenization.
"
Class {
	#name : #XMLParserDriver,
	#superclass : #Object,
	#instVars : [
		'uris'
	],
	#category : #'XML-Parser'
}

{ #category : #accessing }
XMLParserDriver >> currentURI [
	^ self uris
		ifEmpty: [self documentURI]
		ifNotEmpty: [self uris last]
]

{ #category : #accessing }
XMLParserDriver >> currentURI: aUri [
	self uris addLast: aUri
]

{ #category : #accessing }
XMLParserDriver >> documentURI [
	^ nil
]

{ #category : #accessing }
XMLParserDriver >> dtd [
	^ nil
]

{ #category : #'handling tokens' }
XMLParserDriver >> handleAttributeDeclaration: anElement name: anName type: aType defaultPragma: aDefaultPragma defaultValue: aDefaultValue [
]

{ #category : #'handling tokens' }
XMLParserDriver >> handleCData: aString [
]

{ #category : #'handling tokens' }
XMLParserDriver >> handleComment: aString [
]

{ #category : #'handling tokens' }
XMLParserDriver >> handleElementDeclaration: aName contentModel: aContentModel [
]

{ #category : #'handling tokens' }
XMLParserDriver >> handleEndContentEntityReplacement: aName [

]

{ #category : #'handling tokens' }
XMLParserDriver >> handleEndDTD [
]

{ #category : #'handling tokens' }
XMLParserDriver >> handleEndDocument [
]

{ #category : #'handling tokens' }
XMLParserDriver >> handleEndTag: anElementName [
]

{ #category : #'handling tokens' }
XMLParserDriver >> handleGeneralEntityDeclaration: aName publicID: aPublicId systemID: aSystemId ndata: aNotation [
]

{ #category : #'handling tokens' }
XMLParserDriver >> handleGeneralEntityDeclaration: aName replacement: aReplacement [
]

{ #category : #'handling tokens' }
XMLParserDriver >> handleGeneralEntityReference: aName [
	^ nil
]

{ #category : #'handling tokens' }
XMLParserDriver >> handleNotationDeclaration: aName publicID: aPublicId systemID: aSystemId [
]

{ #category : #'handling tokens' }
XMLParserDriver >> handlePCData: aString [
]

{ #category : #'handling tokens' }
XMLParserDriver >> handlePI: piTarget data: piData [
]

{ #category : #'handling tokens' }
XMLParserDriver >> handleParameterEntityDeclaration: aName publicID: aPublicId systemID: aSystemId [
]

{ #category : #'handling tokens' }
XMLParserDriver >> handleParameterEntityDeclaration: aName replacement: aReplacement [
]

{ #category : #'handling tokens' }
XMLParserDriver >> handleParameterEntityReference: aName [
	^ nil
]

{ #category : #'handling tokens' }
XMLParserDriver >> handleParseError: anErrorString [
	XMLWellFormednessException signal: anErrorString
]

{ #category : #'handling tokens' }
XMLParserDriver >> handleStartContentEntityReplacement: aName [
]

{ #category : #'handling tokens' }
XMLParserDriver >> handleStartDTD: aRoot publicID: aPublicId systemID: aSystemId [
]

{ #category : #'handling tokens' }
XMLParserDriver >> handleStartDocument [
]

{ #category : #'handling tokens' }
XMLParserDriver >> handleStartTag: anElementName attributes: anAttributeDictionary namespaces: aNamespaceDictionary [
]

{ #category : #'handling tokens' }
XMLParserDriver >> handleUnreplacedGeneralEntityReference: aName [
]

{ #category : #'handling tokens' }
XMLParserDriver >> handleWhitespace: aString [
]

{ #category : #'handling tokens' }
XMLParserDriver >> handleXMLVersion: aVersion encoding: anEncoding standalone: aYesOrNo [
]

{ #category : #initialization }
XMLParserDriver >> initialContext [
	^ nil
]

{ #category : #testing }
XMLParserDriver >> isParsingExternalSubset [
	^ false
]

{ #category : #testing }
XMLParserDriver >> isValidating [
	^ false
]

{ #category : #testing }
XMLParserDriver >> preservesUndeclaredEntityReferences [
	^ false
]

{ #category : #accessing }
XMLParserDriver >> readLimit [
	^ nil
]

{ #category : #accessing }
XMLParserDriver >> removeURI: aUri [
	"remove: removes the first match"
	self uris removeAt:
		(self uris
			lastIndexOf: aUri
			ifAbsent: [^ self])
]

{ #category : #testing }
XMLParserDriver >> replacesContentEntityReferences [
	^ true
]

{ #category : #testing }
XMLParserDriver >> resolvesExternalEntities [
	^ false
]

{ #category : #private }
XMLParserDriver >> tokenizerClass [
	^ XMLWellFormedParserTokenizer
]

{ #category : #initialization }
XMLParserDriver >> tokenizerOn: aStringOrStream [
	^ self tokenizerClass
		driver: self
		on: aStringOrStream
		readLimit: self readLimit
]

{ #category : #private }
XMLParserDriver >> uris [
	^ uris ifNil: [uris := OrderedCollection new]
]

{ #category : #testing }
XMLParserDriver >> usesNamespaces [
	^ true
]
