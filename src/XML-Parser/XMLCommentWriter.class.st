"
Generates a comment; XMLWriter>>comment: should normally suffice.
"
Class {
	#name : #XMLCommentWriter,
	#superclass : #XMLEmbeddedMarkupWriter,
	#category : #'XML-Parser-Writers'
}

{ #category : #private }
XMLCommentWriter >> writeEpilogue [
	self writer nextPutAll: '-->'
]

{ #category : #private }
XMLCommentWriter >> writePrologue [	
	self writer
		cr;
		nextPutAll: '<!--'
]
