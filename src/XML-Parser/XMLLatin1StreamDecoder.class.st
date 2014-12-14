"
A stream decoder for ISO Latin-1 streams.
"
Class {
	#name : #XMLLatin1StreamDecoder,
	#superclass : #XMLStreamDecoder,
	#category : #'XML-Parser-Streams'
}

{ #category : #private }
XMLLatin1StreamDecoder class >> basicEncodingNames [
	^ #('ISO-8859-1' 'iso-ir-100' 'csISOLatin1' 'Latin1' 'Latin-1' 'l1' 'IBM819' 'CP819')
]

{ #category : #decoding }
XMLLatin1StreamDecoder >> nextFromStream: aStream [
	^ aStream basicNext
]
