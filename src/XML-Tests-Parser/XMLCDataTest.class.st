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
XMLCDataTest >> testAcceptNodeVisitor [
	| visitor cdata message |

	visitor := XMLRecordingNodeVisitor new.
	cdata := self nodeClass new.
	self
		assert: (cdata acceptNodeVisitor: visitor) == cdata;
		assert: visitor messageRecorder hasMessages.

	message := visitor messageRecorder nextMessage.
	self
		assert: message selector == #visitCData:;
		assert: message arguments = (Array with: cdata);
		assert: visitor messageRecorder hasMessages.

	message := visitor messageRecorder nextMessage.
	self
		assert: message selector == #visitStringNode:;
		assert: message arguments = (Array with: cdata);
		deny: visitor messageRecorder hasMessages.
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
