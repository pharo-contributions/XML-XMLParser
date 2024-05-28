Class {
	#name : 'XMLNullStreamConverterTest',
	#superclass : 'XMLStreamConverterTest',
	#category : 'XML-Parser-Tests-Streams',
	#package : 'XML-Parser-Tests',
	#tag : 'Streams'
}

{ #category : 'testing' }
XMLNullStreamConverterTest class >> isAbstract [
	^ false
]

{ #category : 'accessing' }
XMLNullStreamConverterTest >> streamConverterClass [
	^ XMLNullStreamConverter
]
