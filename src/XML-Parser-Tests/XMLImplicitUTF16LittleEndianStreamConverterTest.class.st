Class {
	#name : 'XMLImplicitUTF16LittleEndianStreamConverterTest',
	#superclass : 'XMLUTF16LittleEndianStreamConverterTest',
	#category : 'XML-Parser-Tests-Streams',
	#package : 'XML-Parser-Tests',
	#tag : 'Streams'
}

{ #category : 'testing' }
XMLImplicitUTF16LittleEndianStreamConverterTest >> isImplicit [
	^ true
]

{ #category : 'accessing' }
XMLImplicitUTF16LittleEndianStreamConverterTest >> streamConverterClass [
	^ XMLImplicitUTF16LittleEndianStreamConverter
]
