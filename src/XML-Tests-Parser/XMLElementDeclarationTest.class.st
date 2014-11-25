Class {
	#name : #XMLElementDeclarationTest,
	#superclass : #XMLDeclarationNodeTest,
	#category : #'XML-Tests-Parser-DOM'
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
	self
		assert: self nodeClass new contentModel isEmpty;
		assert: (self nodeClass new contentModel: '(one|two)') contentModel = '(one|two)'
]

{ #category : #tests }
XMLElementDeclarationTest >> testElement [
	self
		assert: self nodeClass new element isEmpty;
		assert: (self nodeClass new element: 'test') element = 'test'
]

{ #category : #tests }
XMLElementDeclarationTest >> testElementContentModel [
	| declaration |

	declaration :=
		self nodeClass
			element: 'one'
			contentModel: '(two|three)'.
	self
		assert: declaration element = 'one';
		assert: declaration contentModel = '(two|three)'
]

{ #category : #assertions }
XMLElementDeclarationTest >> testWriteXMLOn [
	self assert:
		(self nodeClass
			element: 'one'
			contentModel: '(two | three)') printString = '<!ELEMENT one (two | three)>'.
	self assert:
		(self nodeClass
			element: 'one'
			contentModel: 'EMPTY') printString = '<!ELEMENT one EMPTY>'.
]
