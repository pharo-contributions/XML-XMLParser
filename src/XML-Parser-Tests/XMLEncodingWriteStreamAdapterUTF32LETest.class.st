Class {
	#name : 'XMLEncodingWriteStreamAdapterUTF32LETest',
	#superclass : 'XMLEncodingWriteStreamAdapterTest',
	#category : 'XML-Parser-Tests-Streams',
	#package : 'XML-Parser-Tests',
	#tag : 'Streams'
}

{ #category : 'accessing' }
XMLEncodingWriteStreamAdapterUTF32LETest >> basicInputCollection [
	^ self decodedUTF32String
]

{ #category : 'accessing' }
XMLEncodingWriteStreamAdapterUTF32LETest >> basicInvalidInputCollections [
	^ self basicInvalidUTFInputCollections
]

{ #category : 'accessing' }
XMLEncodingWriteStreamAdapterUTF32LETest >> basicOutputCollection [
	^ self encodedUTF32LEBinary
]

{ #category : 'accessing' }
XMLEncodingWriteStreamAdapterUTF32LETest >> streamConverterClass [
	^ XMLUTF32LittleEndianStreamConverter
]
