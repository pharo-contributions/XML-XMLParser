"
This is a base class for SAX declaration handler classes that can be injected into SAX2Parser instances before parsing.
"
Class {
	#name : #SAXDeclarationHandler,
	#superclass : #Object,
	#category : #'XML-Parser'
}

{ #category : #'handling - declaration' }
SAXDeclarationHandler >> attributeDeclaration: anElementName name: anAttributeName type: aType defaultPragma: aDefaultPragma defaultValue: aDefaultValue [
]

{ #category : #'handling - declaration' }
SAXDeclarationHandler >> elementDeclaration: anElementName contentModel: aContentModel [

]

{ #category : #'handling - declaration' }
SAXDeclarationHandler >> generalEntityDeclaration: aName publicID: aPublicID systemID: aSystemID ndata: aNotationName [
]

{ #category : #'handling - declaration' }
SAXDeclarationHandler >> generalEntityDeclaration: aName replacement: aReplacement [
]

{ #category : #'handling - declaration' }
SAXDeclarationHandler >> notationDeclaration: aName publicID: aPublicID systemID: aSystemID [

]

{ #category : #'handling - declaration' }
SAXDeclarationHandler >> parameterEntityDeclaration: aName publicID: aPublicID systemID: aSystemID [
]

{ #category : #'handling - declaration' }
SAXDeclarationHandler >> parameterEntityDeclaration: aName replacement: aReplacement [
]
