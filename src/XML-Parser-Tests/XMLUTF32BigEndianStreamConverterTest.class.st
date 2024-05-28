Class {
	#name : 'XMLUTF32BigEndianStreamConverterTest',
	#superclass : 'XMLStreamConverterTest',
	#category : 'XML-Parser-Tests-Streams',
	#package : 'XML-Parser-Tests',
	#tag : 'Streams'
}

{ #category : 'testing' }
XMLUTF32BigEndianStreamConverterTest class >> isAbstract [
	^ false
]

{ #category : 'accessing' }
XMLUTF32BigEndianStreamConverterTest >> primaryEncodingName [
	^ 'UTF-32'
]

{ #category : 'accessing' }
XMLUTF32BigEndianStreamConverterTest >> streamConverterClass [
	^ XMLUTF32BigEndianStreamConverter
]
