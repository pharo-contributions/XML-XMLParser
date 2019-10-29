Class {
	#name : #XMLImplicitUTF16BigEndianStreamConverterTest,
	#superclass : #XMLUTF16BigEndianStreamConverterTest,
	#category : #'XML-Parser-Tests-Streams'
}

{ #category : #testing }
XMLImplicitUTF16BigEndianStreamConverterTest >> isImplicit [
	^ true
]

{ #category : #accessing }
XMLImplicitUTF16BigEndianStreamConverterTest >> streamConverterClass [
	^ XMLImplicitUTF16BigEndianStreamConverter
]
