Class {
	#name : #XMLCDataTest,
	#superclass : #XMLStringTest,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #accessing }
XMLCDataTest >> nodeClass [
	^ XMLCData
]

{ #category : #accessing }
XMLCDataTest >> nodeTypes [
	^ super nodeTypes copyWith: #isCData
]

{ #category : #tests }
XMLCDataTest >> testPrinting [
	self
		assert: self nodeClass new printString = '<![CDATA[]]>';
		assert: (self nodeClass string: self markupString) printString = ('<![CDATA[', self markupString, ']]>').
]
