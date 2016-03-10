Class {
	#name : #XMLDecodingReadStreamAdapterUTF32BETest,
	#superclass : #XMLDecodingReadStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF32BETest >> encodedInvalidCharacters [
	^ self stringFrom:
		#(16r00 16r00 16rD8 16r00
			16r00 16r00 16rDB 16rFF
			16r00 16r00 16rDC 16r00
			16r00 16r00 16rD8 16rFF
			16r00 16r11 16rFF 16rFF)
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF32BETest >> inputCollection [
	^ self encodedUTF32BEString
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF32BETest >> outputCollection [
	^ self decodedUTF32String
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF32BETest >> streamConverterClass [
	^ XMLUTF32BigEndianStreamConverter
]
