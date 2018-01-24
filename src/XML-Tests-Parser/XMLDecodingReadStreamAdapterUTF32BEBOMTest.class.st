Class {
	#name : #XMLDecodingReadStreamAdapterUTF32BEBOMTest,
	#superclass : #XMLDecodingReadStreamAdapterUTF32BETest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF32BEBOMTest >> invalidStreamCollections [
	^ self invalidEncodedInputCollectionsWithBOM
]

{ #category : #testing }
XMLDecodingReadStreamAdapterUTF32BEBOMTest >> isDetecting [
	^ true
]
