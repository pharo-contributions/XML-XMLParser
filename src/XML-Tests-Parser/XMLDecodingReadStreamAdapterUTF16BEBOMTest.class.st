Class {
	#name : #XMLDecodingReadStreamAdapterUTF16BEBOMTest,
	#superclass : #XMLDecodingReadStreamAdapterUTF16BETest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF16BEBOMTest >> invalidStreamCollection [
	^ self invalidEncodedInputCollectionWithBOM
]

{ #category : #testing }
XMLDecodingReadStreamAdapterUTF16BEBOMTest >> isDetecting [
	^ true
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF16BEBOMTest >> streamCollection [
	^ self inputCollectionWithBOM
]
