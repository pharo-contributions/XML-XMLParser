Class {
	#name : 'XMLFileHandleUTF8Test',
	#superclass : 'XMLFileHandleTest',
	#category : 'XML-Parser-Tests-Files',
	#package : 'XML-Parser-Tests',
	#tag : 'Files'
}

{ #category : 'accessing' }
XMLFileHandleUTF8Test >> decodedFileContents [
	^ XMLStreamAdapterTest decodedUTF8String
]

{ #category : 'accessing' }
XMLFileHandleUTF8Test >> encodedFileContents [
	^ XMLStreamAdapterTest encodedUTF8Binary
]

{ #category : 'accessing' }
XMLFileHandleUTF8Test >> streamConverterClass [
	^ XMLUTF8StreamConverter
]
