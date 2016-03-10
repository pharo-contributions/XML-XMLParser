Class {
	#name : #XMLDecodingReadStreamAdapterByteTest,
	#superclass : #XMLDecodingReadStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLDecodingReadStreamAdapterByteTest >> encodedInvalidCharacters [
	^ self stringFrom:
		#(16rD800
			16rDBFF
			16rDC00
			16rD8FF
			16r11FFFF)
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterByteTest >> streamConverterClass [
	^ XMLByteStreamConverter
]
