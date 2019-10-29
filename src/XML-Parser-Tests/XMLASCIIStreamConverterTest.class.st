Class {
	#name : #XMLASCIIStreamConverterTest,
	#superclass : #XMLStreamConverterTest,
	#category : #'XML-Parser-Tests-Streams'
}

{ #category : #testing }
XMLASCIIStreamConverterTest class >> isAbstract [
	^ false
]

{ #category : #accessing }
XMLASCIIStreamConverterTest >> primaryEncodingName [
	^ 'ASCII'
]

{ #category : #accessing }
XMLASCIIStreamConverterTest >> streamConverterClass [
	^ XMLASCIIStreamConverter
]
