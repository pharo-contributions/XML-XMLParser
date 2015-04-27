"
A stream decoder for ISO Latin-1  or other byte character streams.
"
Class {
	#name : #XMLByteStreamDecoder,
	#superclass : #XMLStreamDecoder,
	#category : #'XML-Parser-Streams'
}

{ #category : #private }
XMLByteStreamDecoder class >> basicEncodingNames [
	^ #('ASCII' 'Latin-1' 'Latin1' 'CP819' 'IBM819' 'ISO-8859-1' 'ISO-IR-100' 'L1' 'csISOLatin1')
]

{ #category : #decoding }
XMLByteStreamDecoder >> nextFromStream: aStream [
	^ aStream basicNext
]
