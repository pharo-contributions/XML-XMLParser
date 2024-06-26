Class {
	#name : 'XMLDecodingReadStreamAdapterASCIITest',
	#superclass : 'XMLDecodingReadStreamAdapterTest',
	#category : 'XML-Parser-Tests-Streams',
	#package : 'XML-Parser-Tests',
	#tag : 'Streams'
}

{ #category : 'accessing' }
XMLDecodingReadStreamAdapterASCIITest >> basicInputCollection [
	^ self encodedASCIIBinary
]

{ #category : 'accessing' }
XMLDecodingReadStreamAdapterASCIITest >> basicInvalidInputCollections [
	^ (16r80 to: 16rFF) asArray collect: [:each | ByteArray with: each]
]

{ #category : 'accessing' }
XMLDecodingReadStreamAdapterASCIITest >> basicOutputCollection [
	^ self decodedASCIIString
]

{ #category : 'accessing' }
XMLDecodingReadStreamAdapterASCIITest >> streamConverterClass [
	^ XMLASCIIStreamConverter
]
