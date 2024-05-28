Class {
	#name : 'XMLImplicitUTF32LittleEndianStreamConverterTest',
	#superclass : 'XMLUTF32LittleEndianStreamConverterTest',
	#category : 'XML-Parser-Tests-Streams',
	#package : 'XML-Parser-Tests',
	#tag : 'Streams'
}

{ #category : 'testing' }
XMLImplicitUTF32LittleEndianStreamConverterTest >> isImplicit [
	^ true
]

{ #category : 'accessing' }
XMLImplicitUTF32LittleEndianStreamConverterTest >> streamConverterClass [
	^ XMLImplicitUTF32LittleEndianStreamConverter
]
