Class {
	#name : #XMLDecodingReadStreamAdapterUTF8Test,
	#superclass : #XMLDecodingReadStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF8Test >> encodedInvalidCharacters [
	^ self stringFrom:
		#(16rED 16rA0 16r80
			16rED 16rAF 16rBF
			16rED 16rB0 16r80
			16rED 16rA3 16rBF
			16rF4 16r9F 16rBF 16rBF)
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
