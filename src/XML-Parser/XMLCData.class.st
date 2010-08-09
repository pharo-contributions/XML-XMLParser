Class {
	#name : #XMLCData,
	#superclass : #XMLString,
	#category : #'XML-Parser-Nodes'
}

{ #category : #printing }
XMLCData >> printXMLOn: writer [
	writer cdata: self string
]
