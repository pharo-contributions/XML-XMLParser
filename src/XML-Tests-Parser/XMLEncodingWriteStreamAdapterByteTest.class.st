Class {
	#name : #XMLEncodingWriteStreamAdapterByteTest,
	#superclass : #XMLEncodingWriteStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLEncodingWriteStreamAdapterByteTest >> streamConverterClass [
	^ XMLByteStreamConverter
]
