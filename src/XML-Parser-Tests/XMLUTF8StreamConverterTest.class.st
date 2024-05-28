Class {
	#name : 'XMLUTF8StreamConverterTest',
	#superclass : 'XMLStreamConverterTest',
	#category : 'XML-Parser-Tests-Streams',
	#package : 'XML-Parser-Tests',
	#tag : 'Streams'
}

{ #category : 'testing' }
XMLUTF8StreamConverterTest class >> isAbstract [
	^ false
]

{ #category : 'accessing' }
XMLUTF8StreamConverterTest >> primaryEncodingName [
	^ 'UTF-8'
]

{ #category : 'accessing' }
XMLUTF8StreamConverterTest >> streamConverterClass [
	^ XMLUTF8StreamConverter
]
