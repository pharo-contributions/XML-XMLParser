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
XMLByteStreamConverterTest >> primaryEncodingName [
	^ 'Latin-1'
]

{ #category : #accessing }
XMLByteStreamConverterTest >> streamConverterClass [
	^ XMLByteStreamConverter
]
