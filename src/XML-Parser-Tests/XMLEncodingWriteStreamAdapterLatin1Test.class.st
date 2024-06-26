Class {
	#name : 'XMLEncodingWriteStreamAdapterLatin1Test',
	#superclass : 'XMLEncodingWriteStreamAdapterTest',
	#category : 'XML-Parser-Tests-Streams',
	#package : 'XML-Parser-Tests',
	#tag : 'Streams'
}

{ #category : 'accessing' }
XMLEncodingWriteStreamAdapterLatin1Test >> basicInputCollection [
	^ self decodedLatin1String
]

{ #category : 'accessing' }
XMLEncodingWriteStreamAdapterLatin1Test >> basicInvalidInputCollections [
	^ self basicInvalidLatin1InputCollections
]

{ #category : 'accessing' }
XMLEncodingWriteStreamAdapterLatin1Test >> basicOutputCollection [
	^ self encodedLatin1Binary
]

{ #category : 'accessing' }
XMLEncodingWriteStreamAdapterLatin1Test >> streamConverterClass [
	^ XMLLatin1StreamConverter
]
