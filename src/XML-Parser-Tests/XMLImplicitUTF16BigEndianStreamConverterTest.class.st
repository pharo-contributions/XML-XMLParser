Class {
	#name : 'XMLImplicitUTF16BigEndianStreamConverterTest',
	#superclass : 'XMLUTF16BigEndianStreamConverterTest',
	#category : 'XML-Parser-Tests-Streams',
	#package : 'XML-Parser-Tests',
	#tag : 'Streams'
}

{ #category : 'testing' }
XMLImplicitUTF16BigEndianStreamConverterTest >> isImplicit [
	^ true
]

{ #category : 'accessing' }
XMLImplicitUTF16BigEndianStreamConverterTest >> streamConverterClass [
	^ XMLImplicitUTF16BigEndianStreamConverter
]
