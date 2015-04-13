"
This class records the last element events forwarded to a SAX handler if no others are defined, #startElement:attributes: and #endElement:, using an XMLMessageRecorder.
"
Class {
	#name : #SAXElementEventRecordingHandler,
	#superclass : #SAXHandler,
	#instVars : [
		'messageRecorder'
	],
	#category : #'XML-Tests-Parser'
}

{ #category : #'handling - content' }
SAXElementEventRecordingHandler >> endElement: aQualifiedName [
	self messageRecorder
		recordMessageReceiver: self
		selector: #endElement:
		arguments: (Array with: aQualifiedName)
]

{ #category : #accessing }
SAXElementEventRecordingHandler >> messageRecorder [
	^ messageRecorder ifNil: [messageRecorder := XMLMessageRecorder new]
]

{ #category : #'handling - content' }
SAXElementEventRecordingHandler >> startElement: aQualifiedName attributes: aDictionary [
	self messageRecorder
		recordMessageReceiver: self
		selector: #startElement:attributes:
		arguments: (Array with: aQualifiedName with: aDictionary)
]
