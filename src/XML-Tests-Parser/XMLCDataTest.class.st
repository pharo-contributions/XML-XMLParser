Class {
	#name : #XMLCDataTest,
	#superclass : #XMLStringTest,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #accessing }
XMLCDataTest >> nodeClass [
	^ XMLCData
]

{ #category : #tests }
XMLCDataTest >> testIsCData [
	self assert: self nodeClass new isCData
]

{ #category : #tests }
XMLCDataTest >> testWriteXMLOn [
	self
		assert: self nodeClass new printString = '<![CDATA[]]>';
		assert: (self nodeClass string: self markupString) printString = ('<![CDATA[', self markupString, ']]>').
]
