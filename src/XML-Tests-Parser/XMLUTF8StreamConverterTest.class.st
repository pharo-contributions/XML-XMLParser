Class {
	#name : #XMLUTF8StreamConverterTest,
	#superclass : #XMLStreamConverterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLUTF8StreamConverterTest >> streamConverterClass [
	^ XMLUTF8StreamConverter
]

{ #category : #tests }
XMLUTF8StreamConverterTest >> testIsDefault [
	self assert: self newStreamConverter isDefault
]
