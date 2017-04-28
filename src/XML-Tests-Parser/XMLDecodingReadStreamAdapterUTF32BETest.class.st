Class {
	#name : #XMLDecodingReadStreamAdapterUTF32BETest,
	#superclass : #XMLDecodingReadStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF32BETest >> inputCollection [
	^ self encodedUTF32BEString
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF32BETest >> invalidEncodedInputCollections [
	^ #(
			#(16r00 16r00 16rD8 16r00) "first surrogate code point"
			#(16r00 16r00 16rDB 16rFF) "last surrogate code point"
			#(16r00 16r11 16r00 16r00) "greater than U+10FFFF"
		) collect: [:each | self stringFrom: each]
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF32BETest >> outputCollection [
	^ self decodedUTF32String
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF32BETest >> streamConverterClass [
	^ XMLUTF32BigEndianStreamConverter
]
