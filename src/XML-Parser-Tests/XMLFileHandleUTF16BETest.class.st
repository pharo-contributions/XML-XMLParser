Class {
	#name : #XMLFileHandleUTF16BETest,
	#superclass : #XMLFileHandleTest,
	#category : #'XML-Parser-Tests-Files'
}

{ #category : #accessing }
XMLFileHandleUTF16BETest >> decodedFileContents [
	^ XMLStreamAdapterTest decodedUTF16String
]

{ #category : #accessing }
XMLFileHandleUTF16BETest >> encodedFileContents [
	^ XMLStreamAdapterTest encodedUTF16BEBinary
]

{ #category : #accessing }
XMLFileHandleUTF16BETest >> streamConverterClass [
	^ XMLUTF16BigEndianStreamConverter
]
