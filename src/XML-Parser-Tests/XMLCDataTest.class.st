Class {
	#name : 'XMLCDataTest',
	#superclass : 'XMLStringTest',
	#category : 'XML-Parser-Tests-DOM',
	#package : 'XML-Parser-Tests',
	#tag : 'DOM'
}

{ #category : 'accessing' }
XMLCDataTest >> nodeClass [
	^ XMLCData
]

{ #category : 'tests' }
XMLCDataTest >> testAcceptNodeVisitor [

	| visitor cdata message |
	visitor := XMLRecordingNodeVisitor new.
	cdata := self newNode.
	self
		assert: (cdata acceptNodeVisitor: visitor) identicalTo: cdata;
		assert: visitor messageRecorder hasMessages.

	message := visitor messageRecorder nextMessage.
	self
		assert: message selector identicalTo: #visitCData:;
		assert: message arguments equals: (Array with: cdata);
		assert: visitor messageRecorder hasMessages.

	message := visitor messageRecorder nextMessage.
	self
		assert: message selector identicalTo: #visitStringNode:;
		assert: message arguments equals: (Array with: cdata);
		deny: visitor messageRecorder hasMessages
]

{ #category : 'tests' }
XMLCDataTest >> testIsCData [
	self assert: self newNode isCData
]

{ #category : 'tests' }
XMLCDataTest >> testWriteXMLOn [

	self
		assert: self newNode printString equals: '<![CDATA[]]>';
		assert: (self nodeClass string: self markupString) printString
		equals: '<![CDATA[' , self markupString , ']]>'
]
