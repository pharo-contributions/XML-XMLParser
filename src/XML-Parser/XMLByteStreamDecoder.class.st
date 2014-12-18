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
	^ #('' 'ASCII' 'ISO-8859-1' 'iso-ir-100' 'csISOLatin1' 'Latin1' 'Latin-1' 'l1' 'IBM819' 'CP819')
]

{ #category : #decoding }
XMLByteStreamDecoder >> nextFromStream: aStream [
	^ aStream basicNext
]
