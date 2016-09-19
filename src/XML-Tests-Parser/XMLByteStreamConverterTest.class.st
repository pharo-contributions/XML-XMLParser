Class {
	#name : #XMLByteStreamConverterTest,
	#superclass : #XMLStreamConverterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #testing }
XMLByteStreamConverterTest class >> isAbstract [
	^ false
]

{ #category : #accessing }
XMLByteStreamConverterTest >> streamConverterClass [
	^ XMLByteStreamConverter
]
