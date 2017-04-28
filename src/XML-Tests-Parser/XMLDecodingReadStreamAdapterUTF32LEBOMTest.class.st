Class {
	#name : #XMLDecodingReadStreamAdapterUTF32LEBOMTest,
	#superclass : #XMLDecodingReadStreamAdapterUTF32LETest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF32LEBOMTest >> invalidStreamCollections [
	^ self invalidEncodedInputCollectionsWithBOM
]

{ #category : #testing }
XMLDecodingReadStreamAdapterUTF32LEBOMTest >> isDetecting [
	^ true
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF32LEBOMTest >> streamCollection [
	^ self inputCollectionWithBOM
]
