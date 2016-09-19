Class {
	#name : #XMLUTF32LittleEndianStreamConverterTest,
	#superclass : #XMLStreamConverterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #testing }
XMLUTF32LittleEndianStreamConverterTest class >> isAbstract [
	^ false
]

{ #category : #accessing }
XMLUTF32LittleEndianStreamConverterTest >> streamConverterClass [
	^ XMLUTF32LittleEndianStreamConverter
]
