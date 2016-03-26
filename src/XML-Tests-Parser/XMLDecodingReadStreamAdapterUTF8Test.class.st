Class {
	#name : #XMLDecodingReadStreamAdapterUTF8Test,
	#superclass : #XMLDecodingReadStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF8Test >> encodedInvalidCharacters [
	^ self stringFrom: #(16rF4 16r9F 16rBF 16rBF)
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF8Test >> inputCollection [
	^ self encodedUTF8String
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF8Test >> outputCollection [
	^ self decodedUTF8String
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF8Test >> streamConverterClass [
	^ XMLUTF8StreamConverter
]
