Extension { #name : #XMLFileStreamWriteStreamFactory }

{ #category : #'*XML-Parser-GemstoneCompatibility' }
XMLFileStreamWriteStreamFactory classSide >> fileWriteStreamOn: aPath [
	^ (Smalltalk at: #FileStream) write: aPath
]
