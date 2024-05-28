Class {
	#name : 'XMLEncodingWriteStreamAdapterUTF32BETest',
	#superclass : 'XMLEncodingWriteStreamAdapterTest',
	#category : 'XML-Parser-Tests-Streams',
	#package : 'XML-Parser-Tests',
	#tag : 'Streams'
}

{ #category : 'accessing' }
XMLEncodingWriteStreamAdapterUTF32BETest >> basicInputCollection [
	^ self decodedUTF32String
]

{ #category : 'accessing' }
XMLEncodingWriteStreamAdapterUTF32BETest >> basicInvalidInputCollections [
	^ self basicInvalidUTFInputCollections
]

{ #category : 'accessing' }
XMLEncodingWriteStreamAdapterUTF32BETest >> basicOutputCollection [
	^ self encodedUTF32BEBinary
]

{ #category : 'accessing' }
XMLEncodingWriteStreamAdapterUTF32BETest >> streamConverterClass [
	^ XMLUTF32BigEndianStreamConverter
]
