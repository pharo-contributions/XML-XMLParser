"
This class records the second element events forwarded to a SAX handler if the first are defined, #startElement:prefix:uri:attributes: and #endElement:prefix:uri:
"
Class {
	#name : #SAXElementPrefixURIEventRecordingHandler,
	#superclass : #SAXElementEventRecordingHandler,
	#category : #'XML-Tests-Parser'
}

{ #category : #'handling - content' }
SAXElementPrefixURIEventRecordingHandler >> endElement: aQualifiedName prefix: aPrefix uri: aURI [
	self messageRecorder
		recordMessageReceiver: self
		selector: #endElement:prefix:uri:
		arguments:
			(Array
				with: aQualifiedName
				with: aPrefix
				with: aURI)
]

{ #category : #'handling - content' }
SAXElementPrefixURIEventRecordingHandler >> startElement: aQualifiedName prefix: aPrefix uri: aURI attributes: aDictionary [
	self messageRecorder
		recordMessageReceiver: self
		selector: #startElement:prefix:uri:attributes:
		arguments:
			(Array
				with: aQualifiedName
				with: aPrefix
				with: aURI
				with: aDictionary)
]
