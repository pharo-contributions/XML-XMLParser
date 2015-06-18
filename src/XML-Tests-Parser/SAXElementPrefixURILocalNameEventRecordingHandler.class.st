"
This class records the first element events (#startElement:prefix:uri:attributes:localName: and #endElement:prefix:uri:localName:) sent before the others.
"
Class {
	#name : #SAXElementPrefixURILocalNameEventRecordingHandler,
	#superclass : #SAXElementPrefixURIEventRecordingHandler,
	#category : #'XML-Tests-Parser'
}

{ #category : #'handling - content' }
SAXElementPrefixURILocalNameEventRecordingHandler >> endElement: aQualifiedName prefix: aPrefix uri: aURI localName: aLocalName [
	self messageRecorder
		recordMessageReceiver: self
		selector: #endElement:prefix:uri:localName:
		arguments:
			(Array
				with: aQualifiedName
				with: aPrefix
				with: aURI
				with: aLocalName)
]

{ #category : #'handling - content' }
SAXElementPrefixURILocalNameEventRecordingHandler >> startElement: aQualifiedName prefix: aPrefix uri: aURI localName: aLocalName attributes: aDictionary [
	self messageRecorder
		recordMessageReceiver: self
		selector: #startElement:prefix:uri:localName:attributes:
		arguments:
			(OrderedCollection new
				add: aQualifiedName;
				add: aPrefix;
				add: aURI;
				add: aLocalName;
				add: aDictionary;
				asArray)
]
