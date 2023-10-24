Class {
	#name : #XMLElementDeclarationTest,
	#superclass : #XMLDeclarationNodeTest,
	#category : #'XML-Parser-Tests-DOM'
}

{ #category : #testing }
XMLElementDeclarationTest class >> isAbstract [
	^ false
]

{ #category : #accessing }
XMLElementDeclarationTest >> nodeClass [
	^ XMLElementDeclaration
]

{ #category : #tests }
XMLElementDeclarationTest >> testContentModel [

	| declaration |
	declaration := self newNode.
	self
		assert: declaration contentModel equals: '';
		assert: (declaration contentModel: '(one|two)')
		identicalTo: declaration;
		assert: declaration contentModel equals: '(one|two)'
]

{ #category : #tests }
XMLElementDeclarationTest >> testElement [

	| declaration |
	declaration := self newNode.
	self
		assert: declaration element equals: '';
		assert: (declaration element: 'test') identicalTo: declaration;
		assert: declaration element equals: 'test'
]

{ #category : #tests }
XMLElementDeclarationTest >> testElementContentModel [

	| declaration |
	declaration := self nodeClass
		               element: 'one'
		               contentModel: '(two|three)'.
	self
		assert: declaration class identicalTo: self nodeClass;
		assert: declaration element equals: 'one';
		assert: declaration contentModel equals: '(two|three)'
]

{ #category : #assertions }
XMLElementDeclarationTest >> testWriteXMLOn [

	self
		assert:
			(self nodeClass element: 'one' contentModel: '(two | three)')
				printString
		equals: '<!ELEMENT one (two | three)>'.
	self
		assert:
		(self nodeClass element: 'one' contentModel: 'EMPTY') printString
		equals: '<!ELEMENT one EMPTY>'
]
