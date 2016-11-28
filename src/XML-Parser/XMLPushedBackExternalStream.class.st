"
A class to wrap a nested external stream for XMLNestedStreamReader.
"
Class {
	#name : #XMLPushedBackExternalStream,
	#superclass : #XMLPushedBackStream,
	#category : #'XML-Parser-Streams'
}

{ #category : #testing }
XMLPushedBackExternalStream >> isExternal [
	^ true
]
