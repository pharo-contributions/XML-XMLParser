"
A stream converter for implicit big endian UTF-16 streams.
"
Class {
	#name : 'XMLImplicitUTF16BigEndianStreamConverter',
	#superclass : 'XMLUTF16BigEndianStreamConverter',
	#category : 'XML-Parser-Streams',
	#package : 'XML-Parser',
	#tag : 'Streams'
}

{ #category : 'testing' }
XMLImplicitUTF16BigEndianStreamConverter class >> isImplicit [
	^ true
]
