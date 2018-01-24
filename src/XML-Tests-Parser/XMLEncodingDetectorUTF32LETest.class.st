Class {
	#name : #XMLEncodingDetectorUTF32LETest,
	#superclass : #XMLEncodingDetectorTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #testing }
XMLEncodingDetectorUTF32LETest class >> isAbstract [
	^ false
]

{ #category : #accessing }
XMLEncodingDetectorUTF32LETest >> explicitStreamConverterClass [
	^ XMLUTF32LittleEndianStreamConverter
]

{ #category : #accessing }
XMLEncodingDetectorUTF32LETest >> implicitEncodedStrings [
	^ self stringsFromAll:
		#(
			#(16r01 16r00 16r00 16r00)
			#(16r0F 16r00 16r00 16r00)
			#(16r7F 16r00 16r00 16r00))
]

{ #category : #accessing }
XMLEncodingDetectorUTF32LETest >> implicitStreamConverterClass [
	^ XMLImplicitUTF32LittleEndianStreamConverter
]
