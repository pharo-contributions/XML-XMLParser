Class {
	#name : #XMLNullStreamConverterTest,
	#superclass : #XMLStreamConverterTest,
	#category : #'XML-Parser-Tests-Streams'
}

{ #category : #testing }
XMLNullStreamConverterTest class >> isAbstract [
	^ false
]

{ #category : #accessing }
XMLNullStreamConverterTest >> streamConverterClass [
	^ XMLNullStreamConverter
]
