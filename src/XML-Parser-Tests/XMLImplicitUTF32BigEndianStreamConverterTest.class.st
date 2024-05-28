Class {
	#name : 'XMLImplicitUTF32BigEndianStreamConverterTest',
	#superclass : 'XMLUTF32BigEndianStreamConverterTest',
	#category : 'XML-Parser-Tests-Streams',
	#package : 'XML-Parser-Tests',
	#tag : 'Streams'
}

{ #category : 'testing' }
XMLImplicitUTF32BigEndianStreamConverterTest >> isImplicit [
	^ true
]

{ #category : 'accessing' }
XMLImplicitUTF32BigEndianStreamConverterTest >> streamConverterClass [
	^ XMLImplicitUTF32BigEndianStreamConverter
]
