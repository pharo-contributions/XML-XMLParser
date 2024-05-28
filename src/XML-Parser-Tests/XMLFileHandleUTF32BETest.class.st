Class {
	#name : 'XMLFileHandleUTF32BETest',
	#superclass : 'XMLFileHandleTest',
	#category : 'XML-Parser-Tests-Files',
	#package : 'XML-Parser-Tests',
	#tag : 'Files'
}

{ #category : 'accessing' }
XMLFileHandleUTF32BETest >> decodedFileContents [
	^ XMLStreamAdapterTest decodedUTF32String
]

{ #category : 'accessing' }
XMLFileHandleUTF32BETest >> encodedFileContents [
	^ XMLStreamAdapterTest encodedUTF32BEBinary
]

{ #category : 'accessing' }
XMLFileHandleUTF32BETest >> streamConverterClass [
	^ XMLUTF32BigEndianStreamConverter
]
