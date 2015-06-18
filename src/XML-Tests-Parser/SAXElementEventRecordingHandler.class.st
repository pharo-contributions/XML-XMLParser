"
This class records the final element events (startElement:attributes: and #endElement:) used when no others are defined.
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
