Class {
	#name : #XMLImplicitUTF32BigEndianStreamConverterTest,
	#superclass : #XMLUTF32BigEndianStreamConverterTest,
	#category : #'XML-Parser-Tests-Streams'
}

{ #category : #testing }
XMLImplicitUTF32BigEndianStreamConverterTest >> isImplicit [
	^ true
]

{ #category : #accessing }
XMLImplicitUTF32BigEndianStreamConverterTest >> streamConverterClass [
	^ XMLImplicitUTF32BigEndianStreamConverter
]
