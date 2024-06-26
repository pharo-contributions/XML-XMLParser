Class {
	#name : 'XMLUTF32LittleEndianStreamConverterTest',
	#superclass : 'XMLStreamConverterTest',
	#category : 'XML-Parser-Tests-Streams',
	#package : 'XML-Parser-Tests',
	#tag : 'Streams'
}

{ #category : 'testing' }
XMLUTF32LittleEndianStreamConverterTest class >> isAbstract [
	^ false
]

{ #category : 'accessing' }
XMLUTF32LittleEndianStreamConverterTest >> primaryEncodingName [
	^ 'UTF-32-LE'
]

{ #category : 'accessing' }
XMLUTF32LittleEndianStreamConverterTest >> streamConverterClass [
	^ XMLUTF32LittleEndianStreamConverter
]
