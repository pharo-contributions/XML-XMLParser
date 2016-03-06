Class {
	#name : #XMLNullStreamConverterTest,
	#superclass : #XMLStreamConverterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLNullStreamConverterTest >> streamConverterClass [
	^ XMLNullStreamConverter
]

{ #category : #tests }
XMLNullStreamConverterTest >> testIsNull [
	self assert: self newStreamConverter isNull
]
