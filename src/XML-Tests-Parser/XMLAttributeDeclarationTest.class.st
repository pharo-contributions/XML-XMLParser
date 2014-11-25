Class {
	#name : #XMLAttributeDeclarationTest,
	#superclass : #XMLDeclarationNodeTest,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #testing }
XMLAttributeDeclarationTest class >> isAbstract [
	^ false
]

{ #category : #accessing }
XMLAttributeDeclarationTest >> nodeClass [
	^ XMLAttributeDeclaration
]

{ #category : #tests }
XMLAttributeDeclarationTest >> testAttribute [
	self
		assert: self nodeClass new attribute isEmpty;
		assert: (self nodeClass new attribute: 'test') attribute = 'test'
]

{ #category : #tests }
XMLAttributeDeclarationTest >> testDefaultPragma [
	self
		assert: self nodeClass new defaultPragma isEmpty;
		assert: (self nodeClass new defaultPragma: 'REQUIRED') defaultPragma = 'REQUIRED'
]

{ #category : #tests }
XMLAttributeDeclarationTest >> testDefaultValue [
	self
		assert: self nodeClass new defaultValue isEmpty;
		assert: (self nodeClass new defaultValue: 'test') defaultValue = 'test'
]

{ #category : #tests }
XMLAttributeDeclarationTest >> testElement [
	self
		assert: self nodeClass new element isEmpty;
		assert: (self nodeClass new element: 'test') element = 'test'
]

{ #category : #tests }
XMLAttributeDeclarationTest >> testElementAttributeTypeDefaultPragmaDefaultValue [
	| declaration |

	declaration :=
		self nodeClass
			element: 'one'
			attribute: 'two'
			type: 'CDATA'
			defaultPragma: '#IMPLIED'
			defaultValue: 'default'.
	self
		assert: declaration element = 'one';
		assert: declaration attribute = 'two';
		assert: declaration type = 'CDATA';
		assert: declaration defaultPragma = '#IMPLIED';
		assert: declaration defaultValue = 'default'.
]

{ #category : #tests }
XMLAttributeDeclarationTest >> testType [
	self
		assert: self nodeClass new type isEmpty;
		assert: (self nodeClass new type: 'CDATA') type = 'CDATA'
]

{ #category : #tests }
XMLAttributeDeclarationTest >> testWriteXMLOn [
	self assert:
		(self nodeClass
			element: 'one'
			attribute: 'two'
			type: 'CDATA'
			defaultPragma: ''
			defaultValue: 'three') printString = '<!ATTLIST one two CDATA "three">'.
	self assert:
		(self nodeClass
			element: 'one'
			attribute: 'two'
			type: 'ENTITY'
			defaultPragma: 'FIXED'
			defaultValue: 'three') printString = '<!ATTLIST one two ENTITY #FIXED "three">'.
	self assert:
		(self nodeClass
			element: 'one'
			attribute: 'two'
			type: '(three|four)'
			defaultPragma: '#IMPLIED'
			defaultValue: 'four') printString = '<!ATTLIST one two (three|four) #IMPLIED "four">'.
]
