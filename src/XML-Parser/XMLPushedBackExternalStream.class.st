"
A class to store a nested external stream for XMLNestedStreamReader.
"
Class {
	#name : 'XMLPushedBackExternalStream',
	#superclass : 'XMLPushedBackStream',
	#category : 'XML-Parser-Drivers',
	#package : 'XML-Parser',
	#tag : 'Drivers'
}

{ #category : 'testing' }
XMLPushedBackExternalStream >> isExternal [
	^ true
]
