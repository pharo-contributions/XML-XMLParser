Class {
	#name : 'XMLImplicitUTF8StreamConverterTest',
	#superclass : 'XMLUTF8StreamConverterTest',
	#category : 'XML-Parser-Tests-Streams',
	#package : 'XML-Parser-Tests',
	#tag : 'Streams'
}

{ #category : 'testing' }
XMLImplicitUTF8StreamConverterTest >> isImplicit [
	^ true
]

{ #category : 'accessing' }
XMLImplicitUTF8StreamConverterTest >> streamConverterClass [
	^ XMLImplicitUTF8StreamConverter
]
