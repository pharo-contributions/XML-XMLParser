Class {
	#name : 'XMLAttributeDeclarationTest',
	#superclass : 'XMLDeclarationNodeTest',
	#category : 'XML-Parser-Tests-DOM',
	#package : 'XML-Parser-Tests',
	#tag : 'DOM'
}

{ #category : 'testing' }
XMLAttributeDeclarationTest class >> isAbstract [
	^ false
]

{ #category : 'accessing' }
XMLAttributeDeclarationTest >> nodeClass [
	^ XMLAttributeDeclaration
]

{ #category : 'tests' }
XMLAttributeDeclarationTest >> testAttribute [

	| declaration |
	declaration := self newNode.
	self
		assert: declaration attribute equals: '';
		assert: (declaration attribute: 'test') identicalTo: declaration;
		assert: declaration attribute equals: 'test'
]

{ #category : 'tests' }
XMLAttributeDeclarationTest >> testDefaultPragma [

	| declaration |
	declaration := self newNode.
	self
		assert: declaration defaultPragma equals: '';
		assert: (declaration defaultPragma: 'REQUIRED')
		identicalTo: declaration;
		assert: declaration defaultPragma equals: 'REQUIRED'
]

{ #category : 'tests' }
XMLAttributeDeclarationTest >> testDefaultValue [

	| declaration |
	declaration := self newNode.
	self
		assert: declaration defaultValue equals: '';
		assert: (declaration defaultValue: 'test') identicalTo: declaration;
		assert: declaration defaultValue equals: 'test'
]

{ #category : 'tests' }
XMLAttributeDeclarationTest >> testElement [

	| declaration |
	declaration := self newNode.
	self
		assert: declaration element equals: '';
		assert: (declaration element: 'test') identicalTo: declaration;
		assert: declaration element equals: 'test'
]

{ #category : 'tests' }
XMLAttributeDeclarationTest >> testElementAttributeTypeDefaultPragmaDefaultValue [

	| declaration |
	declaration := self nodeClass
		               element: 'one'
		               attribute: 'two'
		               type: 'CDATA'
		               defaultPragma: '#IMPLIED'
		               defaultValue: 'default'.
	self
		assert: declaration class identicalTo: self nodeClass;
		assert: declaration element equals: 'one';
		assert: declaration attribute equals: 'two';
		assert: declaration type equals: 'CDATA';
		assert: declaration defaultPragma equals: '#IMPLIED';
		assert: declaration defaultValue equals: 'default'
]

{ #category : 'tests' }
XMLAttributeDeclarationTest >> testType [

	| declaration |
	declaration := self newNode.
	self
		assert: declaration type equals: '';
		assert: (declaration type: 'CDATA') identicalTo: declaration;
		assert: declaration type equals: 'CDATA'
]

{ #category : 'tests' }
XMLAttributeDeclarationTest >> testWriteXMLOn [

	self
		assert: (self nodeClass
				 element: 'one'
				 attribute: 'two'
				 type: 'CDATA'
				 defaultPragma: ''
				 defaultValue: 'three') printString
		equals: '<!ATTLIST one two CDATA "three">'.
	self
		assert: (self nodeClass
				 element: 'one'
				 attribute: 'two'
				 type: 'ENTITY'
				 defaultPragma: 'FIXED'
				 defaultValue: 'three') printString
		equals: '<!ATTLIST one two ENTITY #FIXED "three">'.
	self
		assert: (self nodeClass
				 element: 'one'
				 attribute: 'two'
				 type: '(three|four)'
				 defaultPragma: '#IMPLIED'
				 defaultValue: 'four') printString
		equals: '<!ATTLIST one two (three|four) #IMPLIED>'
]
