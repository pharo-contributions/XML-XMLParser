"
A stream converter for implicit UTF-8 streams.
"
Class {
	#name : 'XMLImplicitUTF8StreamConverter',
	#superclass : 'XMLUTF8StreamConverter',
	#category : 'XML-Parser-Streams',
	#package : 'XML-Parser',
	#tag : 'Streams'
}

{ #category : 'testing' }
XMLImplicitUTF8StreamConverter class >> isImplicit [
	^ true
]
