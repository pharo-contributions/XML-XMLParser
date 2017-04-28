Class {
	#name : #XMLDecodingReadStreamAdapterUTF8Test,
	#superclass : #XMLDecodingReadStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF8Test >> inputCollection [
	^ self encodedUTF8String
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF8Test >> invalidEncodedInputCollections [
	^ #(
			#(16rC0 16r80) "first two byte overlong"
			#(16rC1 16rBF) "last two byte overlong"
			#(16rE0 16r80 16r80) "first three byte overlong"
			#(16rE0 16r9F 16rBF) "last three byte overlong"
			#(16rED 16rA0 16r80) "first surrogate"
			#(16rED 16rBF 16rBF) "last surrogate"
			#(16rF0 16r80 16r80 16r80) "first four byte overlong"
			#(16rF0 16r8F 16rBF 16rBF) "last four byte overlong"
			#(16rF4 16r9F 16rBF 16rBF) "greater than U+10FFFF"
		) collect: [:each | self stringFrom: each]
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF8Test >> outputCollection [
	^ self decodedUTF8String
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF8Test >> streamConverterClass [
	^ XMLUTF8StreamConverter
]
