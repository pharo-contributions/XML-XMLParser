Class {
	#name : #XMLDeclarationNodesTest,
	#superclass : #XMLNodeTest,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #assertions }
XMLDeclarationNodesTest >> assertAttributeDecl: anAttributeDeclaration hasElementName: anElementName attributeName: anAttributeName type: aType default: aDefaultPragma value: aDefaultValue [
	| printString |

	self
		assert: anAttributeDeclaration element = anElementName;
		assert: anAttributeDeclaration attribute = anAttributeName;
		assert: anAttributeDeclaration type = aType;
		assert: anAttributeDeclaration defaultPragma = aDefaultPragma;
		assert: anAttributeDeclaration defaultValue = aDefaultValue.

	(printString := String new writeStream)
		nextPutAll: '<!ATTLIST';
		space;
		nextPutAll: anElementName;
		space;
		nextPutAll: anAttributeName;
		space;
		nextPutAll: aType.

	aDefaultPragma ifNotEmpty: [
		printString
			space;
			nextPutAll: (aDefaultPragma copyWithFirst: $#)].

	aDefaultValue ifNotEmpty: [
		printString
			space;
			nextPut: $";
			nextPutAll: aDefaultValue;
			nextPut: $"].

	printString nextPut: $>.
		
	self assert: anAttributeDeclaration printString = printString contents.
]

{ #category : #assertions }
XMLDeclarationNodesTest >> assertElementDecl: anElementDeclaration hasName: aName contentModel: aContentModel [
	self
		assert: anElementDeclaration element = aName;
		assert: anElementDeclaration contentModel = aContentModel;
		assert: anElementDeclaration printString = ('<!ELEMENT ', aName, ' ', aContentModel, '>')
]

{ #category : #assertions }
XMLDeclarationNodesTest >> assertEntityDecl: anEntityDeclaration hasName: aName replacement: aReplacement publicID: aPublicId systemID: aSystemId ndada: anNdata [
	| printString |

	self
		assert: anEntityDeclaration name = aName;
		assert: anEntityDeclaration replacement = aReplacement;
		assert: anEntityDeclaration publicID = aPublicId;
		assert: anEntityDeclaration systemID = aSystemId;
		assert: anEntityDeclaration ndata = anNdata.

	(printString := String new writeStream)
		nextPutAll: '<!ENTITY ';
		nextPutAll: aName;
		space.
	aReplacement
		ifNotEmpty: [
			printString
				nextPut: $";
				nextPutAll: aReplacement;
				nextPut: $"]
		ifEmpty: [
			self
				printExternalIDFromPublicID: aPublicId
				systemID: aSystemId
				on: printString.
			anNdata ifNotEmpty: [
				printString
					space;
					nextPutAll: 'NDATA';
					space;
					nextPutAll: anNdata]].
	printString nextPut: $>.

	self assert: anEntityDeclaration printString = printString contents.
]

{ #category : #assertions }
XMLDeclarationNodesTest >> assertNotationDecl: aNotationDeclaration hasName: aName publicID: aPublicId systemID: aSystemId [
	| printString |

	self
		assert: aNotationDeclaration name = aName;
		assert: aNotationDeclaration publicID = aPublicId;
		assert: aNotationDeclaration systemID = aSystemId.

	(printString := String new writeStream)
		nextPutAll: '<!NOTATION';
		space;
		nextPutAll: aName;
		space.
	self
		printExternalIDFromPublicID: aPublicId
		systemID: aSystemId
		on: printString.
	printString nextPut: $>.

	self assert: aNotationDeclaration printString = printString contents.
]

{ #category : #printing }
XMLDeclarationNodesTest >> printExternalIDFromPublicID: aPublicId systemID: aSystemId on: aStream [
	aPublicId
		ifNotEmpty: [
			aStream
				nextPutAll: 'PUBLIC';
				space;
				nextPut: $";
				nextPutAll: aPublicId;
				nextPut: $"]
		ifEmpty: [aSystemId ifNotEmpty: [aStream nextPutAll: 'SYSTEM']].
	aSystemId ifNotEmpty: [
		aStream
			space;
			nextPut: $";
			nextPutAll: aSystemId;
			nextPut: $"]
	
]

{ #category : #tests }
XMLDeclarationNodesTest >> test1attributeDeclarations [
	self
		assertAttributeDecl: XMLAttributeDeclaration new
		hasElementName: ''
		attributeName: ''
		type: ''
		default: ''
		value: ''.
	self
		assertAttributeDecl:
			(XMLAttributeDeclaration
				element: 'testElement'
				attribute: 'testAttribute'
				type: 'CDATA'
				defaultPragma: 'IMPLIED'
				defaultValue: '')
		hasElementName: 'testElement'
		attributeName: 'testAttribute'
		type: 'CDATA'
		default: 'IMPLIED'
		value: ''.
	self
		assertAttributeDecl:
			(XMLAttributeDeclaration
				element: 'testElement'
				attribute: 'testAttribute'
				type: 'CDATA'
				defaultPragma: ''
				defaultValue:  'one')
		hasElementName: 'testElement'
		attributeName: 'testAttribute'
		type: 'CDATA'
		default: ''
		value: 'one'.
]

{ #category : #tests }
XMLDeclarationNodesTest >> test2elementDeclarations [
	self
		assertElementDecl: XMLElementDeclaration new
		hasName: ''
		contentModel: ''.
	self
		assertElementDecl:
			(XMLElementDeclaration
				element: 'testElement'
				contentModel: '(one,two)')
		hasName: 'testElement'
		contentModel: '(one,two)'.
]

{ #category : #tests }
XMLDeclarationNodesTest >> test3entityDeclarations [
	self
		assertEntityDecl: XMLGeneralEntityDeclaration new
		hasName: ''
		replacement: ''
		publicID: ''
		systemID: ''
		ndada: ''.
	self
		assertEntityDecl:
			(XMLGeneralEntityDeclaration
				name: 'testEntity'
				replacement: 'testReplacement')
		hasName: 'testEntity'
		replacement: 'testReplacement'
		publicID: ''
		systemID: ''
		ndada: ''.
	self
		assertEntityDecl:
			(XMLGeneralEntityDeclaration
				name: 'testEntity'
				publicID: '-//test//test-id//EN'
				systemID: '')
		hasName: 'testEntity'
		replacement: ''
		publicID: '-//test//test-id//EN'
		systemID: ''
		ndada: ''.
	self
		assertEntityDecl:
			(XMLGeneralEntityDeclaration
				name: 'testEntity'
				publicID: '-//test//test-id//EN'
				systemID: 'http://test')
		hasName: 'testEntity'
		replacement: ''
		publicID: '-//test//test-id//EN'
		systemID: 'http://test'
		ndada: ''.
	self
		assertEntityDecl:
			(XMLGeneralEntityDeclaration
				name: 'testEntity'
				publicID: ''
				systemID: 'http://test')
		hasName: 'testEntity'
		replacement: ''
		publicID: ''
		systemID: 'http://test'
		ndada: ''.
	self
		assertEntityDecl:
			(XMLGeneralEntityDeclaration
				name: 'testEntity'
				publicID: '-//test//test-id//EN'
				systemID: 'http://test'
				ndata: 'testNotation')
		hasName: 'testEntity'
		replacement: ''
		publicID: '-//test//test-id//EN'
		systemID: 'http://test'
		ndada: 'testNotation'.
]

{ #category : #tests }
XMLDeclarationNodesTest >> test4notationDeclarations [
	self
		assertNotationDecl: XMLNotationDeclaration new
		hasName: ''
		publicID: ''
		systemID: ''.
	self
		assertNotationDecl:
			(XMLNotationDeclaration
				name: 'testNotation'
				publicID: '//test//'
				systemID: '')
		hasName: 'testNotation'
		publicID: '//test//'
		systemID: ''.
	self
		assertNotationDecl:
			(XMLNotationDeclaration
				name: 'testNotation'
				publicID: '//test//'
				systemID: 'http://test/')
		hasName: 'testNotation'
		publicID: '//test//'
		systemID: 'http://test/'.
	self
		assertNotationDecl:
			(XMLNotationDeclaration
				name: 'testNotation'
				publicID: ''
				systemID: 'http://test/')
		hasName: 'testNotation'
		publicID: ''
		systemID: 'http://test/'.
]
