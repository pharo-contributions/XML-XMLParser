Class {
	#name : #XMLUTF32BigEndianStreamConverterTest,
	#superclass : #XMLStreamConverterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #testing }
XMLUTF32BigEndianStreamConverterTest class >> isAbstract [
	^ false
]

{ #category : #accessing }
XMLUTF32BigEndianStreamConverterTest >> streamConverterClass [
	^ XMLUTF32BigEndianStreamConverter
]
