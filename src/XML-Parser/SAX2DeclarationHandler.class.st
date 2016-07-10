"
This is a base class for SAX declaration handler classes that can be injected into SAX2Parser instances before parsing.
"
Class {
	#name : #SAX2DeclarationHandler,
	#superclass : #Object,
	#category : #'XML-Parser'
}

{ #category : #'handling - declaration' }
SAX2DeclarationHandler >> attributeDeclaration: anElementName name: anAttributeName type: aType defaultPragma: aDefaultPragma defaultValue: aDefaultValue [
]

{ #category : #'handling - declaration' }
SAX2DeclarationHandler >> elementDeclaration: anElementName contentModel: aContentModel [

]

{ #category : #'handling - declaration' }
SAX2DeclarationHandler >> generalEntityDeclaration: aName publicID: aPublicID systemID: aSystemID ndata: aNotationName [
]

{ #category : #'handling - declaration' }
SAX2DeclarationHandler >> generalEntityDeclaration: aName replacement: aReplacement [
]

{ #category : #'handling - declaration' }
SAX2DeclarationHandler >> notationDeclaration: aName publicID: aPublicID systemID: aSystemID [

]

{ #category : #'handling - declaration' }
SAX2DeclarationHandler >> parameterEntityDeclaration: aName publicID: aPublicID systemID: aSystemID [
]

{ #category : #'handling - declaration' }
SAX2DeclarationHandler >> parameterEntityDeclaration: aName replacement: aReplacement [
]
