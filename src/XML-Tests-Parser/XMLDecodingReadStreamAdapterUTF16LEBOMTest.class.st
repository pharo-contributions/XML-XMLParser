Class {
	#name : #XMLDecodingReadStreamAdapterUTF16LEBOMTest,
	#superclass : #XMLDecodingReadStreamAdapterUTF16LETest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF16LEBOMTest >> invalidStreamCollections [
	^ self invalidEncodedInputCollectionsWithBOM
]

{ #category : #testing }
XMLDecodingReadStreamAdapterUTF16LEBOMTest >> isDetecting [
	^ true
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF16LEBOMTest >> streamCollection [
	^ self inputCollectionWithBOM
]
